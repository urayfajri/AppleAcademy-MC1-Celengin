//
//  ViewController.swift
//  Celengin
//
//  Created by Kathleen Febiola Susanto on 29/03/22.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{


    @IBOutlet weak var goalTable: UITableView!
    @IBOutlet weak var searchView: UISearchBar!
    private var datas = [Goals]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapAdd))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
    
      
        
        dummyData()
        getAllItems()
        goalTable.rowHeight = UITableView.automaticDimension
        goalTable.estimatedRowHeight = 600
        
        if(datas.isEmpty)
        {
            goalTable.isHidden = true
            let label = UILabel()
            label.text = "You haven't created any goal. Start creating one now!"
            label.textColor = .gray
            label.textAlignment = .center
            label.frame = CGRect(x: 0, y: view.frame.size.height / 2, width: view.frame.size.width, height: 100)
            view.addSubview(label)
        }
    }
    
    @objc func tapAdd()
    {
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { _ , indexPath in
            let alertControl = UIAlertController(title: "Delete Item", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
            alertControl.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: {_ in
                self.datas.remove(at: indexPath.row)
                self.goalTable.deleteRows(at: [indexPath], with: .automatic)
            }))
            
            alertControl.addAction(UIAlertAction(title: "No", style: .cancel, handler: {_ in
                alertControl.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alertControl, animated: true)
        }
        
        let goals = datas[indexPath.row]
        let pinActionTitle = goals.status ? "Unpin" : "Pin"
        
        let pinAction = UITableViewRowAction(style: .normal, title: pinActionTitle) { _ , indexPath in
            self.datas[indexPath.row].status.toggle()
            let cell = (self.goalTable.cellForRow(at: indexPath) as? goalCell)!
            cell.pin.isHidden = self.datas[indexPath.row].status ? false: true
            self.getAllItems()
        }
        
        pinAction.backgroundColor = .darkGray
        
        return [deleteAction, pinAction]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM, YY"
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: "goal_cell", for: indexPath) as? goalCell)!
        cell.goalName.text = data.name
        
        let str_deadline = dateFormatter.string(from: data.deadline!)
        cell.deadline.text = "Deadline: \(str_deadline)"
        
        let decimals = Float(Float(data.progress) / Float(data.target))
        
        let percentage = Int(decimals * 100)
        
        cell.pin.isHidden = data.status ? false : true
        
        cell.percent.text = "\(percentage)%"
        return cell
    }
    
    func dummyData()
    {
        let goals1 = Goals(context: context)
        goals1.name = "Menabung buat ke Bali"
        goals1.target = 20000000
        goals1.breakdown = "Monthly"
        goals1.progress = 0
        goals1.status = false
        goals1.add_notes = "Semangat"
        
        let goals2 = Goals(context: context)
        goals2.name = "Menabung beli Rumah"
        goals2.target = 300000000
        goals2.breakdown = "Monthly"
        goals2.progress = 100000000
        goals2.status = false
        goals2.add_notes = "Semangat"
        
        let goals3 = Goals(context: context)
        goals3.name = "Menabung ke Paris"
        goals3.target = 20000000
        goals3.breakdown = "Monthly"
        goals3.progress = 5000000
        goals3.status = true
        goals3.add_notes = "Semangat"
        
        var dateComp = DateComponents()
        dateComp.year = 2022
        dateComp.month = 9
        dateComp.day = 27
        dateComp.timeZone = TimeZone(abbreviation: "GMT")
        dateComp.hour = 12
        dateComp.minute = 34
        
        let userCalendar = Calendar(identifier: .gregorian)
        goals1.deadline = userCalendar.date(from: dateComp)
        goals2.deadline = userCalendar.date(from: dateComp)
        goals3.deadline = userCalendar.date(from: dateComp)
    }
    
    func getAllItems()
    {
        let fetchRequest: NSFetchRequest<Goals> = Goals.fetchRequest()
        
        let pinnedSort = NSSortDescriptor(key: "status", ascending: false)
        let deadlineSort = NSSortDescriptor(key: "deadline", ascending: false)
        let progressSort = NSSortDescriptor(key: "progress", ascending: false)
        
        fetchRequest.sortDescriptors = [pinnedSort, deadlineSort, progressSort]
        do
        {
            datas = try context.fetch(fetchRequest)
            
            DispatchQueue.main.async
            {
                self.goalTable.reloadData()
            }
        }
        
        catch
        {
            //error
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchView.showsCancelButton = true
        
        if searchText == ""
        {
            getAllItems()
        }
        
        else
        {
            datas = []
            
            do
            {
                let filteredRequest: NSFetchRequest<Goals> = Goals.fetchRequest()
                let pred = NSPredicate(format: "name CONTAINS '\(searchText)'")
                
                filteredRequest.predicate = pred
                
                self.datas = try context.fetch(filteredRequest)
                
                DispatchQueue.main.async {
                    self.goalTable.reloadData()
                }
            }
            
            catch
            {
                
            }
        }
        
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchView.text = ""
        searchView.endEditing(true)
        getAllItems()
        searchView.showsCancelButton = false
    }
    

}

