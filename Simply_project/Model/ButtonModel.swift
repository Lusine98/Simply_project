//
//  ButtonModel.swift
//  Simply_project
//
//  Created by Lusine Gasparyan on 15.02.23.
//

import Foundation

struct ButtonModel: Hashable {
    var id: Int
    var firstName: String
    var lastName: String
    
    init(id: Int, firstName: String, lastName: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
    }
}
