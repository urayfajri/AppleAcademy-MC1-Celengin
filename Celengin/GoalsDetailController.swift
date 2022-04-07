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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(tapTrash))
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
        navigationItem.rightBarButtonItems = [trashButton, editButton]
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
        
        }
    @objc func tapTrash(){
        let vc = UIViewController()
        navigationController?.pushViewController(vc, animated: true)
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
