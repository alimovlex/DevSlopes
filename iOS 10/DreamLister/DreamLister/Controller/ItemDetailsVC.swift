//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by robot on 5/7/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var titleField: CustomTextField!;
    @IBOutlet weak var PriceField: CustomTextField!;
    @IBOutlet weak var detailsField: CustomTextField!;
    @IBOutlet weak var storePicker: UIPickerView!;
    @IBOutlet weak var thumgImg: UIImageView!;
    
    var stores = [Store]();
    var itemToEdit: Item?;
    var imagePicker: UIImagePickerController!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing));
        view.addGestureRecognizer(tap);
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil);
        }
        
        titleField.delegate = self;
        PriceField.delegate = self;
        detailsField.delegate = self;
        
        storePicker.delegate = self;
        storePicker.dataSource = self;
        
        imagePicker = UIImagePickerController();
        imagePicker.delegate = self;
        
        getStores();
        
        if itemToEdit != nil {
            
            loadItemData();
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row];
        return store.name;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count;
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // update when selected
    }
    
    func generateStores() {
        if #available(iOS 10.0, *) {
        let store = Store(context: context)
        store.name = "Best Buy";
        let store2 = Store(context: context)
        store2.name = "Tesla Dealership";
        let store3 = Store(context: context)
        store3.name = "Frys Electronics";
        let store4 = Store(context: context)
        store4.name = "Target";
        let store5 = Store(context: context)
        store5.name = "Amazon";
        let store6 = Store(context: context)
        store6.name = "K Mart";
            
            ad.saveContext();
        } else {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Store",
        in: context);
        let store = Store(entity: entityDescription!, insertInto: context);
        store.name = "Best Buy";
        let store2 = Store(entity: entityDescription!, insertInto: context);
        store2.name = "Tesla Dealership";
        let store3 = Store(entity: entityDescription!, insertInto: context);
        store3.name = "Frys Electronics";
        let store4 = Store(entity: entityDescription!, insertInto: context);
        store4.name = "Target";
        let store5 = Store(entity: entityDescription!, insertInto: context);
        store5.name = "Amazon";
        let store6 = Store(entity: entityDescription!, insertInto: context);
        store6.name = "K Mart";
            
            ad.saveContext();
        }
    }
    
    func getStores() {
        
        if !UserDefaults.standard.bool(forKey: "ExecuteOnce") {
            generateStores();
            UserDefaults.standard.set(true, forKey: "ExecuteOnce")
        }
        
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest();
        
        do {
            
            self.stores = try context.fetch(fetchRequest);
            self.storePicker.reloadAllComponents();
            
        } catch {
            //handle the error
        }
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        if #available(iOS 10.0, *) {
            var item: Item!; //app crash, if there is no database
            let picture = Image(context: context);
            picture.image = thumgImg.image;
            
            
            
            if itemToEdit == nil {
                item = Item(context: context);
            } else {
                
                item = itemToEdit;
            }
            
            item.toImage = picture;
            
            if let title = titleField.text {
                item.title = title;
            }
            
            if let price = PriceField.text {
                
                item.price = (price as NSString).doubleValue;
            }
            
            if let details = detailsField.text {
                
                item.details = details;
            }
            
            item.toStore = stores[storePicker.selectedRow(inComponent: 0)];
            
            ad.saveContext();
            
        } else {
            let entityDescription = NSEntityDescription.entity(forEntityName: "Item",
            in: context);
            let imageDescription = NSEntityDescription.entity(forEntityName: "Image",
            in: context);
            
            var item:Item!;
            let picture = Image(entity: imageDescription!, insertInto: context);
            picture.image = thumgImg.image;
            
            
            if itemToEdit == nil {
                
                item = Item(entity: entityDescription!, insertInto: context);
            } else {
                
                item = itemToEdit;
            }
            
            item.toImage = picture;
            
            if let title = titleField.text {
                item.title = title;
            }
            
            if let price = PriceField.text {
                
                item.price = (price as NSString).doubleValue;
            }
            
            if let details = detailsField.text {
                
                item.details = details;
            }
            
            item.toStore = stores[storePicker.selectedRow(inComponent: 0)];
            
            ad.saveContext();
        }
        
        navigationController?.popViewController(animated: true);
    }
    
    func loadItemData() {
        
        if let item = itemToEdit {
            
            titleField.text = item.title;
            PriceField.text = "\(item.price)";
            detailsField.text = item.details;
            
            thumgImg.image = item.toImage?.image as? UIImage;
            
            if let store = item.toStore {
                
                var index = 0;
                repeat {
                    
                    let s = stores[index];
                    if s.name == store.name {
                        
                        storePicker.selectRow(index, inComponent: 0, animated: false);
                        break;
                    }
                    index += 1;
                    
                } while (index < stores.count)
            }
        }
    }
    
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        
        if itemToEdit != nil {
            context.delete(itemToEdit!);
            ad.saveContext();
        }
        
        navigationController?.popViewController(animated: true);
        
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        
        present(imagePicker, animated: true, completion: nil);
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            thumgImg.image = img;
        }
        
        imagePicker.dismiss(animated: true, completion: nil);
    }
    
    //hiding the keyboard on return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case titleField:
            textField.resignFirstResponder();
            PriceField.becomeFirstResponder();
        case PriceField:
            textField.resignFirstResponder();
            detailsField.becomeFirstResponder();
        case detailsField:
            textField.resignFirstResponder();
        default:
            textField.resignFirstResponder();
        }
        return true;
    }
    

}
