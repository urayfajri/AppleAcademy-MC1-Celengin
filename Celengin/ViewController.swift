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
    var testID: Int = 0
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapAdd))
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
        
//        dummyData()
        getAllItems()
        goalTable.rowHeight = UITableView.automaticDimension
        goalTable.estimatedRowHeight = 600
        
        if(datas.isEmpty)
        {
            goalTable.isHidden = true
            let label = UILabel()
            label.text = "Kamu belum menambahkan goal. Ayo tambahkan goal pertamamu sekarang!"
            label.textColor = .gray
            label.textAlignment = .center
            label.frame = CGRect(x: 0, y: view.frame.size.height / 2, width: view.frame.size.width, height: 100)
            view.addSubview(label)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAllItems()
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let goals = datas[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Hapus") { _ , indexPath in
            let alertControl = UIAlertController(title: "Hapus Goal", message: "Apakah kamu yakin ingin menghapus goal ini?", preferredStyle: .alert)
            alertControl.addAction(UIAlertAction(title: "Iya", style: .destructive, handler: {_ in
                self.deleteItem(item: goals)
                self.datas.remove(at: indexPath.row)
            }))
            
            alertControl.addAction(UIAlertAction(title: "Tidak", style: .cancel, handler: {_ in
                alertControl.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alertControl, animated: true)
        }
        
    
        let pinActionTitle = goals.status ? "Lepas Pin" : "Pin"
        
        let pinAction = UITableViewRowAction(style: .normal, title: pinActionTitle) { [self]_ , indexPath in
            self.datas[indexPath.row].status.toggle()
            let cell = (self.goalTable.cellForRow(at: indexPath) as? goalCell)!
            cell.pin.isHidden = self.datas[indexPath.row].status ? false: true
            do
            {
                try context.save()
            }
            catch
            {
                
            }
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
        dateFormatter.dateFormat = "d MMMM, YY"
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currData = datas[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "goal_detail") as! GoalsDetailController
        vc.goal = datas[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
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
        
        var dateComp2 = DateComponents()
        dateComp2.year = 2022
        dateComp2.month = 1
        dateComp2.day = 1
        dateComp2.timeZone = TimeZone(abbreviation: "GMT")
        dateComp2.hour = 10
        dateComp2.minute = 0
        
        goals1.createdAt = userCalendar.date(from: dateComp2)
        goals2.createdAt = userCalendar.date(from: dateComp2)
        goals3.createdAt = userCalendar.date(from: dateComp2)
        
        var dateIncome = DateComponents()
        dateIncome.year = 2022
        dateIncome.month = 2
        dateIncome.day = 20
        dateIncome.timeZone = TimeZone(abbreviation: "GMT")
        dateIncome.hour = 12
        dateIncome.minute = 34
        
        let income1 = Transaction(context: context)
        income1.name = "Gaji Bulan Februari"
        income1.amount = 2500000
        income1.date = userCalendar.date(from: dateIncome)
        income1.resources = "Gaji Feb"
        income1.notes = "Nambah 2 setengah"
        income1.type = "Income"
        
        let outcome1 = Transaction(context: context)
        outcome1.name = "Beli pulsa"
        outcome1.amount = 100000
        outcome1.date = userCalendar.date(from: dateIncome)
        outcome1.resources = "Pulsa Telkomsel"
        outcome1.notes = "Beli pulsa telkomsel 100000"
        outcome1.type = "Outcome"
        
        var dateIncome2 = DateComponents()
        dateIncome2.year = 2022
        dateIncome2.month = 1
        dateIncome2.day = 28
        dateIncome2.timeZone = TimeZone(abbreviation: "GMT")
        dateIncome2.hour = 12
        dateIncome2.minute = 34
        
        let income2 = Transaction(context: context)
        income2.name = "Gaji Bulan Januari"
        income2.amount = 2600000
        income2.date = userCalendar.date(from: dateIncome2)
        income2.resources = "Gaji Januari"
        income2.notes = "Nambah 2.6 juta"
        income2.type = "Income"
        
        let outcome2 = Transaction(context: context)
        outcome2.name = "Beli pulsa"
        outcome2.amount = 100000
        outcome2.date = userCalendar.date(from: dateIncome2)
        outcome2.resources = "Pulsa Telkomsel"
        outcome2.notes = "Beli pulsa telkomsel 100000"
        outcome2.type = "Outcome"
        
        var dateIncome3 = DateComponents()
        dateIncome3.year = 2022
        dateIncome3.month = 3
        dateIncome3.day = 26
        dateIncome3.timeZone = TimeZone(abbreviation: "GMT")
        dateIncome3.hour = 12
        dateIncome3.minute = 34
        
        let income3 = Transaction(context: context)
        income3.name = "Gaji Bulan Maret"
        income3.amount = 5200000
        income3.date = userCalendar.date(from: dateIncome3)
        income3.resources = "Gaji Maret"
        income3.notes = "Nambah 5.2 juta"
        income3.type = "Income"
        
        let outcome3 = Transaction(context: context)
        outcome3.name = "Beli pulsa"
        outcome3.amount = 100000
        outcome3.date = userCalendar.date(from: dateIncome3)
        outcome3.resources = "Pulsa Telkomsel"
        outcome3.notes = "Beli pulsa telkomsel 100000"
        outcome3.type = "Outcome"
        
        let income4 = Transaction(context: context)
        income4.name = "Nabung ke Paris"
        income4.amount = 1000000
        income4.date = userCalendar.date(from: dateIncome2)
        income4.resources = "Gaji Januari"
        income4.notes = "No Notes"
        income4.type = "Income"
        
        let income5 = Transaction(context: context)
        income5.name = "Nabung lagi"
        income5.amount = 4000000
        income5.date = userCalendar.date(from: dateIncome3)
        income5.resources = "Angpao Imlek"
        income5.notes = "Dapet angpao"
        income5.type = "Income"
        
        goals2.addToTransaction(income1)
        goals2.addToTransaction(outcome1)
        goals2.addToTransaction(income2)
        goals2.addToTransaction(outcome2)
        goals2.addToTransaction(income3)
        goals2.addToTransaction(outcome3)
        goals3.addToTransaction(income4)
        goals3.addToTransaction(income5)
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
    
    func deleteItem(item: Goals)
    {
        context.delete(item)
        
        do
        {
            try context.save()
            getAllItems()
        }
        catch
        {
            
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

