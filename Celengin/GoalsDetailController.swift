//
//  GoalsDetailController.swift
//  Celengin
//
//  Created by Arief Ramadhan on 06/04/22.
//

import UIKit
import CoreData

class GoalsDetailController: UIViewController, UINavigationBarDelegate {
   
    @IBOutlet weak var totalTarget: UILabel!
    @IBOutlet weak var deadline: UILabel!
    @IBOutlet weak var target: UILabel!
    @IBOutlet weak var goalsName: UILabel!
    
    @IBOutlet weak var overallProgress: UIProgressView!
    @IBOutlet weak var notes: UILabel!
    @IBOutlet weak var savingProgress: UILabel!
    
    var goal: Goals?

    var progress: Double = 0
    var goalTarget : Double = 0
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var transactionRecordButton: UIButton!
    @IBOutlet weak var addIncomeButton: UIButton!
    @IBOutlet weak var addExpenseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addIncomeButton.tintColor = UIColor.systemGreen
        addExpenseButton.tintColor = UIColor.systemRed
        transactionRecordButton.tintColor = UIColor.systemGray
        
        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(tapTrash))
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(tapEdit))
        navigationItem.rightBarButtonItems = [trashButton, editButton]
        
        goalsName.text = goal?.name
        goalTarget = goal?.target ?? 0.0
        totalTarget.text = "Rp. \(goalTarget)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM, YY"
        let str_deadline = dateFormatter.string(from: (goal?.deadline!)!)
        deadline.text = str_deadline
        notes.text = goal?.add_notes
        
        let goalProgress = Float(Float(goal?.progress ?? 0.0)/Float(goal?.target ?? 0.0))
        
        progress = goal?.progress ?? 0.0
        
        savingProgress.text = "Anda telah menabung Rp. \(progress) dari total Rp. \(goalTarget)"
        overallProgress.progress = goalProgress
        
        }
    
    override func viewWillAppear(_ animated: Bool) {
        goalsName.text = goal?.name
        goalTarget = goal?.target ?? 0.0
        totalTarget.text = "Rp. \(goalTarget)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM, YY"
        let str_deadline = dateFormatter.string(from: (goal?.deadline!)!)
        deadline.text = str_deadline
        notes.text = goal?.add_notes
        
        let goalProgress = Float(Float(goal?.progress ?? 0.0)/Float(goal?.target ?? 0.0))
        
        progress = goal?.progress ?? 0.0
        
        savingProgress.text = "Anda telah menabung Rp. \(progress) dari total Rp. \(goalTarget)"
        overallProgress.progress = goalProgress
    }
    
    @objc func tapTrash(){
//        let vc = UIViewController()
//        navigationController?.pushViewController(vc, animated: true)
        let alertControl = UIAlertController(title: "Delete Item", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
        alertControl.addAction(UIAlertAction(title: "No", style: .cancel, handler: {_ in
            alertControl.dismiss(animated: true, completion: nil)
        }))
        alertControl.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [self]_ in
            self.deleteItem(item: goal!)
            self.navigationController?.popViewController(animated: true)
        }))
        
        self.present(alertControl, animated: true)
    }
    
    @objc func tapEdit(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "edit_goal") as! EditGoalsController
        navigationController?.pushViewController(vc, animated: true)
//        vc.title = "Edit Goals"
        vc.goal = goal
    }
    
    @IBAction func didPressRecord()
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "record_sb") as! TransactionRecordController
        vc.goal = goal
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func deleteItem(item: Goals)
    {
        context.delete(item)
        
        do
        {
            try context.save()
        }
        catch
        {
            
        }
    }

    @IBAction func buttonAddIncome(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "addIncomeForm") as! FormAddIncomeViewController
        vc.goal = goal
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func buttonAddExpense(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "addExpenseForm") as! FormAddExpenseViewController
        vc.goal = goal
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
