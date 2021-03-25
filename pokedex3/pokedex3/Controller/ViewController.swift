//
//  ViewController.swift
//  pokedex3
//
//  Created by robot on 3/23/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!;
    @IBOutlet weak var searchBar: UISearchBar!;
    
    var pokemon = [Pokemon]();
    var filteredPokemon = [Pokemon]();
    var musicPlayer: AVAudioPlayer!;
    var inSearchMode = false;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        //dismissing the keyboard on tap
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing));
        view.addGestureRecognizer(tap);
        //let charmander = Pokemon(name: "Charmander", pokedexId: 4);
        collection.dataSource = self;
        collection.delegate = self;
        searchBar.delegate = self;
        
        searchBar.returnKeyType = UIReturnKeyType.done;
        
        parsePokemonCSV();
        initAudio();
    }
    
    func initAudio() {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!;
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!);
            musicPlayer.prepareToPlay();
            musicPlayer.numberOfLoops = -1;
            musicPlayer.play();
        } catch let err as NSError {
            print(err.debugDescription);
        }
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
            
            let poke: Pokemon!;
            
            if inSearchMode {
                
                poke = filteredPokemon[indexPath.row];
                cell.configureCell(pokemon: poke);
            } else {
                
                poke = pokemon[indexPath.row];
                cell.configureCell(pokemon: poke);
            }
            
            cell.configureCell(pokemon: poke);
            
            return cell;
        } else {
            return UICollectionViewCell();
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredPokemon.count;
        }
        
        return pokemon.count;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105);
        
    }
    
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        
        if musicPlayer.isPlaying {
            musicPlayer.pause();
            sender.alpha = 0.2;
        } else {
            musicPlayer.play();
            sender.alpha = 1.0;
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false;
            collection.reloadData();
            //view.endEditing(true); //dismiss the keyboard on deletion
        } else {
            inSearchMode = true;
            
            let lower = searchBar.text!.lowercased();
            filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil});
            collection.reloadData();
            
        }
    }
    //dismissing the keyboard on search button pressed
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        inSearchMode = false;
        self.searchBar.endEditing(true);
        //view.endEditing(true); forcing the view to dismiss the keyboard
    }
    
}

