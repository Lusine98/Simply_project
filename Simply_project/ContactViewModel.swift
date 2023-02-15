//
//  ContactViewModel.swift
//  Simply_project
//
//  Created by Lusine Gasparyan on 12.02.23.
//

import Foundation

class ContactViewModel {
    func deleteContact(id: Int) {
        var currentContacts = getContacts()
        for i in 0 ..< currentContacts.count {
            if currentContacts[i].id == id {
                currentContacts.remove(at: i)
                break
            }
        }
        updateUserDefaults(with: currentContacts)
    }
    
    func addContact(contact: ContactModel) {
        var currentContacts = getContacts()
        currentContacts.append(contact)
        updateUserDefaults(with: currentContacts)
    }
    
    func updateContact(contact: ContactModel) {
        let id = contact.id
        let currentContacts = getContacts()
        for i in 0 ..< currentContacts.count {
            if currentContacts[i].id == id {
                currentContacts[i].firstName = contact.firstName
                currentContacts[i].lastName = contact.lastName
                currentContacts[i].phoneNumber = contact.phoneNumber
            }
        }
        updateUserDefaults(with: currentContacts)
    }
    
    func getContacts() -> [ContactModel] {
        var currentContacts = [ContactModel]()
        if let data = UserDefaults.standard.data(forKey: "contacts"),
           let contacts = try? JSONDecoder().decode([ContactModel].self, from: data) {
            currentContacts = contacts
            // use the contacts array here
        }
        return currentContacts
    }
    
    func updateUserDefaults(with contacts: [ContactModel]) {
        let encodedContacts = try! JSONEncoder().encode(contacts)
        UserDefaults.standard.set(encodedContacts, forKey: "contacts")
    }
    
    func getContact(with id: Int) -> ContactModel? {
        let contacts = getContacts()
        for contact in contacts {
            if contact.id == id {
                return contact
            }
        }
        return nil
    }
}
