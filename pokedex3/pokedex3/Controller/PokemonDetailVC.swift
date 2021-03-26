//
//  PokemonDetailVC.swift
//  pokedex3
//
//  Created by robot on 3/26/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {


    @IBOutlet weak var nameLbl: UILabel!;
    var pokemon: Pokemon!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        nameLbl.text = pokemon.name;
        
    }
    
}
