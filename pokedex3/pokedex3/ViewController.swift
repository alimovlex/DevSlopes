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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let charmander = Pokemon(name: "Charmander", pokedexId: 4);
        collection.dataSource = self;
        collection.delegate = self;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let pokemon = Pokemon(name: "Pokemon", pokedexId: indexPath.row);
            cell.configureCell(pokemon: pokemon);
            
            return cell;
        } else {
            return UICollectionViewCell();
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return 30;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105);
        
    }

}

