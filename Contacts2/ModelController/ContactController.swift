//
//  ContactController.swift
//  Contacts2
//
//  Created by Adam on 17/06/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import Foundation
import CloudKit

class ContactController {
    
    // MARK: - Properties
    static let shared = ContactController()
    
    var contacts = [Contact]()
    
    let publicDB = CKContainer.default().publicCloudDatabase
    
    // MARK: - CRUD/CloudKit
    
    func addContactWith(name: String, phoneNumber: String?, emailAddress: String?, completion: @escaping (Bool) -> Void) {
        let contact = Contact(name: name, phoneNumber: phoneNumber, emailAddress: emailAddress)
        let recordToBeSaved = CKRecord(contact: contact)
        publicDB.save(recordToBeSaved) { (_, error) in
            if let error = error {
                print("There was an error saving the record: \(error)")
                completion(false)
                return
            }
        }
        contacts.append(contact)
        completion(true)
    }
    
    func remove(contact: Contact, completion: @escaping (Bool) -> Void) {
        let recordToBeDeleted = CKRecord(contact: contact)
        publicDB.delete(withRecordID: recordToBeDeleted.recordID) { (_, error) in
            if let error = error {
                print("There was an error deleting the record: \(error)")
                completion(false)
                return
            }
            if let contactIndex = self.contacts.index(of: contact) {
                self.contacts.remove(at: contactIndex)
            }
            completion(true)
        }
    }
    
    func update(contact: Contact, name: String, phoneNumber: String?, emailAddress: String?, completion: @escaping (Error?) -> Void) {
        
        contact.name = name
        contact.phoneNumber = phoneNumber
        contact.emailAddress = emailAddress
        
        let recordToModify = CKRecord(contact: contact)
        let operation = CKModifyRecordsOperation(recordsToSave: [recordToModify], recordIDsToDelete: nil)
        
        operation.savePolicy = .changedKeys
        operation.queuePriority = .high
        operation.qualityOfService = .userInteractive
        operation.perRecordCompletionBlock = nil
        operation.modifyRecordsCompletionBlock = { (_, _, error) in
            completion(error)
        }
        publicDB.add(operation)
    }
    
    func fetchAllContacts(completion: @escaping (Bool) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Constants.recordTypeKey, predicate: predicate)
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("There was an error retrieving the Contact records: \(error)")
                completion(false)
                return
            }
            guard let records = records else { completion(false) ; return }
            let contactsFromFetch = records.compactMap { Contact(ckRecord: $0) }
            self.contacts = contactsFromFetch
            completion(true)
        }
    }
}

















