//
//  FormAddIncomeViewController.swift
//  Celengin
//
//  Created by Uray Muhamad Noor Fajri Widiansyah on 10/04/22.
//

import UIKit

class FormAddIncomeViewController: UIViewController {
    

    @IBOutlet weak var transactionNameTextField: UITextField!
    
    @IBOutlet weak var validateTransactionName: UILabel!
    
    @IBOutlet weak var saveIncomeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        resetForm()
        setUpElements()
    }
    
    func setUpElements() {
        
        Utilities.styleTextField(transactionNameTextField)
    }
    
    func resetForm() {
        saveIncomeButton.isEnabled = false
        
        validateTransactionName.isHidden = false
        
        // message validation
        validateTransactionName.text = "Transaction Name is Required"
        
        // empty text field
        transactionNameTextField.text = ""
        
        
    }
    
    @IBAction func transactionNameChanged(_ sender: Any) {
        if let transactionName = transactionNameTextField.text
        {
            if let errorMessage = invalidTransactionName(transactionName)
            {
                validateTransactionName.text = errorMessage
                validateTransactionName.isHidden = false
            } else
            {
                validateTransactionName.isHidden = true
            }
        }
        checkValidForm()
    }
    
    
    @IBAction func saveIncomeTapped(_ sender: Any) {
        resetForm()
    }
    
    func invalidTransactionName(_ value: String) -> String? {
        
        if value.isEmpty
        {
            return "Transaction Name is Required"
        }
        return nil
    }
    
    func checkValidForm() {
        if(validateTransactionName.isHidden)
        {
            saveIncomeButton.isEnabled = true
        }
        else
        {
            saveIncomeButton.isEnabled = false
        }
    }
}
