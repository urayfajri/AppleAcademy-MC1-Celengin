//
//  FormAddViewController.swift
//  Celengin
//
//  Created by Uray Muhamad Noor Fajri Widiansyah on 07/04/22.
//

import UIKit

class FormAddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var goalNameTextField: UITextField!
    @IBOutlet weak var goalTargetTextField: UITextField!
    @IBOutlet weak var goalDeadlineTextField: UITextField!
    @IBOutlet weak var goalBreakdownTextField: UITextField!
    @IBOutlet weak var goalNotesTextView: UITextView!
    
    @IBOutlet weak var validateGoalName: UILabel!
    @IBOutlet weak var validateGoalTarget: UILabel!
    @IBOutlet weak var validateGoalDeadline: UILabel!
    @IBOutlet weak var validateGoalBreakdown: UILabel!
    
    @IBOutlet weak var submitGoalButton: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        
        Utilities.styleTextField(goalNameTextField)
        Utilities.styleTextField(goalTargetTextField)
        Utilities.styleTextView(goalNotesTextView)
        Utilities.styleFilledButton(submitGoalButton)
        
        setUpDatePicker()
        setBreakdown()
    }
    
    func resetForm() {
        submitGoalButton.isEnabled = false
        
        validateGoalName.isHidden = false
        validateGoalTarget.isHidden = false
        validateGoalDeadline.isHidden = false
        validateGoalBreakdown.isHidden = true
        
        // message validation
        validateGoalName.text = "Goal Name is Required"
        validateGoalTarget.text = "Goal Target is Required"
        validateGoalDeadline.text = "Goal Deadline is Required"
        
        // empty text field
        goalNameTextField.text = ""
        goalTargetTextField.text = ""
        goalDeadlineTextField.text = ""
        goalBreakdownTextField.text = "Monthly"
        goalNotesTextView.text = ""
        
    }
    
    func setUpDatePicker() {
        
        datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200))
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        self.goalDeadlineTextField.inputView = datePicker
        let toolBar: UIToolbar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        
        let spaceButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action:nil)
        
        let doneButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.tapOnDoneBut))
        
        toolBar.setItems([spaceButton, doneButton], animated: true)
        
        self.goalDeadlineTextField.inputAccessoryView = toolBar
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
        goalBreakdownTextField.text = breakdownList[row]
        
        if let goalBreakdown = goalBreakdownTextField.text
        {
            if let errorMessage = invalidGoalBreakdown(goalBreakdown)
            {
                validateGoalBreakdown.text = errorMessage
                validateGoalBreakdown.isHidden = false
            } else
            {
                validateGoalBreakdown.isHidden = true
            }
        }
        checkValidForm()
    }
    
    func setBreakdown() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        goalBreakdownTextField.inputView = pickerView
        
        // Default value
        goalBreakdownTextField.text = breakdownList[1]
    }
    
    @objc func dateChanged(){
        let dateFormat = DateFormatter()
        
        dateFormat.dateStyle = .medium
        self.goalDeadlineTextField.text = dateFormat.string(from: datePicker.date)
        
        if let goalDeadline = self.goalDeadlineTextField.text
        {
            if let errorMessage = invalidGoalDeadline(goalDeadline)
            {
                validateGoalDeadline.text = errorMessage
                validateGoalDeadline.isHidden = false
            } else
            {
                validateGoalDeadline.isHidden = true
            }
        }
        checkValidForm()
    }
    
    @objc func tapOnDoneBut() {
        goalDeadlineTextField.resignFirstResponder()
    }
    
    @IBAction func goalNameChanged(_ sender: Any) {
        if let goalName = goalNameTextField.text
        {
            if let errorMessage = invalidGoalName(goalName)
            {
                validateGoalName.text = errorMessage
                validateGoalName.isHidden = false
            } else
            {
                validateGoalName.isHidden = true
            }
        }
        checkValidForm()
    }
    
    @IBAction func goalTargetChanged(_ sender: Any) {
        if let goalTarget = goalTargetTextField.text
        {
            if let errorMessage = invalidGoalTarget(goalTarget)
            {
                validateGoalTarget.text = errorMessage
                validateGoalTarget.isHidden = false
            } else
            {
                validateGoalTarget.isHidden = true
            }
        }
        checkValidForm()
    }
    
    @IBAction func goalDeadlineChanged(_ sender: Any) {
        if let goalDeadline = goalDeadlineTextField.text
        {
            if let errorMessage = invalidGoalDeadline(goalDeadline)
            {
                validateGoalDeadline.text = errorMessage
                validateGoalDeadline.isHidden = false
            } else
            {
                validateGoalDeadline.isHidden = true
            }
        }
        checkValidForm()
    }
    
    @IBAction func goalBreakdownChanged(_ sender: Any) {
        if let goalBreakdown = goalBreakdownTextField.text
        {
            if let errorMessage = invalidGoalBreakdown(goalBreakdown)
            {
                validateGoalBreakdown.text = errorMessage
                validateGoalBreakdown.isHidden = false
            } else
            {
                validateGoalBreakdown.isHidden = true
            }
        }
        checkValidForm()
    }
    
    @IBAction func submitGoalTapped(_ sender: Any) {
        if goalNotesTextView.text.isEmpty
        {
            goalNotesTextView.text = ""
        }
        
        let newGoal = Goals(context: self.context)
        newGoal.name = goalNameTextField.text
        newGoal.add_notes = goalNotesTextView.text
        newGoal.breakdown = goalBreakdownTextField.text
        newGoal.target = Double(goalTargetTextField.text ?? "0") ?? 0.0
        newGoal.deadline = datePicker.date
        newGoal.createdAt = Date()
        newGoal.progress = 0
        newGoal.status = false
        
        do{
            try context.save()
            // balik ke satu halaman sebelumnnya
            self.navigationController?.popViewController(animated: true)
            
            // balik ke root controller (halaman pertama kali launch)
            // self.navigationController?.popToRootViewController(animated: true)

        }
        catch
        {
            
        }
        
        //resetForm()
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
        if(validateGoalName.isHidden && validateGoalTarget.isHidden && validateGoalDeadline.isHidden && validateGoalBreakdown.isHidden)
        {
            submitGoalButton.isEnabled = true
        }
        else
        {
            submitGoalButton.isEnabled = false
        }
    }
    
}
