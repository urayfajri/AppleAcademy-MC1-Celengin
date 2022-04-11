//
//  FormEditTransactionViewController.swift
//  Celengin
//
//  Created by Uray Muhamad Noor Fajri Widiansyah on 11/04/22.
//

import UIKit

class FormEditTransactionViewController: UIViewController {
    
    
    @IBOutlet weak var transactionTypeLabel: UILabel!
    @IBOutlet weak var transactionNameTextField: UITextField!
    @IBOutlet weak var transactionAmountTextField: UITextField!
    
    @IBOutlet weak var validateTransactionName: UILabel!
    @IBOutlet weak var validateTransactionAmount: UILabel!
    
    @IBOutlet weak var saveEditsButton: UIButton!
    
    
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
        saveEditsButton.isEnabled = false
        
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
    
    @IBAction func transactionAmountChanged(_ sender: Any) {
    }
    
    @IBAction func saveEditsTapped(_ sender: Any) {
    }
    
    func invalidTransactionName(_ value: String) -> String? {
        
        if value.isEmpty
        {
            return "Transaction Name is Required"
        }
        return nil
    }
    
    func invalidTransactionAmount(_ value: String) -> String? {
        
        let set = CharacterSet(charactersIn: value)
        if !CharacterSet.decimalDigits.isSuperset(of: set)
        {
            return "Amount must contain only digits"
        }
        if value.isEmpty
        {
            return "Transaction Amount is Required"
        }
        return nil
    }
    
    func invalidTransactionDate(_ value: String) -> String? {
        
        if value.isEmpty
        {
            return "TransactionDate is Required"
        }
        return nil
    }
    
    func invalidTransactionSource(_ value: String) -> String? {
        
        if value.isEmpty
        {
            return "Transaction Source is Required"
        }
        return nil
    }
    
    func checkValidForm() {
        if(validateTransactionName.isHidden)
        {
            saveEditsButton.isEnabled = true
        }
        else
        {
            saveEditsButton.isEnabled = false
        }
    }
}
