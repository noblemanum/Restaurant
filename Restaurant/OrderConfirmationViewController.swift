//
//  OrderConfirmationViewController.swift
//  Restaurant
//
//  Created by Dimon on 30.06.2020.
//  Copyright © 2020 Dimon. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController {

    @IBOutlet var timeRemainingLabel: UILabel!
    var minutes: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true

        timeRemainingLabel.text = "Thank you for your order! Your wait time approximately \(minutes!) minutes"
    }
    

}
