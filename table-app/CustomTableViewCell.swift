//
//  CustomTableViewCell.swift
//  table-app
//
//  Created by Alexandr Kozorez on 07.02.2022.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {
    static let identifier = String(describing: CustomTableViewCell.self)
    
    lazy var customImageView = initImageView()
    lazy var cellTitle = initCellTitle()
    lazy var cellSubTitle = initCellParagraph()
    lazy var cellCaption = initCellParagraph()
    
    lazy var switchView = initSwitchView()
    
//    lazy var contentBottomConstraint = contentView.bottomAnchor.constraint(equalTo: cellTitle.bottomAnchor)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: CustomTableViewCellSize.elementWithYOffset).isActive = true
        selectionStyle = .none
        
        contentView.addSubview(customImageView)
        contentView.addSubview(switchView)
        setupImageView()
        setupSwitchView()
        
        contentView.addSubview(cellTitle)
        contentView.addSubview(cellSubTitle)
        contentView.addSubview(cellCaption)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadSettingData(data: Setting) {
        cellTitle.text = data.title
        cellTitle.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor,
                                           constant: CustomTableViewCellSize.offsetX.rawValue).isActive = true
        cellTitle.widthAnchor.constraint(equalTo: contentView.widthAnchor,
                                         constant: CustomTableViewCellSize.widthDifference).isActive = true
        
        guard let subTitle = data.subtitle else {
            cellTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            return
        }
        
        cellTitle.topAnchor.constraint(equalTo: contentView.topAnchor,
                                       constant: CustomTableViewCellSize.offsetY.rawValue).isActive = true
        cellTitle.bottomAnchor.constraint(equalTo: cellSubTitle.topAnchor).isActive = true
        
        cellSubTitle.text = subTitle
        
        cellSubTitle.topAnchor.constraint(equalTo: cellTitle.bottomAnchor).isActive = true
        cellSubTitle.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor,
                                              constant: CustomTableViewCellSize.offsetX.rawValue).isActive = true
        cellSubTitle.widthAnchor.constraint(equalTo: cellTitle.widthAnchor).isActive = true
    
        guard let caption = data.caption else {
            cellSubTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                 constant: -CustomTableViewCellSize.offsetY.rawValue).isActive = true
            return
        }
        
        cellSubTitle.bottomAnchor.constraint(equalTo: cellCaption.topAnchor).isActive = true
        cellCaption.text = caption
        
        NSLayoutConstraint.activate([
            cellCaption.topAnchor.constraint(equalTo: cellSubTitle.bottomAnchor),
            cellCaption.widthAnchor.constraint(equalTo: cellTitle.widthAnchor),
            cellCaption.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor,
                                                 constant: CustomTableViewCellSize.offsetX.rawValue),
            cellCaption.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                constant: -CustomTableViewCellSize.offsetY.rawValue)
        ])
    }
}

extension CustomTableViewCell {
    func initImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = CustomTableViewCellSize.element.rawValue / 2
        imageView.backgroundColor = .darkGray
        return imageView
    }
    
    func setupImageView() {
        NSLayoutConstraint.activate([
            customImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor,
                                                 constant: CustomTableViewCellSize.offsetY.rawValue),
            customImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                     constant: CustomTableViewCellSize.offsetX.rawValue),
            customImageView.widthAnchor.constraint(equalToConstant: CustomTableViewCellSize.element.rawValue),
            customImageView.heightAnchor.constraint(equalToConstant: CustomTableViewCellSize.element.rawValue)
        ])
    }
    
    func initCustomLabel(fontSize: CGFloat, lines: Int, weight: UIFont.Weight, color: UIColor = .black) -> UILabel {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = lines
        title.textColor = color
        title.font = .systemFont(ofSize: fontSize, weight: weight)
        return title
    }
    
    func initCellTitle() -> UILabel {
        initCustomLabel(fontSize: CustomTableViewCellSize.title.rawValue, lines: 2, weight: .semibold)
    }
    
    func initCellParagraph() -> UILabel {
        initCustomLabel(fontSize: CustomTableViewCellSize.paragraph.rawValue, lines: 0, weight: .regular, color: .gray)
    }
    
    func initSwitchView() -> UISwitch {
        let switchView = UISwitch()
        switchView.translatesAutoresizingMaskIntoConstraints = false
        switchView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        return switchView
    }
    
    func setupSwitchView() {
        NSLayoutConstraint.activate([
            switchView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                            constant: CustomTableViewCellSize.offsetY.rawValue),
            switchView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                 constant: CustomTableViewCellSize.offsetX.rawValue),
            switchView.widthAnchor.constraint(equalToConstant: CustomTableViewCellSize.element.rawValue * 2),
            switchView.heightAnchor.constraint(equalToConstant: CustomTableViewCellSize.element.rawValue)
        ])
    }
    
}
