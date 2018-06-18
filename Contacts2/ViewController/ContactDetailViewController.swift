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
    
    var contact: Contact?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard let contact = contact else { return }
        nameTextField.text = contact.name
        phoneNumberTextField.text = contact.phoneNumber
        emailAddressTextField.text = contact.emailAddress
    }
    
    // MARK: - Action
    @IBAction func saveBtnTapped(_ sender: UIBarButtonItem) {
        guard nameTextField.text != "", let name = nameTextField.text, let phoneNumber = phoneNumberTextField.text, let emailAddress = emailAddressTextField.text else { return }
        
        if let contact = contact {
            ContactController.shared.update(contact: contact, name: name, phoneNumber: phoneNumber, emailAddress: emailAddress) { (success) in
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        } else {
            ContactController.shared.addContactWith(name: name, phoneNumber: phoneNumber, emailAddress: emailAddress) { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
}
