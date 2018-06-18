//
//  Contact.swift
//  Contacts2
//
//  Created by Adam on 17/06/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import Foundation
import CloudKit

struct Constants {
    static let recordTypeKey = "Contact"
    static let nameKey = "name"
    static let phoneNumberKey = "phoneNumber"
    static let emailAddressKey = "emailAddress"
}

class Contact: Equatable {
    
    var name: String
    var phoneNumber: String?
    var emailAddress: String?
    let recordID: CKRecordID
    
    init(name: String, phoneNumber: String?, emailAddress: String?, recordID: CKRecordID = CKRecordID(recordName: UUID().uuidString)) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.emailAddress = emailAddress
        self.recordID = recordID
    }
    
    init?(ckRecord: CKRecord) {
        guard let name = ckRecord[Constants.nameKey] as? String,
            let phoneNumber = ckRecord[Constants.phoneNumberKey] as? String,
            let emailAddress = ckRecord[Constants.emailAddressKey] as? String else { return nil }
        self.name = name
        self.phoneNumber = phoneNumber
        self.emailAddress = emailAddress
        self.recordID = ckRecord.recordID
    }
    
    static func ==(lhs: Contact, rhs: Contact) -> Bool {
        return lhs.name == rhs.name && lhs.phoneNumber == rhs.phoneNumber && lhs.emailAddress == rhs.emailAddress && lhs.recordID == rhs.recordID
    }
}

extension CKRecord {
    convenience init(contact: Contact) {
        self.init(recordType: Constants.recordTypeKey, recordID: contact.recordID)
        self.setValue(contact.name, forKey: Constants.nameKey)
        self.setValue(contact.phoneNumber, forKey: Constants.phoneNumberKey)
        self.setValue(contact.emailAddress, forKey: Constants.emailAddressKey)
    }
}













