//
//  CategoryViewController.swift
//  KaroNa
//
//  Created by Vishnu V Ram on 1/30/19.
//  Copyright © 2019 Shannthini. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categotyListArray = [Categories]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategoriesList()
        let filePathToCoreData = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(filePathToCoreData)
    }
    
    // MARK: - TableView delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! ToDoListViewController
        
        if let indexPathOfSelectedRow = tableView.indexPathForSelectedRow {
            destinationViewController.selectedCategory = categotyListArray[indexPathOfSelectedRow.row]
        }
        
    }

    // MARK: - Tableview data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categotyListArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categotyListArray[indexPath.row].name
        
        return cell
    }
    
    
    //MARK: - CURD From coreData
    
    func saveCategory() {
        do {
            try context.save()
        } catch {
            print("Error saving data, \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategoriesList(with request:NSFetchRequest<Categories> = Categories.fetchRequest() ) {
        
        do {
            categotyListArray = try context.fetch(request)
        } catch {
            print("Error loading data, \(error)")
        }
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
            let newCategory = Categories(context: self.context)
            
                newCategory.name = textField.text
                self.categotyListArray.append(newCategory)
                self.saveCategory()
            }else {
                print("No category added")
            }
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
