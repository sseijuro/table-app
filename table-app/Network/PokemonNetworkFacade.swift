//
//  PokemonNetworkFacade.swift
//  table-app
//
//  Created by Alexandr Kozorez on 23.02.2022.
//

import Foundation

final class PokemonNetworkFacade {
    
    typealias ResultPokemon = Result<Pokemon, NetworkServiceError>
    let baseAPIPath = "https://pokeapi.co/api/v2/pokemon/"
    
    private let infoQueue = DispatchQueue(label: "pokemon.network.facade.info.queue", qos: .background)
    private let infoGroup = DispatchGroup()
    
    private let baseNetworkService = BaseNetworkService()
    
    private func fetchPokemonInfo(withId id: Int, completion: @escaping (Pokemon?) -> Void) {
        guard let url = URL(string: baseAPIPath + String(id)) else {
            completion(nil)
            return
        }
        baseNetworkService.getJson(url: url) { (result: ResultPokemon) in
            switch result {
                case .failure(let error):
                    print(error)
                    completion(nil)
                    return
                case .success(let pokemon):
                    completion(pokemon)
                    return
            }
        }
    }
    
    func fetchPokemonList(begin: Int, end: Int, completion: @escaping ([Int: Pokemon]) -> Void) {
        var pokemons = [Int: Pokemon]()
        for id in begin...end {
            infoGroup.enter()
            infoQueue.async { [weak self] in
                self?.fetchPokemonInfo(withId: id) { [weak self] pokemon in
                    self?.infoQueue.async(flags: .barrier) { [weak self] in
                        if let pokemon = pokemon {
                            pokemons[id] = pokemon
                        }
                        self?.infoGroup.leave()
                    }
                }
            }
        }
        infoGroup.wait()
        completion(pokemons)
    }
    
    func fetchPokemonImage(url: URL, completion: @escaping (Data?) -> Void) {
        baseNetworkService.getData(url: url) { result in
            switch result {
                case .failure(let error):
                    print(error)
                    completion(nil)
                    return
                case .success(let data):
                    completion(data)
                    return
            }
        }
    }
}
