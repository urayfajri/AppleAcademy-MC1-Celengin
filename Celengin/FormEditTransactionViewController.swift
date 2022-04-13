//
//  FormEditTransactionViewController.swift
//  Celengin
//
//  Created by Uray Muhamad Noor Fajri Widiansyah on 11/04/22.
//

import UIKit

class FormEditTransactionViewController: UIViewController {
    
    
    @IBOutlet weak var transactionTypeTitle: UILabel!
    
    @IBOutlet weak var transactionTypeLabel: UILabel!
    @IBOutlet weak var transactionNameTextField: UITextField!
    @IBOutlet weak var transactionAmountTextField: UITextField!
    @IBOutlet weak var transactionDateTextField: UITextField!
    @IBOutlet weak var transactionNotesTextView: UITextView!
    
    @IBOutlet weak var validateTransactionName: UILabel!
    @IBOutlet weak var validateTransactionAmount: UILabel!
    @IBOutlet weak var validateTransactionDate: UILabel!
    
    //based on transaction type
    
    @IBOutlet weak var transactionResourceLabel: UILabel!
    @IBOutlet weak var transactionResourceTextField: UITextField!
    @IBOutlet weak var validateTransactionResource: UILabel!
    
    @IBOutlet weak var saveEditsButton: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var datePicker: UIDatePicker!
    
    var transaction: Transaction?
    var transactionType: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchEditedTransaction()
        updateForm()
        setUpElements()
    }
    
    func setUpElements() {
        
        Utilities.styleTextField(transactionNameTextField)
        Utilities.styleTextField(transactionAmountTextField)
        Utilities.styleTextField(transactionResourceTextField)
        Utilities.styleTextView(transactionNotesTextView)
        Utilities.styleFilledButton(saveEditsButton)
    
        setUpDatePicker()
    }
    
    func updateForm() {
        setTransactionResource()
        
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
        
        if let transactionResource = transactionResourceTextField.text
        {
            if let errorMessage = invalidTransactionResource(transactionResource)
            {
                validateTransactionResource.text = errorMessage
                validateTransactionResource.isHidden = false
            } else
            {
                validateTransactionResource.isHidden = true
            }
        }
        
        checkValidForm()
    }
    
    func setTransactionResource() {
    
        if transactionType == "Pemasukan"
        {
            transactionTypeTitle.text = "Ubah Pemasukan"
            transactionTypeTitle.textColor = .systemYellow
            transactionResourceLabel.text = "Sumber Pemasukan"
            transactionResourceTextField.placeholder = "Ubah Transaksi Pemasukan"
            validateTransactionResource.text = "Transaction Source is Required"
        }
        else if transactionType == "Pengeluaran"
        {
            transactionTypeTitle.text = "Ubah Pengeluaran"
            transactionTypeTitle.textColor = .systemRed
            transactionResourceLabel.text = "Keperluan"
            transactionResourceTextField.placeholder = "Ubah Transaksi Keperluan"
            validateTransactionResource.text = "Transaction Needs is Required"
        }
        else {
            transactionTypeTitle.text = "Ubah Sumber Transaksi"
            transactionResourceLabel.text = "Transaction Resource"
            transactionResourceTextField.placeholder = "Edit Transaction Resource"
            validateTransactionResource.text = "Transaction Resource is Required"
        }
    
    }
    
    func setUpDatePicker() {

        datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200))
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        datePicker.date = (transaction?.date)!

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
    
    @IBAction func transactionDateTapped(_ sender: Any) {
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
    
    @IBAction func transactionResourceTapped(_ sender: Any) {
        if let transactionResource = transactionResourceTextField.text
        {
            if let errorMessage = invalidTransactionResource(transactionResource)
            {
                validateTransactionResource.text = errorMessage
                validateTransactionResource.isHidden = false
            } else
            {
                validateTransactionResource.isHidden = true
            }
        }
        checkValidForm()
    }
    
    
    @IBAction func saveEditsTapped(_ sender: Any) {
        
        if transactionNotesTextView.text.isEmpty
        {
            transactionNotesTextView.text = ""
        }
        
        updateTransaction(item: transaction!)
        
//        resetForm()
    }
    
    func updateTransaction(item: Transaction)
    {
        item.name = transactionNameTextField.text
        item.notes = transactionNotesTextView.text
        
        let newAmount = Double(transactionAmountTextField.text ?? "0") ?? 0.0
        
        if item.type == "Pemasukan"
        {
            if item.amount < newAmount
            {
                item.goals?.progress += (newAmount - item.amount)
            }
            
            else if item.amount > newAmount
            {
                item.goals?.progress -= (item.amount - newAmount)
            }
        }
        
        else
        {
            if item.amount < newAmount
            {
                item.goals?.progress -= (newAmount - item.amount)
            }
            
            else if item.amount > newAmount
            {
                item.goals?.progress += (item.amount - newAmount)
            }
        }
        
        item.amount = newAmount
        item.resources = transactionResourceTextField.text
        item.date = datePicker.date
        
        
        
        do{
            
            try context.save()
            
            self.navigationController?.popViewController(animated: true)
        }
        
        catch
        {
            
        }
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
    
    func invalidTransactionResource(_ value: String) -> String? {
        
        if transactionType == "Pemasukan"
        {
            if value.isEmpty{
                return "Transaction Source is Required"
            }
        }
        if transactionType == "Pengeluaran"
        {
            if value.isEmpty{
                return "Transaction Needs is Required"
            }
        }
        return nil
    }
    
    func checkValidForm() {
        if(validateTransactionName.isHidden && validateTransactionAmount.isHidden && validateTransactionDate.isHidden && validateTransactionResource.isHidden)
        {
            saveEditsButton.isEnabled = true
        }
        else
        {
            saveEditsButton.isEnabled = false
        }
    }
    
    func fetchEditedTransaction()
    {
        transactionNameTextField.text = transaction?.name
        transactionResourceTextField.text = transaction?.resources
        transactionNotesTextView.text = transaction?.notes
        transactionType = transaction?.type
        
        // fetch transaction amount
        let amountMoney = "\(Int(transaction?.amount ?? 0))"
        transactionAmountTextField.text = amountMoney
        
        // fetch goal date
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .medium
        transactionDateTextField.text = dateFormat.string(from: (transaction?.date)!)

    }
}
