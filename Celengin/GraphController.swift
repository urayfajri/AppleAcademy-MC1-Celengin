//
//  GraphController.swift
//  Celengin
//
//  Created by Kathleen Febiola Susanto on 02/04/22.
//

import UIKit
import Charts
import CoreData

class GraphController: UIViewController, ChartViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
   
    @IBOutlet weak var goalTextField: UITextField!
    
    var barChart = BarChartView()
    var goals = [Goals]()
    var pickerTitle = [String]()
    var entries = [BarChartDataEntry]()
    var Overview = [Double]()
    var pickerView = UIPickerView()
    var segmentIndex: Int = 1
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        goalTextField.inputView = pickerView
        
        fetchGoals()
        
        let count = goals.count
        
        pickerTitle.append("All Goals")
        
        for x in 0..<count
        {
            pickerTitle.append(goals[x].name!)
        }
        
        goalTextField.text = pickerTitle[0]
        goalTextField.textAlignment = .center
        
        barChart.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Overview = []
        fetchOverview()
        barChart.frame = CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: self.view.frame.size.width)
        barChart.center = view.center
        view.addSubview(barChart)
        
        for x in 0..<Overview.count
        {
            entries.append(BarChartDataEntry(x: Double(x), y: Overview[x]))
        }
        
        let set = BarChartDataSet(entries: entries)
        let data = BarChartData(dataSet: set)
        barChart.data = data
        
        
    }
    
    func fetchOverview()
    {
        var alltransactions = [Transaction]()
        var goalRespectiveTransactions = [Transaction]()
        var goalDate: Int = 3
        var goalMonth: Int = 3
        var goalYear: Int = 2022
        
        let currentDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day,.month, .year], from: currentDate)
        let currDate = components.day
        let currMonth = components.month
        let currYear = components.year
        
        do
        {
            alltransactions  = try context.fetch(Transaction.fetchRequest())
        }
        
        catch
        {
            
        }
        
        if goalTextField.text == "All Goals"
        {
            goalRespectiveTransactions.append(contentsOf: alltransactions)
            
            for x in 0..<goalRespectiveTransactions.count
            {
                let goalComps = calendar.dateComponents([.day, .month, .year], from: (goalRespectiveTransactions[x].goals?.createdAt)!)
                
                if goalDate > goalComps.day!
                {
                    goalDate = goalComps.day!
                }
                
                if goalMonth > goalComps.month!
                {
                    goalMonth = goalComps.month!
                }
                
                if goalYear > goalComps.year!
                {
                    goalYear = goalComps.year!
                }
            }
        }
        
        else
        {
            for x in 0..<alltransactions.count
            {
                if alltransactions[x].goals!.name == goalTextField.text
                {
                    goalRespectiveTransactions.append(alltransactions[x])
                }
            }
            
            let goalComps = calendar.dateComponents([.day, .month, .year], from: (goalRespectiveTransactions[0].goals?.createdAt)!)
            
            goalDate = goalComps.day!
            goalMonth = goalComps.month!
            goalYear = goalComps.year!
        }
        
      
        
        if segmentIndex == 0
        {
            
        }
        
        else if segmentIndex == 1
        {
            
            
            for y in 0..<goalRespectiveTransactions.count
            {
                var m_count = goalMonth
                
                
                if currYear! == goalYear
                {
                    while m_count <= currMonth!
                    {
                        var money: Double = 0
                        
                        let comps = calendar.dateComponents([.month], from: goalRespectiveTransactions[y].date!)
                        
                        if comps.month == m_count
                        {
                            money += Double(goalRespectiveTransactions[y].amount)
                        }
                        
                        Overview.append(money)
                        m_count += 1
                    }
                
                }
                
                else
                {
                    var y_count = goalYear
                    
                    while y_count <= currYear!
                    {
                        while m_count <= currMonth!
                        {
                            var money: Double = 0
                            
                            let comps = calendar.dateComponents([.month, .year], from: goalRespectiveTransactions[y].date!)
                            
                            if comps.month == m_count && comps.year == y_count
                            {
                                money += Double(goalRespectiveTransactions[y].amount)
                            }
                            
                            Overview.append(money)
                            m_count += 1
                        }
                        
                        y_count += 1
                    }
                }
                
            }
        }
        
        else
        {
            
        }
        
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl)
    {
        segmentIndex = sender.selectedSegmentIndex
    }
    
    func fetchGoals()
    {
        do
        {
            goals = try context.fetch(Goals.fetchRequest())
    
            
        }
        catch
        {
            
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerTitle.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerTitle[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        goalTextField.text = pickerTitle[row]
        goalTextField.resignFirstResponder()
        fetchOverview()
    }
    
    
    
}
