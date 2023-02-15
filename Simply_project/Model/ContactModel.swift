//
//  ContactModel.swift
//  Simply_project
//
//  Created by Lusine Gasparyan on 12.02.23.
//

import Foundation

class ContactModel: Encodable, Decodable, Equatable {
    var id: Int
    var firstName: String
    var lastName: String
    var phoneNumber: String
    
    init(id: Int, firstName: String, lastName: String, phoneNumber: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
    }
    
    static func == (lhs: ContactModel, rhs: ContactModel) -> Bool {
        if lhs.id == rhs.id && lhs.firstName == rhs.firstName &&
            lhs.lastName == rhs.lastName && lhs.phoneNumber == rhs.phoneNumber {
            return true
        } else {
            return false
        }
    }
}
