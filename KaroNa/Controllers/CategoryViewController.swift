//
//  CategoryViewController.swift
//  KaroNa
//
//  Created by Vishnu V Ram on 1/30/19.
//  Copyright © 2019 Shannthini. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    let realm = try! Realm()
    var categotyListArray: Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategoriesList()
        let pathToRealmDatabase = Realm.Configuration.defaultConfiguration.fileURL
        print(pathToRealmDatabase!)
    }
    
    // MARK: - TableView delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! ToDoListViewController
        
        if let indexPathOfSelectedRow = tableView.indexPathForSelectedRow {
            destinationViewController.selectedCategory = categotyListArray![indexPathOfSelectedRow.row]
        }
        
    }

    // MARK: - Tableview data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categotyListArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categotyListArray?[indexPath.row].name ?? "No categoties added"
        return cell
    }
    
    
    //MARK: - CURD From coreData
    
    func saveCategory(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving data, \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategoriesList() {
        
        categotyListArray = realm.objects(Category.self)
        tableView.reloadData()
        
    }

    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add a new category", message: "", preferredStyle: .alert)
        
        var textField  = UITextField()
        alert.addTextField { (field) in
            field.placeholder = "Category Name"
            textField = field
        }
        
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            
            if ((textField.text?.count)! > 0) {
            let newCategory = Category()
                newCategory.name = textField.text!
                self.saveCategory(category: newCategory)
            }else {
                print("No category added")
            }
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
