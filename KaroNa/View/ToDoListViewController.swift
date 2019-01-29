//
//  ViewController.swift
//  KaroNa
//
//  Created by Vishnu V Ram on 1/23/19.
//  Copyright © 2019 Shannthini. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("item.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let items = defaults.array(forKey: "ItemListArray") as? [String] {
//            itemArray = items
//        }
        print (dataFilePath!)
        loadItems()

   }

    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark: .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItemsToList()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //Mark - add new items to the list

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add new Item to the list", message: "", preferredStyle: .alert)
        var textField = UITextField()
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            self.saveItemsToList()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItemsToList() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error,\(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems() {
        let decoder = PropertyListDecoder()
        
        if let data = try? Data(contentsOf: dataFilePath!){
            
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
               print("Error,\(error)")
            }
        }
    }
    
}

