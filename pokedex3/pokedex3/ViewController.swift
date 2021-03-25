//
//  ViewController.swift
//  pokedex3
//
//  Created by robot on 3/23/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collection: UICollectionView!;
    
    var pokemon = [Pokemon]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let charmander = Pokemon(name: "Charmander", pokedexId: 4);
        collection.dataSource = self;
        collection.delegate = self;
        
        parsePokemonCSV();
    }
    
    func parsePokemonCSV() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!;
        
        do {
            let csv = try CSV(contentsOfURL: path);
            let rows = csv.rows;
            print(rows);
            
            for row in rows {
                
                let pokeId = Int(row["id"]!)!;
                let name = row["identifier"]!;
                
                let poke = Pokemon(name: name, pokedexId: pokeId);
                pokemon.append(poke);
            }
            
        } catch let err as NSError {
            print(err.debugDescription);
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let poke = pokemon[indexPath.row];
            cell.configureCell(pokemon: poke);
            
            return cell;
        } else {
            return UICollectionViewCell();
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return pokemon.count;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105);
        
    }

}

