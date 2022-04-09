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
    
    
    @IBOutlet weak var validateGoalName: UILabel!
    @IBOutlet weak var validateGoalTarget: UILabel!
    @IBOutlet weak var validateGoalDeadline: UILabel!
    
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
        
        validateGoalName.isHidden = false
        validateGoalTarget.isHidden = false
        validateGoalDeadline.isHidden = false
        
        // message validation
        validateGoalName.text = "Goal Name is Required"
        validateGoalTarget.text = "Goal Target is Required"
        validateGoalDeadline.text = "Goal Deadline is Required"
        
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
        if(validateGoalName.isHidden && validateGoalTarget.isHidden && validateGoalDeadline.isHidden)
        {
            submitGoalButton.isEnabled = true
        }
        else
        {
            submitGoalButton.isEnabled = false
        }
    }
    
}
