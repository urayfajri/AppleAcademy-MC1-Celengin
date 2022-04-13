//
//  FormAddExpenseViewController.swift
//  Celengin
//
//  Created by Uray Muhamad Noor Fajri Widiansyah on 11/04/22.
//

import UIKit

class FormAddExpenseViewController: UIViewController {

    @IBOutlet weak var transactionNameTextField: UITextField!
    @IBOutlet weak var transactionAmountTextField: UITextField!
    @IBOutlet weak var transactionDateTextField: UITextField!
    @IBOutlet weak var transactionNeedsTextField: UITextField!
    @IBOutlet weak var transactionNotesTextView: UITextView!
    
    @IBOutlet weak var validateTransactionName: UILabel!
    @IBOutlet weak var validateTransactionAmount: UILabel!
    @IBOutlet weak var validateTransactionDate: UILabel!
    @IBOutlet weak var validateTransactionNeeds: UILabel!
    
    @IBOutlet weak var saveExpenseButton: UIButton!
    
    var goal: Goals?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Tambah Pengeluaran"
        resetForm()
        setUpElements()
    }
    
    func setUpElements() {
        
        Utilities.styleTextField(transactionNameTextField)
        Utilities.styleTextField(transactionAmountTextField)
        Utilities.styleTextField(transactionNeedsTextField)
        Utilities.styleTextView(transactionNotesTextView)
        Utilities.styleFilledButton(saveExpenseButton)
        
        setUpDatePicker()
    }
    
    func resetForm() {
        saveExpenseButton.isEnabled = false
        
        validateTransactionName.isHidden = false
        validateTransactionAmount.isHidden = false
        validateTransactionDate.isHidden = false
        validateTransactionNeeds.isHidden = false
        
        // message validation
        validateTransactionName.text = "Nama Transaksi Harus Diisi"
        validateTransactionAmount.text = "Jumlah Transaksi Harus Diisi"
        validateTransactionDate.text = "Tanggal Transaksi Harus Diisi"
        validateTransactionNeeds.text = "Keperluan Transaksi Harus Diisi"
        
        // empty text field
        transactionNameTextField.text = ""
        transactionAmountTextField.text = ""
        transactionDateTextField.text = ""
        transactionNeedsTextField.text = ""
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
    
    @IBAction func transactionNeedsChanged(_ sender: Any) {
        if let transactionNeeds = transactionNeedsTextField.text
        {
            if let errorMessage = invalidTransactionNeeds(transactionNeeds)
            {
                validateTransactionNeeds.text = errorMessage
                validateTransactionNeeds.isHidden = false
            } else
            {
                validateTransactionNeeds.isHidden = true
            }
        }
        checkValidForm()
    }
    
    @IBAction func saveExpenseTapped(_ sender: Any) {
        
        let alertControl = UIAlertController(title: "Tambah Pengeluaran", message: "Apakah kamu yakin ingin menambah pengeluaran baru?", preferredStyle: .alert)
        alertControl.addAction(UIAlertAction(title: "Tidak", style: .cancel, handler: {_ in
            alertControl.dismiss(animated: true, completion: nil)
        }))
        alertControl.addAction(UIAlertAction(title: "Iya", style: .destructive, handler: { [self]_ in
            
            if transactionNotesTextView.text.isEmpty
            {
                transactionNotesTextView.text = ""
            }
            
            let newTransaction = Transaction(context: self.context)
            newTransaction.name = transactionNameTextField.text
            newTransaction.notes = transactionNotesTextView.text
            newTransaction.amount = Double(transactionAmountTextField.text ?? "0") ?? 0.0
            newTransaction.date = datePicker.date
            newTransaction.resources = transactionNeedsTextField.text
            newTransaction.type = "Pengeluaran"
            
            goal?.addToTransaction(newTransaction)
            goal?.progress -= newTransaction.amount
            
            do{
                try context.save()
                self.navigationController?.popViewController(animated: true)
            }
            catch
            {
                
            }
        }))
        
        self.present(alertControl, animated: true)
        
//        resetForm()
    }
    
    func invalidTransactionName(_ value: String) -> String? {
        
        if value.isEmpty
        {
            return "Nama Transaksi Harus Diisi"
        }
        return nil
    }
    
    func invalidTransactionAmount(_ value: String) -> String? {
        
        let set = CharacterSet(charactersIn: value)
        if !CharacterSet.decimalDigits.isSuperset(of: set)
        {
            return "Jumlah Uang Diisi Angka"
        }
        if value.isEmpty
        {
            return "Jumlah Transaksi Harus Diisi"
        }
        return nil
    }
    
    func invalidTransactionDate(_ value: String) -> String? {
        
        if value.isEmpty
        {
            return "Tanggal Transaksi Harus Diisi"
        }
        return nil
    }
    
    func invalidTransactionNeeds(_ value: String) -> String? {
        
        if value.isEmpty
        {
            return "Keperluan Transaksi Harus Diisi"
        }
        return nil
    }
    
    func checkValidForm() {
        if(validateTransactionName.isHidden && validateTransactionAmount.isHidden && validateTransactionDate.isHidden && validateTransactionNeeds.isHidden)
        {
            saveExpenseButton.isEnabled = true
        }
        else
        {
            saveExpenseButton.isEnabled = false
        }
    }
    
}
