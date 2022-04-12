//
//  FormAddIncomeViewController.swift
//  Celengin
//
//  Created by Uray Muhamad Noor Fajri Widiansyah on 10/04/22.
//

import UIKit

class FormAddIncomeViewController: UIViewController {
    

    @IBOutlet weak var transactionNameTextField: UITextField!
    @IBOutlet weak var transactionAmountTextField: UITextField!
    @IBOutlet weak var transactionDateTextField: UITextField!
    @IBOutlet weak var transactionSourceTextField: UITextField!
    @IBOutlet weak var transactionNotesTextView: UITextView!
    
    @IBOutlet weak var validateTransactionName: UILabel!
    @IBOutlet weak var validateTransactionAmount: UILabel!
    @IBOutlet weak var validateTransactionDate: UILabel!
    @IBOutlet weak var validateTransactionSource: UILabel!
    
    @IBOutlet weak var saveIncomeButton: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        resetForm()
        setUpElements()
    }
    
    func setUpElements() {
        
        Utilities.styleTextField(transactionNameTextField)
        Utilities.styleTextField(transactionAmountTextField)
        Utilities.styleTextField(transactionSourceTextField)
        Utilities.styleTextView(transactionNotesTextView)
        Utilities.styleFilledButton(saveIncomeButton)
        
        setUpDatePicker()
    }
    
    func resetForm() {
        saveIncomeButton.isEnabled = false
        
        validateTransactionName.isHidden = false
        validateTransactionAmount.isHidden = false
        validateTransactionDate.isHidden = false
        validateTransactionSource.isHidden = false
        
        // message validation
        validateTransactionName.text = "Transaction Name is Required"
        validateTransactionAmount.text = "Transaction Amount is Required"
        validateTransactionDate.text = "Transaction Date is Required"
        validateTransactionSource.text = "Transaction Source is Required"
        
        // empty text field
        transactionNameTextField.text = ""
        transactionAmountTextField.text = ""
        transactionDateTextField.text = ""
        transactionSourceTextField.text = ""
        transactionNotesTextView.text = ""
    }
    
    func setUpDatePicker() {

        datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200))
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)

        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }

        self.transactionDateTextField.inputView = datePicker
        let toolBar: UIToolbar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        
        let spaceButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action:nil)

        let doneButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.tapOnDoneBut))

        toolBar.setItems([spaceButton, doneButton], animated: true)

        self.transactionDateTextField.inputAccessoryView = toolBar
    }
    
    @objc func dateChanged(){
        let dateFormat = DateFormatter()
        
        dateFormat.dateStyle = .medium
        self.transactionDateTextField.text = dateFormat.string(from: datePicker.date)
        
        if let transactionDate = self.transactionDateTextField.text
        {
            if let errorMessage = invalidTransactionDate(transactionDate)
            {
                validateTransactionDate.text = errorMessage
                validateTransactionDate.isHidden = false
            } else
            {
                validateTransactionDate.isHidden = true
            }
        }
        checkValidForm()
    }

    @objc func tapOnDoneBut() {
        transactionDateTextField.resignFirstResponder()
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
        if let transactionAmount = transactionAmountTextField.text
        {
            if let errorMessage = invalidTransactionAmount(transactionAmount)
            {
                validateTransactionAmount.text = errorMessage
                validateTransactionAmount.isHidden = false
            } else
            {
                validateTransactionAmount.isHidden = true
            }
        }
        checkValidForm()
    }
    
    @IBAction func transactionDateChanged(_ sender: Any) {
        if let transactionDate = transactionDateTextField.text
        {
            if let errorMessage = invalidTransactionDate(transactionDate)
            {
                validateTransactionDate.text = errorMessage
                validateTransactionDate.isHidden = false
            } else
            {
                validateTransactionDate.isHidden = true
            }
        }
        checkValidForm()
    }
    
    @IBAction func transactionSourceChanged(_ sender: Any) {
        if let transactionSource = transactionSourceTextField.text
        {
            if let errorMessage = invalidTransactionSource(transactionSource)
            {
                validateTransactionSource.text = errorMessage
                validateTransactionSource.isHidden = false
            } else
            {
                validateTransactionSource.isHidden = true
            }
        }
        checkValidForm()
    }
    
    @IBAction func saveIncomeTapped(_ sender: Any) {
        
        if transactionNotesTextView.text.isEmpty
        {
            transactionNotesTextView.text = ""
        }
        
        let newTransaction = Transaction(context: self.context)
        newTransaction.name = transactionNameTextField.text
        newTransaction.notes = transactionNotesTextView.text
        newTransaction.amount = Double(transactionAmountTextField.text ?? "0") ?? 0.0
        newTransaction.date = datePicker.date
        newTransaction.resources = transactionSourceTextField.text
        newTransaction.type = "Income"
        newTransaction.goals = nil
        
        do{
            try context.save()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "homepage") as! ViewController
                   self.navigationController?.pushViewController(vc, animated: true)
        }
        catch
        {
            
        }
        
        // resetForm()
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
        if(validateTransactionName.isHidden && validateTransactionAmount.isHidden && validateTransactionDate.isHidden && validateTransactionSource.isHidden)
        {
            saveIncomeButton.isEnabled = true
        }
        else
        {
            saveIncomeButton.isEnabled = false
        }
    }
}
