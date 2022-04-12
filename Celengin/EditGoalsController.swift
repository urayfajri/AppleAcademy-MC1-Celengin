//
//  EditGoalsController.swift
//  Celengin
//
//  Created by Arief Ramadhan on 11/04/22.
//

import UIKit

class EditGoalsController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var goalNameTextFieldEdit: UITextField!
    @IBOutlet weak var goalTargetTextFieldEdit: UITextField!
    @IBOutlet weak var goalDeadlineTextFieldEdit: UITextField!
    @IBOutlet weak var goalBreakdownTextFieldEdit: UITextField!
    @IBOutlet weak var goalNotesTextViewEdit: UITextView!
    
    @IBOutlet weak var validateGoalNameEdit: UILabel!
    @IBOutlet weak var validateGoalTargetEdit: UILabel!
    @IBOutlet weak var validateGoalDeadlineEdit: UILabel!
    @IBOutlet weak var validateGoalBreakdownEdit: UILabel!
    
    @IBOutlet weak var submitGoalButtonEdit: UIButton!
    
    var datePicker: UIDatePicker!
    var pickerView = UIPickerView()
    
    let breakdownList = ["Weekly", "Monthly", "Yearly"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        resetForm()
        setUpElements()
    }
    
    func setUpElements() {
        
        Utilities.styleTextField(goalNameTextFieldEdit)
        Utilities.styleTextField(goalTargetTextFieldEdit)
        Utilities.styleTextView(goalNotesTextViewEdit)
        Utilities.styleFilledButton(submitGoalButtonEdit)
        
        setUpDatePicker()
        setBreakdown()
    }
    
    func resetForm() {
        submitGoalButtonEdit.isEnabled = false
        
        validateGoalNameEdit.isHidden = false
        validateGoalTargetEdit.isHidden = false
        validateGoalDeadlineEdit.isHidden = false
        validateGoalBreakdownEdit.isHidden = true
        
        // message validation
        validateGoalNameEdit.text = "Goal Name is Required"
        validateGoalTargetEdit.text = "Goal Target is Required"
        validateGoalDeadlineEdit.text = "Goal Deadline is Required"
        
        // empty text field
        goalNameTextFieldEdit.text = ""
        goalTargetTextFieldEdit.text = ""
        goalDeadlineTextFieldEdit.text = ""
        goalBreakdownTextFieldEdit.text = "Monthly"
        goalNotesTextViewEdit.text = ""
        
    }
    
    func setUpDatePicker() {
        
        datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200))
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        self.goalDeadlineTextFieldEdit.inputView = datePicker
        let toolBar: UIToolbar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        
        let spaceButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action:nil)
        
        let doneButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.tapOnDoneBut))
        
        toolBar.setItems([spaceButton, doneButton], animated: true)
        
        self.goalDeadlineTextFieldEdit.inputAccessoryView = toolBar
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breakdownList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breakdownList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        goalBreakdownTextFieldEdit.text = breakdownList[row]
        
        if let goalBreakdown = goalBreakdownTextFieldEdit.text
        {
            if let errorMessage = invalidGoalBreakdown(goalBreakdown)
            {
                validateGoalBreakdownEdit.text = errorMessage
                validateGoalBreakdownEdit.isHidden = false
            } else
            {
                validateGoalBreakdownEdit.isHidden = true
            }
        }
        checkValidForm()
    }
    
    func setBreakdown() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        goalBreakdownTextFieldEdit.inputView = pickerView
        
        // Default value
        goalBreakdownTextFieldEdit.text = breakdownList[1]
    }
    
    @objc func dateChanged(){
        let dateFormat = DateFormatter()
        
        dateFormat.dateStyle = .medium
        self.goalDeadlineTextFieldEdit.text = dateFormat.string(from: datePicker.date)
        
        if let goalDeadline = self.goalDeadlineTextFieldEdit.text
        {
            if let errorMessage = invalidGoalDeadline(goalDeadline)
            {
                validateGoalDeadlineEdit.text = errorMessage
                validateGoalDeadlineEdit.isHidden = false
            } else
            {
                validateGoalDeadlineEdit.isHidden = true
            }
        }
        checkValidForm()
    }
    
    @objc func tapOnDoneBut() {
        goalDeadlineTextFieldEdit.resignFirstResponder()
    }
    
    @IBAction func goalNameChanged(_ sender: Any) {
        if let goalName = goalNameTextFieldEdit.text
        {
            if let errorMessage = invalidGoalName(goalName)
            {
                validateGoalNameEdit.text = errorMessage
                validateGoalNameEdit.isHidden = false
            } else
            {
                validateGoalNameEdit.isHidden = true
            }
        }
        checkValidForm()
    }
    
    @IBAction func goalTargetChanged(_ sender: Any) {
        if let goalTarget = goalTargetTextFieldEdit.text
        {
            if let errorMessage = invalidGoalTarget(goalTarget)
            {
                validateGoalTargetEdit.text = errorMessage
                validateGoalTargetEdit.isHidden = false
            } else
            {
                validateGoalTargetEdit.isHidden = true
            }
        }
        checkValidForm()
    }
    
    @IBAction func goalDeadlineChanged(_ sender: Any) {
        if let goalDeadline = goalDeadlineTextFieldEdit.text
        {
            if let errorMessage = invalidGoalDeadline(goalDeadline)
            {
                validateGoalDeadlineEdit.text = errorMessage
                validateGoalDeadlineEdit.isHidden = false
            } else
            {
                validateGoalDeadlineEdit.isHidden = true
            }
        }
        checkValidForm()
    }
    
    @IBAction func goalBreakdownChanged(_ sender: Any) {
        if let goalBreakdown = goalBreakdownTextFieldEdit.text
        {
            if let errorMessage = invalidGoalBreakdown(goalBreakdown)
            {
                validateGoalBreakdownEdit.text = errorMessage
                validateGoalBreakdownEdit.isHidden = false
            } else
            {
                validateGoalBreakdownEdit.isHidden = true
            }
        }
        checkValidForm()
    }
    
    @IBAction func submitGoalTapped(_ sender: Any) {
        if goalNotesTextViewEdit.text.isEmpty
        {
            goalNotesTextViewEdit.text = ""
        }
        
        resetForm()
    }
    
    
    func invalidGoalName(_ value: String) -> String? {
        
        if value.isEmpty
        {
            return "Goal Name is Required"
        }
        return nil
    }
    
    func invalidGoalTarget(_ value: String) -> String? {
        
        let set = CharacterSet(charactersIn: value)
        if !CharacterSet.decimalDigits.isSuperset(of: set)
        {
            return "Goal Target must contain only digits"
        }
        if value.isEmpty
        {
            return "Goal Target is Required"
        }
        return nil
    }
    
    func invalidGoalDeadline(_ value: String) -> String? {
        
        if value.isEmpty
        {
            return "Goal Deadline is Required"
        }
        return nil
    }
    
    func invalidGoalBreakdown(_ value: String) -> String? {
        
        if value.isEmpty
        {
            return "Goal Breakdown is Required"
        }
        
        if !(value == "Weekly" || value == "Monthly" || value == "Yearly")
        {
            return "Goal Breakdown is not available"
        }
        return nil
    }
    
    func checkValidForm() {
        if(validateGoalNameEdit.isHidden && validateGoalTargetEdit.isHidden && validateGoalDeadlineEdit.isHidden && validateGoalBreakdownEdit.isHidden)
        {
            submitGoalButtonEdit.isEnabled = true
        }
        else
        {
            submitGoalButtonEdit.isEnabled = false
        }
        
    }
}
