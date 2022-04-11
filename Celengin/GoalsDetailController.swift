//
//  GoalsDetailController.swift
//  Celengin
//
//  Created by Arief Ramadhan on 06/04/22.
//

import UIKit

class GoalsDetailController: UIViewController, UINavigationBarDelegate {
   
    @IBOutlet weak var totalTarget: UILabel!
    @IBOutlet weak var deadline: UILabel!
    @IBOutlet weak var target: UILabel!
    @IBOutlet weak var goalsName: UILabel!
    
    @IBOutlet weak var overallProgress: UIProgressView!
    @IBOutlet weak var notes: UILabel!
    @IBOutlet weak var savingProgress: UILabel!
    
    
    var str_totalTarget: String = ""
    var str_deadline: String = ""
    var str_name: String = ""
    var str_notes: String = ""
    var str_progress: String = ""
    var progress: Float = 0
    
    @IBOutlet weak var transactionRecordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(tapTrash))
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
        navigationItem.rightBarButtonItems = [trashButton, editButton]
        
        goalsName.text = str_name
        totalTarget.text = str_totalTarget
        deadline.text = str_deadline
        notes.text = str_notes
        savingProgress.text = str_progress
        overallProgress.progress = progress
        
        }
    @objc func tapTrash(){
        let vc = UIViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didPressRecord()
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "record_sb") as! TransactionRecordController
        vc.goalName = str_name
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func buttonAddIncome(_ sender: Any) {
    }
    @IBAction func buttonAddExpense(_ sender: Any) {
    }
}
