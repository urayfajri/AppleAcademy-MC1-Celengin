//
//  FormAddViewController.swift
//  Celengin
//
//  Created by Uray Muhamad Noor Fajri Widiansyah on 07/04/22.
//

import UIKit

class FormAddViewController: UIViewController {
    

    @IBOutlet weak var goalNameTextField: UITextField!
    @IBOutlet weak var goalTargetTextField: UITextField!
    @IBOutlet weak var goalDeadlineTextField: UITextField!
    @IBOutlet weak var goalNotesTextView: UITextView!
    
    @IBOutlet weak var validateGoalNameTextField: UILabel!
    @IBOutlet weak var validateGoalTargetTextField: UILabel!
    @IBOutlet weak var validateGoalDeadlineTextField: UILabel!
    
    
    @IBOutlet weak var submitGoalButton: UIButton!
    
    var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
        setUpDatePicker()
        resetForm()
    }
    
    func setUpElements() {
        
        Utilities.styleTextField(goalNameTextField)
        Utilities.styleTextField(goalTargetTextField)
        Utilities.styleTextView(goalNotesTextView)
        Utilities.styleFilledButton(submitGoalButton)
    }
    
    func resetForm() {
        submitGoalButton.isEnabled = false
        
        validateGoalNameTextField.isHidden = false
        validateGoalTargetTextField.isHidden = false
        validateGoalDeadlineTextField.isHidden = false
        
        // message validation
        validateGoalNameTextField.text = "Goal Name is Required"
        validateGoalTargetTextField.text = "Goal Target is Required"
        validateGoalDeadlineTextField.text = "Goal Deadline is Required"
        
        // empty text field
        goalNameTextField.text = ""
        goalTargetTextField.text = ""
        goalDeadlineTextField.text = ""
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

    @objc func dateChanged(){
        let dateFormat = DateFormatter()
        
        dateFormat.dateStyle = .medium
        self.goalDeadlineTextField.text = dateFormat.string(from: datePicker.date)
        
        if let goalDeadline = self.goalDeadlineTextField.text
        {
            if let errorMessage = invalidGoalDeadline(goalDeadline)
            {
                validateGoalDeadlineTextField.text = errorMessage
                validateGoalDeadlineTextField.isHidden = false
            } else
            {
                validateGoalDeadlineTextField.isHidden = true
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
                validateGoalNameTextField.text = errorMessage
                validateGoalNameTextField.isHidden = false
            } else
            {
                validateGoalNameTextField.isHidden = true
            }
        }
        checkValidForm()
    }
    
    @IBAction func goalTargetChanged(_ sender: Any) {
        
        if let goalTarget = goalTargetTextField.text
        {
            if let errorMessage = invalidGoalTarget(goalTarget)
            {
                validateGoalTargetTextField.text = errorMessage
                validateGoalTargetTextField.isHidden = false
            } else
            {
                validateGoalTargetTextField.isHidden = true
            }
        }
        checkValidForm()
    }
    

    @IBAction func goalDeadlineChanged(_ sender: Any) {
        
        if let goalDeadline = goalDeadlineTextField.text
        {
            if let errorMessage = invalidGoalDeadline(goalDeadline)
            {
                validateGoalDeadlineTextField.text = errorMessage
                validateGoalDeadlineTextField.isHidden = false
            } else
            {
                validateGoalDeadlineTextField.isHidden = true
            }
        }
        checkValidForm()
    }
    
    @IBAction func submitGoalTapped(_ sender: Any) {
        if goalNotesTextView.text.isEmpty
        {
            goalNotesTextView.text = ""
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
    
    func checkValidForm() {
        if(validateGoalNameTextField.isHidden && validateGoalTargetTextField.isHidden && validateGoalDeadlineTextField.isHidden)
        {
            submitGoalButton.isEnabled = true
        }
        else
        {
            submitGoalButton.isEnabled = false
        }
    }
    
}
