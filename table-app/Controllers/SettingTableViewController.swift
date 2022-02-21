//
//  ViewController.swift
//  table-app
//
//  Created by Alexandr Kozorez on 07.02.2022.
//

import UIKit

final class SettingTableViewController: UITableViewController {
    let settings = Setting.defaultSettingsList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ячейка с переключателем"
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        NetworkManager().fetch { (news) in
            print(news)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let baseCell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier) as? SettingTableViewCell else {
            return SettingTableViewCell()
        }
        baseCell.setupData(settingData: settings[indexPath.item])
        return baseCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
