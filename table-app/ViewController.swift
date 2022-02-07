//
//  ViewController.swift
//  table-app
//
//  Created by Alexandr Kozorez on 07.02.2022.
//

import UIKit

final class ViewController: UIViewController {
    let settings = Setting.defaultSettingsList
    
    var customTableView: CustomTableView? {
        view as? CustomTableView
    }
    
    override func loadView() {
        super.loadView()
        view = CustomTableView(frame: view.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ячейка с переключателем"
        customTableView?.delegate = self
        customTableView?.dataSource = self
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier) as! CustomTableViewCell
        cell.loadSettingData(data: settings[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}
