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
    
    @IBOutlet weak var validateGoalNameTextField: UILabel!
    @IBOutlet weak var validateGoalTargetTextField: UILabel!
    
    @IBOutlet weak var submitGoalButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        resetForm()
    }
    
    func resetForm() {
        submitGoalButton.isEnabled = false
        
        validateGoalNameTextField.isHidden = false
        validateGoalTargetTextField.isHidden = false
        
        
        // message validation
        validateGoalNameTextField.text = "Goal Name is Required"
        validateGoalTargetTextField.text = "Goal Target is Required"
        
        // empty text field
        goalNameTextField.text = ""
        goalTargetTextField.text = ""
        
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
    
    @IBAction func submitGoalTapped(_ sender: Any) {
        resetForm()
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
    
    func invalidGoalName(_ value: String) -> String? {
        
        if value.isEmpty
        {
            return "Goal Name is Required"
        }
        return nil
    }
    
    func checkValidForm() {
        if(validateGoalNameTextField.isHidden && validateGoalTargetTextField.isHidden)
        {
            submitGoalButton.isEnabled = true
        }
        else
        {
            submitGoalButton.isEnabled = false
        }
    }
    
}
