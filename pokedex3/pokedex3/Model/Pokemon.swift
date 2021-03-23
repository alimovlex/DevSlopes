//
//  Pokemon.swift
//  pokedex3
//
//  Created by robot on 3/23/21.
//  Copyright © 2021 robot. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name: String!;
    private  var _pokedexId: Int!;
    
    var name: String {
        
        return _name;
    }
    
    var pokedexId: Int {
        
        return _pokedexId;
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name;
        self._pokedexId = pokedexId;
    }
}
