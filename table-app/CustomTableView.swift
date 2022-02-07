//
//  CustomTableView.swift
//  table-app
//
//  Created by Alexandr Kozorez on 07.02.2022.
//

import UIKit

final class CustomTableView: UITableView {
    init(frame: CGRect) {
        super.init(frame: frame, style: .plain)
        register(CustomTableViewCell.self,
                 forCellReuseIdentifier: CustomTableViewCell.identifier)
//        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
