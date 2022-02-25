//
//  Pokemon.swift
//  table-app
//
//  Created by Alexandr Kozorez on 22.02.2022.
//

import Foundation

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let weight: Int
    let types: [PokemonTypeContainer]
    let sprites: SpritesList
}

struct PokemonTypeContainer: Decodable {
    let type: PokemonType
}

struct PokemonType: Decodable {
    let name: String
}

struct SpritesList: Decodable {
    let front_default: String
}

extension Pokemon {
    var title: String {
        "#\(id): " + name.uppercased()
    }
    
    var subtitle: String {
        "The \(name) has \(weight) weight."
    }
    
    var caption: String {
        "Types: " + types.map { $0.type.name }.joined(separator: ", ")
    }
    
    var avatar: URL? {
        URL(string: sprites.front_default)
    }
}
