//
//  YourViewTests.swift
//  Simply_projectTests
//
//  Created by Lusine Gasparyan on 12.02.23.
//

import XCTest
import SwiftUI
@testable import Simply_project

class ContactViewModelTests: XCTestCase {
    let viewModel = ContactViewModel()
    override func setUp() {
        super.setUp()
        UserDefaults.standard.removeObject(forKey: "contacts")
    }
    
    func testDeleteContactIfExist() {
        // given
        let contact1 = ContactModel(id: 1, firstName: "John", lastName: "Doe", phoneNumber: "(000) 000-0000")
        let contact2 = ContactModel(id: 2, firstName: "Jane", lastName: "Doe", phoneNumber: "(111) 111-1111")
        let contact3 = ContactModel(id: 3, firstName: "Judy", lastName: "Doe", phoneNumber: "(222) 222-2222")
        let contacts = [contact1, contact2, contact3]
        viewModel.updateUserDefaults(with: contacts)
        
        // when
        viewModel.deleteContact(id: 2)
        
        // then
        let updatedContacts = viewModel.getContacts()
        XCTAssertEqual(updatedContacts.count, 2)
        XCTAssertEqual(updatedContacts[0].firstName, "John")
        XCTAssertEqual(updatedContacts[0].lastName, "Doe")
        XCTAssertEqual(updatedContacts[1].firstName, "Judy")
        XCTAssertEqual(updatedContacts[1].lastName, "Doe")
    }
    
    func testDeleteContactIfNotExist() {
        // given
        let contact1 = ContactModel(id: 1, firstName: "John", lastName: "Doe", phoneNumber: "(000) 000-0000")
        let contact2 = ContactModel(id: 2, firstName: "Jane", lastName: "Doe", phoneNumber: "(111) 111-1111")
        let contacts = [contact1, contact2]
        viewModel.updateUserDefaults(with: contacts)
        
        // when
        viewModel.deleteContact(id: 3)
        
        // then
        let updatedContacts = viewModel.getContacts()
        XCTAssertEqual(updatedContacts.count, 2)
        XCTAssertEqual(updatedContacts[0].firstName, "John")
        XCTAssertEqual(updatedContacts[0].lastName, "Doe")
        XCTAssertEqual(updatedContacts[1].firstName, "Jane")
        XCTAssertEqual(updatedContacts[1].lastName, "Doe")
    }
    
    func testAddContact() {
        // given
        let contact1 = ContactModel(id: 1, firstName: "John", lastName: "Doe", phoneNumber: "(000) 000-0000")
        let contact2 = ContactModel(id: 2, firstName: "Jane", lastName: "Doe", phoneNumber: "(111) 111-1111")
        let contacts = [contact1, contact2]
        viewModel.updateUserDefaults(with: contacts)
        
        // when
        let contactToAdd = ContactModel(id: 3, firstName: "Judy", lastName: "Doe", phoneNumber: "(222) 222-2222")
        viewModel.addContact(contact: contactToAdd)
        
        // then
        let updatedContacts = viewModel.getContacts()
        XCTAssertEqual(updatedContacts.count, 3)
        XCTAssertEqual(updatedContacts[0].firstName, "John")
        XCTAssertEqual(updatedContacts[0].lastName, "Doe")
        XCTAssertEqual(updatedContacts[1].firstName, "Jane")
        XCTAssertEqual(updatedContacts[1].lastName, "Doe")
        XCTAssertEqual(updatedContacts[2].firstName, "Judy")
        XCTAssertEqual(updatedContacts[2].phoneNumber, "(222) 222-2222")
    }
    
    func testUpdateContactIfExists() {
        // given
        let contact1 = ContactModel(id: 1, firstName: "John", lastName: "Doe", phoneNumber: "(000) 000-0000")
        let contact2 = ContactModel(id: 2, firstName: "Jane", lastName: "Doe", phoneNumber: "(111) 111-1111")
        let contact3 = ContactModel(id: 3, firstName: "Judy", lastName: "Doe", phoneNumber: "(222) 222-2222")
        let contacts = [contact1, contact2, contact3]
        viewModel.updateUserDefaults(with: contacts)
        
        // when
        let contactToUpdate = ContactModel(id: 2, firstName: "Jonathan", lastName: "Dogan",
                                           phoneNumber: "(000) 884-1111")
        viewModel.updateContact(contact: contactToUpdate)
        
        // then
        let updatedContacts = viewModel.getContacts()
        XCTAssertEqual(updatedContacts.count, 3)
        XCTAssertEqual(updatedContacts[0].firstName, "John")
        XCTAssertEqual(updatedContacts[0].lastName, "Doe")
        XCTAssertEqual(updatedContacts[1].firstName, "Jonathan")
        XCTAssertEqual(updatedContacts[1].lastName, "Dogan")
        XCTAssertEqual(updatedContacts[2].phoneNumber, "(222) 222-2222")
    }
    
    func testUpdateContactIfNotExists() {
        // given
        let contact1 = ContactModel(id: 1, firstName: "John", lastName: "Doe", phoneNumber: "(000) 000-0000")
        let contact2 = ContactModel(id: 2, firstName: "Jane", lastName: "Doe", phoneNumber: "(111) 111-1111")
        let contacts = [contact1, contact2]
        viewModel.updateUserDefaults(with: contacts)
        
        // when
        let contactToUpdate = ContactModel(id: 3, firstName: "Judy", lastName: "Doe", phoneNumber: "(222) 222-2222")
        viewModel.updateContact(contact: contactToUpdate)
        
        // then
        let updatedContacts = viewModel.getContacts()
        XCTAssertEqual(updatedContacts.count, 2)
        XCTAssertEqual(updatedContacts[0].firstName, "John")
        XCTAssertEqual(updatedContacts[0].lastName, "Doe")
        XCTAssertEqual(updatedContacts[1].firstName, "Jane")
        XCTAssertEqual(updatedContacts[1].lastName, "Doe")
    }
    
    func testGetContactsIfNotEmpty() {
        // given
        let contact1 = ContactModel(id: 1, firstName: "John", lastName: "Doe", phoneNumber: "(000) 000-0000")
        let contact2 = ContactModel(id: 2, firstName: "Jane", lastName: "Doe", phoneNumber: "(111) 111-1111")
        let expectedContacts = [contact1, contact2]
        UserDefaults.standard.set(try! JSONEncoder().encode(expectedContacts), forKey: "contacts")
        
        // when
        let contacts = viewModel.getContacts()
        
        // then
        XCTAssertEqual(contacts, expectedContacts)
    }
    
    func testGetContactsIfEmpty() {
        // given
        UserDefaults.standard.removeObject(forKey: "contacts")
        
        // when
        let resultContacts = viewModel.getContacts()
        
        // then
        XCTAssertEqual(resultContacts, [])
    }
    
    func testUpdateUserDefaults() {
        // given
        let contacts = [ContactModel(id: 1, firstName: "John", lastName: "Doe", phoneNumber: "(000) 000-0000"),
                        ContactModel(id: 2, firstName: "Jane", lastName: "Doe", phoneNumber: "(111) 111-1111")]
        
        // when
        viewModel.updateUserDefaults(with: contacts)
        
        // then
        let decodedData = UserDefaults.standard.data(forKey: "contacts")
        let decodedContacts = try! JSONDecoder().decode([ContactModel].self, from: decodedData!)
        
        XCTAssertEqual(decodedContacts.count, contacts.count)
        for i in 0..<contacts.count {
            XCTAssertEqual(decodedContacts[i].id, contacts[i].id)
            XCTAssertEqual(decodedContacts[i].firstName, contacts[i].firstName)
            XCTAssertEqual(decodedContacts[i].lastName, contacts[i].lastName)
            XCTAssertEqual(decodedContacts[i].phoneNumber, contacts[i].phoneNumber)
        }
    }
}
