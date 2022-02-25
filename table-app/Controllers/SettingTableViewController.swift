//
//  ViewController.swift
//  table-app
//
//  Created by Alexandr Kozorez on 07.02.2022.
//

import UIKit

final class SettingTableViewController: UITableViewController {
    private let pokemonFacade = PokemonNetworkFacade()
    private var settings = [Setting]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ячейка с переключателем"
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            SettingTableViewCell.self,
            forCellReuseIdentifier: SettingTableViewCell.identifier
        )
        
        tableView.register(
            PreloaderTableViewCell.self,
            forCellReuseIdentifier: PreloaderTableViewCell.identifier
        )
    }
    
    private func loadChunkOfData(begin: Int = 1, end: Int = 25) {
        pokemonFacade.fetchPokemonList(begin: begin, end: end) { [weak self] (pokemonDict) in
            pokemonDict.sorted { $0.value.id < $1.value.id }.forEach { pokemonEl in
                self?.settings.append(Setting(
                    title: pokemonEl.value.title,
                    avatar: pokemonEl.value.avatar,
                    subtitle: pokemonEl.value.subtitle,
                    caption: pokemonEl.value.caption
                ))
            }
            self?.tableView.reloadData()
        }
    }
    
}

extension SettingTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == settings.count {
            guard let preloaderCell = tableView.dequeueReusableCell(
                withIdentifier: PreloaderTableViewCell.identifier
            ) as? PreloaderTableViewCell else { return PreloaderTableViewCell() }
            preloaderCell.setupPreloader()
            return preloaderCell
        }
        
        guard let baseCell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier) as? SettingTableViewCell else {
            return SettingTableViewCell()
        }
        
        let concreteSetting = settings[indexPath.item]
        
        baseCell.setupText(
            title: concreteSetting.title,
            subtitle: concreteSetting.subtitle,
            caption: concreteSetting.caption
        )
        
        DispatchQueue.main.async { [weak self, baseCell/*, indexPath*/] in
            guard let self = self,
                  let imageURL = concreteSetting.avatar//,
//                  let visibleRows = tableView.indexPathsForVisibleRows
            else { return }
//            let baseCellIsOnScreen = visibleRows.contains(indexPath)
            self.pokemonFacade.fetchPokemonImage(url: imageURL) { /*[baseCellIsOnScreen]*/ imageData in
//                if baseCellIsOnScreen {
                    baseCell.setupImage(data: imageData)
//                }
            }
        }
        
        return baseCell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.item == settings.count {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.loadChunkOfData(begin: self.settings.count + 1, end: self.settings.count + 26)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.item == settings.count ? 75 : UITableView.automaticDimension
    }
    
}
