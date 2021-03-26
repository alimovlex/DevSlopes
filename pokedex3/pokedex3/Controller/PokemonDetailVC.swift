//
//  PokemonDetailVC.swift
//  pokedex3
//
//  Created by robot on 3/26/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!;

    @IBOutlet weak var nameLbl: UILabel!;
    @IBOutlet weak var mainImg: UIImageView!;
    
    @IBOutlet weak var descriptionLbl: UILabel!;
    @IBOutlet weak var typeLbl: UILabel!;
    
    @IBOutlet weak var defenseLbl: UILabel!;
    
    @IBOutlet weak var heightLbl: UILabel!;
    @IBOutlet weak var pokedexLbl: UILabel!;
    @IBOutlet weak var weightLbl: UILabel!;
    @IBOutlet weak var attackLbl: UILabel!;
    @IBOutlet weak var currentEvoimg: UIImageView!;
    @IBOutlet weak var nextEvoimg: UIImageView!;
    @IBOutlet weak var evoLbl: UILabel!;
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        nameLbl.text = pokemon.name;
        
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil);
    }
    
}
