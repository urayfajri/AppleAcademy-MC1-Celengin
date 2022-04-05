//
//  ViewController.swift
//  Celengin
//
//  Created by Kathleen Febiola Susanto on 29/03/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home page"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapAdd))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
        
        // Do any additional setup after loading the view.
        // test
    }
    
    @objc func tapAdd()
    {
        
    }


}

