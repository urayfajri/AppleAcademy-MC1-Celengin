//
//  GraphController.swift
//  Celengin
//
//  Created by Kathleen Febiola Susanto on 02/04/22.
//

import UIKit
import Charts

class GraphController: UIViewController, ChartViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
   
    
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var goalTextField: UITextField!
    
    var barChart = BarChartView()
    var goals = [Goals]()
    var pickerTitle = [String]()
    var entries = [BarChartDataEntry]()
    var pickerView = UIPickerView()
    
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
        
        barChart.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
        showButton.backgroundColor = .darkGray
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        barChart.frame = CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: self.view.frame.size.width)
        barChart.center = view.center
        view.addSubview(barChart)
        
        for x in 0..<10
        {
            entries.append(BarChartDataEntry(x: Double(x), y: Double(x)))
        }
        
        let set = BarChartDataSet(entries: entries)
        let data = BarChartData(dataSet: set)
        barChart.data = data
        
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl)
    {
        if sender.selectedSegmentIndex == 0
        {
            
        }
        
        else if sender.selectedSegmentIndex == 1
        {
            
        }
        
        else
        {
            
        }
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
    
}
