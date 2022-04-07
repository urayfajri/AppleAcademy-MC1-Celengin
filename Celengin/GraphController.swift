//
//  GraphController.swift
//  Celengin
//
//  Created by Kathleen Febiola Susanto on 02/04/22.
//

import UIKit

class GraphController: UIViewController {
    
    @IBOutlet weak var showButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showButton.backgroundColor = .darkGray
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl)
    {
        if sender.selectedSegmentIndex == 0
        {
            
        }
        
        else if sender.selectedSegmentIndex == 1
        {
            
        }
        
        else
        {
            
        }
    }
    
}
