//
//  ViewController.swift
//  ArtBookProject
//
//  Created by Naman Manchanda on 14/11/20.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var tableView: UITableView!
    var nameArray = [String]()
    var idArray = [UUID]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        getData()
    }
    
    @objc func addButtonClicked(){
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    // MARK: - Getting data from Database using Core Data
    func getData(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchRequest.returnsObjectsAsFaults = false
        do{
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject]{
                if let name = result.value(forKey: "name") as? String{
                    nameArray.append(name)
                }
                if let id = result.value(forKey: "id") as? UUID{
                    idArray.append(id)
                }
            }
            self.tableView.reloadData()
            
            
        }catch{
            print("error")
        }
    }
    
    
    // MARK: - Table View Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        
        
        return cell
    }
}









