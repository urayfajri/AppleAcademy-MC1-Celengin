//
//  ViewController.swift
//  Celengin
//
//  Created by Kathleen Febiola Susanto on 29/03/22.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{


    @IBOutlet weak var goalTable: UITableView!
    private var datas = [Goals]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapAdd))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
        dummyData()
        getAllItems()
        
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
        
        // Do any additional setup after loading the view.
        // test
    }
    
    @objc func tapAdd()
    {
        
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
        goals3.status = false
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
        
        let deadlineSort = NSSortDescriptor(key: "deadline", ascending: false)
        let progressSort = NSSortDescriptor(key: "progress", ascending: false)
        
        fetchRequest.sortDescriptors = [deadlineSort, progressSort]
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


}

