//
//  SettingsTableViewCell.swift
//  table-app
//
//  Created by Alexandr Kozorez on 20.02.2022.
//

import UIKit

final class SettingTableViewCell: UITableViewCell {
    static let identifier = String(describing: SettingTableViewCell.self)
    
    private lazy var imageViewIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = Constant.elementSize / 2
        imageView.backgroundColor = .darkGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var stateSwitch: UISwitch = {
        let switchView = UISwitch()
        switchView.translatesAutoresizingMaskIntoConstraints = false
        switchView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        return switchView
    }()
    
    private lazy var titleLabel = setupLabel(size: 14, color: .black, lines: 2)
    private lazy var subTitleLabel = setupLabel()
    private lazy var captionLabel = setupLabel()
    
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
    
    private func cleanUpLabels() {
        titleCenterYConstraint.isActive = false
        titleTopConstraint.isActive = false
        subTitleBottomConstraint.isActive = false
        captionBottomConstraint.isActive = false
        
        titleLabel.text = nil
        subTitleLabel.text = nil
        captionLabel.text = nil
    }
    
    func setupText(title: String, subtitle _subtitle: String?, caption _caption: String?) {
        cleanUpLabels()
        
        titleLabel.text = title
        guard let subtitle = _subtitle,
              !subtitle.isEmpty else {
            titleCenterYConstraint.isActive = true
            return
        }
        
        subTitleLabel.text = subtitle
        titleTopConstraint.isActive = true
        guard let caption = _caption,
              !caption.isEmpty else {
            subTitleBottomConstraint.isActive = true
            return
        }
        
        captionLabel.text = caption
        captionBottomConstraint.isActive = true
    }
    
    func cleanUpImageView() {
        DispatchQueue.main.async { [weak self] in
            self?.imageViewIcon.image = nil
            self?.imageViewIcon.backgroundColor = .darkGray
        }
    }
    
    func setupImage(data: Data?) {
        cleanUpImageView()
        guard let data = data else { return }
        DispatchQueue.main.async { [weak self] in
            self?.imageViewIcon.image = UIImage(data: data)
            self?.imageViewIcon.backgroundColor = .none
        }
    }
}

private extension SettingTableViewCell {
    func setupLabel(size: CGFloat = 12, color: UIColor = .gray, lines: Int = 0) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: size)
        label.textColor = color
        label.numberOfLines = lines
        return label
    }
    
    enum Constant {
        static let elementSize: CGFloat = 40
        static let offsetX: CGFloat = 20
        static let offsetY: CGFloat = 10
        static let titleSize: CGFloat = 13
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
        titleLabel.trailingAnchor.constraint(equalTo: stateSwitch.leadingAnchor, constant: -Constant.offsetX),
        
        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
        subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
        subTitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

        captionLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor),
        captionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
        captionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
    ] }
    
}
