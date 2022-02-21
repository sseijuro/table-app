//
//  SettingsTableViewCell.swift
//  table-app
//
//  Created by Alexandr Kozorez on 20.02.2022.
//

import UIKit

final class SettingTableViewCell: UITableViewCell {
    static let identifier = String(describing: SettingTableViewCell.self)
    
    private lazy var imageViewIcon: UIImageView = SettingUIBuilder.setupImageView()
    private lazy var stateSwitch: UISwitch = SettingUIBuilder.setupSwitch()
    private lazy var titleLabel: UILabel = SettingUIBuilder.setupLabel(size: 14, color: .black, lines: 2)
    private lazy var subTitleLabel: UILabel = SettingUIBuilder.setupLabel()
    private lazy var captionLabel: UILabel = SettingUIBuilder.setupLabel()
    
    private lazy var titleCenterYConstraint = titleLabel.centerYAnchor
        .constraint(equalTo: contentView.centerYAnchor)
    private lazy var titleTopConstraint = titleLabel.topAnchor
        .constraint(equalTo: contentView.topAnchor, constant: Constant.offsetY)
    private lazy var subTitleBottomConstraint = subTitleLabel.bottomAnchor
        .constraint(equalTo: contentView.bottomAnchor, constant: -Constant.offsetY)
    private lazy var captionBottomConstraint = captionLabel.bottomAnchor
        .constraint(equalTo: contentView.bottomAnchor, constant: -Constant.offsetY)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.clipsToBounds = true
        contentView.addSubview(imageViewIcon)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(captionLabel)
        contentView.addSubview(stateSwitch)
        NSLayoutConstraint.activate(baseConstraintList)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(settingData: Setting) {
        titleLabel.text = settingData.title
        guard settingData.subtitle != nil else {
            titleCenterYConstraint.isActive = true
            return
        }
        
        subTitleLabel.text = settingData.subtitle
        titleTopConstraint.isActive = true
        guard settingData.caption != nil else {
            subTitleBottomConstraint.isActive = true
            return
        }
        
        captionLabel.text = settingData.caption
        captionBottomConstraint.isActive = true
    }
}

private extension SettingTableViewCell {
    struct SettingUIBuilder {
        static func setupImageView() -> UIImageView {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer.cornerRadius = Constant.elementSize / 2
            imageView.backgroundColor = .darkGray
            return imageView
        }
        
        static func setupLabel(size: CGFloat = 12, color: UIColor = .gray, lines: Int = 0) -> UILabel {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: size)
            label.textColor = color
            label.numberOfLines = lines
            return label
        }
        
        static func setupSwitch() -> UISwitch {
            let switchView = UISwitch()
            switchView.translatesAutoresizingMaskIntoConstraints = false
            switchView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            return switchView
        }
    }
    
    enum Constant {
        static let elementSize: CGFloat = 40
        static let offsetX: CGFloat = 20
        static let offsetY: CGFloat = 10
        static let titleSize: CGFloat = 13
        
        static var maxTitleWidthDifference: CGFloat {
            offsetX * 4 + elementSize * 2.25
        }
    }
    
    var baseConstraintList: [NSLayoutConstraint] { [
        imageViewIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.offsetY),
        imageViewIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.offsetX),
        imageViewIcon.widthAnchor.constraint(equalToConstant: Constant.elementSize),
        imageViewIcon.heightAnchor.constraint(equalToConstant: Constant.elementSize),
        imageViewIcon.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor,
                                              constant: -Constant.offsetY),

        stateSwitch.centerYAnchor.constraint(equalTo: imageViewIcon.centerYAnchor),
        stateSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.offsetX),
        stateSwitch.widthAnchor.constraint(equalToConstant: Constant.elementSize * 1.25),

        titleLabel.leadingAnchor.constraint(equalTo: imageViewIcon.trailingAnchor, constant: Constant.offsetX),
        titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor,
                                          constant: -Constant.maxTitleWidthDifference),

        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
        subTitleLabel.leadingAnchor.constraint(equalTo: imageViewIcon.trailingAnchor, constant: Constant.offsetX),
        subTitleLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),

        captionLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor),
        captionLabel.leadingAnchor.constraint(equalTo: imageViewIcon.trailingAnchor, constant: Constant.offsetX),
        captionLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
    ] }
    
}
