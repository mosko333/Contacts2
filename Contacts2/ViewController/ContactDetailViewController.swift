//
//  ContactDetailViewController.swift
//  Contacts2
//
//  Created by Adam on 17/06/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Action
    @IBAction func saveBtnTapped(_ sender: UIBarButtonItem) {
    }
    
}
