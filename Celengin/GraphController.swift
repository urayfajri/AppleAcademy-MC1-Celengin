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
    @IBOutlet weak var overallOverview: UILabel!
    @IBOutlet weak var detailOverview: UILabel!
    
    var barChart = BarChartView()
    var goals = [Goals]()
    var pickerTitle = [String]()
    var entries = [BarChartDataEntry]()
    var Overview = [Double]()
    var pickerView = UIPickerView()
    var overviewTexts = [String]()
    var segmentIndex: Int = 1
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var totalProgress: Double = 0
    var totalTarget: Double = 0
    
    var alltransactions = [Transaction]()
    var goalRespectiveTransactions = [Transaction]()
    var goalDate: Int = 3
    var goalMonth: Int = 3
    var goalYear: Int = 2022
    
    let currentDate = Date()
    let calendar = Calendar.current
  

    override func viewDidLoad() {
        super.viewDidLoad()
        goalTextField.inputView = pickerView
        fetchGoals()
        
        
        let count = goals.count
        
        pickerTitle.append("Semua Goal")
        
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
        
        for x in 0..<Overview.count
        {
            entries.append(BarChartDataEntry(x: Double(x), y: Overview[x]))
        }
        
        let set = BarChartDataSet(entries: entries)
        let data = BarChartData(dataSet: set)
        barChart.data = data

        view.addSubview(barChart)
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl)
    {
        let components = calendar.dateComponents([.day,.month, .year], from: currentDate)
        let currDate = components.day
        let currMonth = components.month
        let currYear = components.year
        segmentIndex = sender.selectedSegmentIndex
        
        if sender.selectedSegmentIndex == 0
        {
            Overview.removeAll()
            overviewTexts.removeAll()
            detailOverview.text = ""
            entries.removeAll()
            
            var d_start = goalDate
            var d_end = goalDate + 6
            var d_count = 1
            var m_count = goalMonth
            
            while m_count <= currMonth!
            {
                while d_start <= 30 && d_end <= 30
                {
                    var money: Double = 0
                    
                    for x in 0..<goalRespectiveTransactions.count
                    {
                        let comps =  calendar.dateComponents([.day, .month], from: goalRespectiveTransactions[x].date!)
                        
                        if comps.day! >= d_start && comps.day! <= d_end && comps.month == m_count
                        {
                            if goalRespectiveTransactions[x].type == "Income"
                            {
                                money += Double(goalRespectiveTransactions[x].amount)
                            }
                            
                            else
                            {
                                money -= Double(goalRespectiveTransactions[x].amount)
                            }
                        }
                    }
                    
                    Overview.append(money)
                    overviewTexts.append("Minggu \(d_count): Rp. \(money)\n")
                    d_start += 7
                    d_end += 7
                    d_count += 1
                    
                }
                
                m_count += 1
                d_start = 1
                d_end = 7
            }
            
            
            for x in 0..<overviewTexts.count
            {
                detailOverview.text?.append("\(overviewTexts[x])" )
            }
            
            for x in 0..<Overview.count
            {
                entries.append(BarChartDataEntry(x: Double(x), y: Overview[x]))
            }
            
            let set = BarChartDataSet(entries: entries)
            let data = BarChartData(dataSet: set)
            barChart.data = data
            barChart.notifyDataSetChanged()
        }
        
        else if sender.selectedSegmentIndex == 1
        {
            
            Overview.removeAll()
            overviewTexts.removeAll()
            detailOverview.text = " "
            entries.removeAll()
            
                var m_count = goalMonth
                
                
                if currYear! == goalYear
                {
                    while m_count <= currMonth!
                    {
                        var money: Double = 0
                        
                        for y in 0..<goalRespectiveTransactions.count
                        {
                            let comps = calendar.dateComponents([.month], from: goalRespectiveTransactions[y].date!)
                            
                            if comps.month == m_count
                            {
                                if goalRespectiveTransactions[y].type == "Income"
                                {
                                    money += Double(goalRespectiveTransactions[y].amount)
                                }
                                
                                else
                                {
                                    money -= Double(goalRespectiveTransactions[y].amount)
                                }
                               
                            }
                            
                            
                        }
                        
                        Overview.append(money)
                        overviewTexts.append("Bulan \(m_count): Rp. \(money)\n")
                        m_count += 1
                    }
                    
                    for x in 0..<overviewTexts.count
                    {
                        detailOverview.text?.append("\(overviewTexts[x])" )
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
                            
                            for y in 0..<goalRespectiveTransactions.count
                            {
                                let comps = calendar.dateComponents([.month], from: goalRespectiveTransactions[y].date!)
                                
                                if comps.month == m_count
                                {
                                    if goalRespectiveTransactions[y].type == "Income"
                                    {
                                        money += Double(goalRespectiveTransactions[y].amount)
                                    }
                                    
                                    else
                                    {
                                        money -= Double(goalRespectiveTransactions[y].amount)
                                    }
                                   
                                }
                                
                            }
                            
                            Overview.append(money)
                            overviewTexts.append("Bulan \(m_count): Rp. \(money)\n")
                            m_count += 1
                        }
                        
                        y_count += 1
                    }
                    
                    for x in 0..<overviewTexts.count
                    {
                        detailOverview.text?.append("\(overviewTexts[x])" )
                    }
                }
                
            for x in 0..<Overview.count
            {
                entries.append(BarChartDataEntry(x: Double(x), y: Overview[x]))
            }
            
            let set = BarChartDataSet(entries: entries)
            let data = BarChartData(dataSet: set)
            barChart.data = data
            barChart.notifyDataSetChanged()
        }
        
        else
        {
            Overview.removeAll()
            overviewTexts.removeAll()
            detailOverview.text = " "
            entries.removeAll()
            
            var money: Double = 0
            
            if currYear! == goalYear
            {
                for x in 0..<goalRespectiveTransactions.count
                {
                    if goalRespectiveTransactions[x].type == "Income"
                    {
                        money += Double(goalRespectiveTransactions[x].amount)
                    }
                    
                    else
                    {
                        money -= Double(goalRespectiveTransactions[x].amount)
                    }
                }
                
                overviewTexts.append("Tahun 1: Rp. \(money)")
                Overview.append(money)
            }
            
            else
            {
                var y_count = goalYear
                
                while y_count<=currYear!
                {
                    for x in 0..<goalRespectiveTransactions.count
                    {
                        let comps = calendar.dateComponents([.year], from: goalRespectiveTransactions[x].date!)
                        
                        if comps.year == y_count
                        {
                            if goalRespectiveTransactions[x].type == "Income"
                            {
                                money += Double(goalRespectiveTransactions[x].amount)
                            }
                            else
                            {
                                money -= Double(goalRespectiveTransactions[x].amount)
                            }
                        }
                       
                    }
                    
                    overviewTexts.append("Tahun \(y_count): Rp. \(money)\n")
                    y_count+=1
                    
                }
            }
            
            for x in 0..<overviewTexts.count
            {
                detailOverview.text?.append("\(overviewTexts[x])" )
            }
            
            for x in 0..<Overview.count
            {
                entries.append(BarChartDataEntry(x: Double(x), y: Overview[x]))
            }
            
            let set = BarChartDataSet(entries: entries)
            let data = BarChartData(dataSet: set)
            barChart.data = data
            
            barChart.notifyDataSetChanged()
            
        }
    }
    
    func fetchOverview()
    {
        totalTarget = 0
        totalProgress = 0
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
        
        if goalTextField.text == "Semua Goal"
        {
            
            goalRespectiveTransactions.removeAll()
            
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
            
            for x in 0..<goals.count
            {
                totalTarget += goals[x].target 
            }
            
            for y in 0..<goalRespectiveTransactions.count
            {
                if goalRespectiveTransactions[y].type == "Income"
                {
                    totalProgress += goalRespectiveTransactions[y].amount
                }
                
                else
                {
                    totalProgress -= goalRespectiveTransactions[y].amount
                }
               
            }
            
            overallOverview.text = "Tabungan Rp. \(totalProgress) dari total Rp. \(totalTarget)"
        }
        
        else
        {
            
            goalRespectiveTransactions.removeAll()
            
            for x in 0..<alltransactions.count
            {
                if alltransactions[x].goals!.name == goalTextField.text
                {
                    goalRespectiveTransactions.append(alltransactions[x])
                }
            }
            
            if(!goalRespectiveTransactions.isEmpty)
            {
                
                let goalComps = calendar.dateComponents([.day, .month, .year], from: (goalRespectiveTransactions[0].goals?.createdAt)!)
                
                goalDate = goalComps.day!
                goalMonth = goalComps.month!
                goalYear = goalComps.year!
                totalTarget = goalRespectiveTransactions[0].goals!.target
                totalProgress = goalRespectiveTransactions[0].goals!.progress 
                
                overallOverview.text = "Tabungan Rp. \(totalProgress) dari total Rp. \(totalTarget)"
                
            }
            
            else
            {
                overallOverview.text = " "
            }
            
            
        }
        
        if segmentIndex == 0
        {
            Overview.removeAll()
            overviewTexts.removeAll()
            detailOverview.text = ""
            
            var d_start = goalDate
            var d_end = goalDate + 6
            var m_count = goalMonth
            
            while m_count <= currMonth!
            {
                while d_start <= 30 && d_end <= 30
                {
                    var money: Double = 0
                    
                    for x in 0..<goalRespectiveTransactions.count
                    {
                        let comps =  calendar.dateComponents([.day, .month], from: goalRespectiveTransactions[x].date!)
                        
                        if comps.day! >= d_start && comps.day! <= d_end && comps.month == m_count
                        {
                            if goalRespectiveTransactions[x].type == "Income"
                            {
                                money += Double(goalRespectiveTransactions[x].amount)
                            }
                            
                            else
                            {
                                money -= Double(goalRespectiveTransactions[x].amount)
                            }
                        }
                    }
                    
                    Overview.append(money)
                    d_start += 7
                    d_end += 7
                    
                }
                
                m_count += 1
                d_start = 1
                d_end = 7
            }
            barChart.notifyDataSetChanged()
        }
        
        else if segmentIndex == 1
        {
            
            Overview.removeAll()
            overviewTexts.removeAll()
            detailOverview.text = " "
            
                var m_count = goalMonth
                
                
                if currYear! == goalYear
                {
                    while m_count <= currMonth!
                    {
                        var money: Double = 0
                        
                        for y in 0..<goalRespectiveTransactions.count
                        {
                            let comps = calendar.dateComponents([.month], from: goalRespectiveTransactions[y].date!)
                            
                            if comps.month == m_count
                            {
                                if goalRespectiveTransactions[y].type == "Income"
                                {
                                    money += Double(goalRespectiveTransactions[y].amount)
                                }
                                
                                else
                                {
                                    money -= Double(goalRespectiveTransactions[y].amount)
                                }
                               
                            }
                            
                            
                        }
                        
                        Overview.append(money)
                        m_count += 1
                    }
                    
                    barChart.notifyDataSetChanged()
                
                }
                
                else
                {
                    var y_count = goalYear
                    
                    while y_count <= currYear!
                    {
                        while m_count <= currMonth!
                        {
                            
                            var money: Double = 0
                            
                            for y in 0..<goalRespectiveTransactions.count
                            {
                                let comps = calendar.dateComponents([.month], from: goalRespectiveTransactions[y].date!)
                                
                                if comps.month == m_count
                                {
                                    if goalRespectiveTransactions[y].type == "Income"
                                    {
                                        money += Double(goalRespectiveTransactions[y].amount)
                                    }
                                    
                                    else
                                    {
                                        money -= Double(goalRespectiveTransactions[y].amount)
                                    }
                                   
                                }
                                
                            }
                            
                            Overview.append(money)
                            m_count += 1
                        }
                        
                        y_count += 1
                    }
                    
                    barChart.notifyDataSetChanged()
                
                }
                
        }
        
        else
        {
            Overview.removeAll()
            overviewTexts.removeAll()
            detailOverview.text = " "
            
            var money: Double = 0
            
            if currYear! == goalYear
            {
                for x in 0..<goalRespectiveTransactions.count
                {
                    if goalRespectiveTransactions[x].type == "Income"
                    {
                        money += Double(goalRespectiveTransactions[x].amount)
                    }
                    else
                    {
                        money -= Double(goalRespectiveTransactions[x].amount)
                    }
                }
                
                overviewTexts.append("Tahun 1: Rp. \(money)")
                Overview.append(money)
                
                barChart.notifyDataSetChanged()
            }
            
            else
            {
                var y_count = goalYear
                
                while y_count<=currYear!
                {
                    for x in 0..<goalRespectiveTransactions.count
                    {
                        let comps = calendar.dateComponents([.year], from: goalRespectiveTransactions[x].date!)
                        
                        if comps.year == y_count
                        {
                            if goalRespectiveTransactions[x].type == "Income"
                            {
                                money += Double(goalRespectiveTransactions[x].amount)
                            }
                            else
                            {
                                money -= Double(goalRespectiveTransactions[x].amount)
                            }
                        }
                       
                    }
                    
                    Overview.append(money)
                    y_count+=1
                    barChart.notifyDataSetChanged()
                    
                }
            }
            
        }
        
       
        
    }
    
    func setSummary()
    {
        
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
        barChart.notifyDataSetChanged()
    }
    
    
    
}
