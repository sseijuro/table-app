//
//  PreloaderTableViewCell.swift
//  table-app
//
//  Created by Alexandr Kozorez on 22.02.2022.
//

import Foundation
import UIKit

final class PreloaderTableViewCell: UITableViewCell {
    static let identifier = String(describing: PreloaderTableViewCell.self)
    let preloader = UIActivityIndicatorView.init(style: .medium)
    lazy var preloaderCenterXAnchor = preloader.centerXAnchor.constraint(equalTo: centerXAnchor)
    lazy var preloaderCenterYAnchor = preloader.centerYAnchor.constraint(equalTo: centerYAnchor)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.clipsToBounds = true
        contentView.addSubview(preloader)
        preloader.translatesAutoresizingMaskIntoConstraints = false
        preloader.startAnimating()
    }
    
    func setupPreloader() {
        cleanUp()
        NSLayoutConstraint.activate([
            preloaderCenterXAnchor,
            preloaderCenterYAnchor
        ])
    }
    
    func cleanUp() {
        NSLayoutConstraint.deactivate([
            preloaderCenterYAnchor,
            preloaderCenterXAnchor
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
