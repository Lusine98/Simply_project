//
//  ContactView.swift
//  Simply_project
//
//  Created by Lusine Gasparyan on 12.02.23.
//

import Foundation
import SwiftUI

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.black)
        })
    }
}

struct ContactView: View, Hashable {
    func hash(into hasher: inout Hasher) {
    }
    
    static func == (lhs: ContactView, rhs: ContactView) -> Bool {
        if lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.phoneNumber == rhs.phoneNumber
            && lhs.contactId == rhs.contactId {
            return true
        } else {
            return false
        }
    }

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var phoneNumber = ""
    @State private var selected = false
    private var isNewContact = false
    @Environment(\.presentationMode) var presentationMode
    private var completion: ((Bool) -> Void)?
    private var contactId: Int
    
    init(id: Int, isNewContact: Bool = false, completion: ((Bool) -> Void)?) {
        if let contact = viewModel.getContact(with: id) {
            contactId = id
            firstName = contact.firstName
            lastName = contact.lastName
            phoneNumber = contact.phoneNumber
        } else {
            contactId = id
            firstName = ""
            lastName = ""
            phoneNumber = ""
        }
        self.completion = completion
        self.isNewContact = isNewContact
    }
    
    var buttonIsDisabled: Bool {
        return firstName.isEmpty || lastName.isEmpty || phoneNumber.isEmpty
        }
    
    var buttonColor: Color {
        selected ? Color(red: 29/255, green: 104/255, blue: 150.255, opacity: 0.8) :
        (buttonIsDisabled ? Color(red: 64/255, green: 160/255, blue: 218/255, opacity: 0.25) :
        Color(red: 64/255, green: 160/255, blue: 218/255))
    }
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    let viewModel = ContactViewModel()
    
    var body: some View {
            VStack(alignment: .leading) {
                VStack {
                    VStack(alignment: .leading) {
                        Text("First Name")
                        TextField("John", text: $firstName)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 30)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(2)
                    }
                    .padding(.horizontal, 10)
                    VStack(alignment: .leading) {
                        Text("Last Name")
                        TextField("Doe", text: $lastName)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 30)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(2)
                    }
                    .padding(.horizontal, 10)
                    VStack(alignment: .leading) {
                        Text("Primary Phone")
                        TextField("(000) 000-0000", text: $phoneNumber)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 30)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(2)
                    }
                    .padding(.horizontal, 10)
                }
                Spacer()
                if self.isNewContact {
                    Button(action: {
                        self.selected.toggle()
                        if (isNewContact) {
                            viewModel.addContact(contact: ContactModel(id: contactId, firstName: firstName,
                                                                       lastName: lastName,
                                                                       phoneNumber: phoneNumber))
                        } else {
                            viewModel.updateContact(contact: ContactModel(id: contactId, firstName: firstName,
                                                                          lastName: lastName,
                                                                          phoneNumber: phoneNumber))
                        }
                        self.completion?(true)
                        self.dismiss()
                    }) {
                        Text("SAVE")
                    }
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 40)
                    .background(buttonColor)
                    .cornerRadius(10)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 10)
                    .disabled(buttonIsDisabled)
                } else {
                    VStack(alignment: .leading) {
                            Button(action: {
                                self.selected.toggle()
                                if (isNewContact) {
                                    viewModel.addContact(contact: ContactModel(id: contactId, firstName: firstName,
                                                                               lastName: lastName,
                                                                               phoneNumber: phoneNumber))
                                } else {
                                    viewModel.updateContact(contact: ContactModel(id: contactId, firstName: firstName,
                                                                                  lastName: lastName,
                                                                                  phoneNumber: phoneNumber))
                                }
                                self.dismiss()
                            }) {
                                Text("SAVE")
                            }
                        
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 40)
                        .background(buttonColor)
                        .cornerRadius(10)
                        .padding(.horizontal, 10)
                        .disabled(buttonIsDisabled)
                        
                        Button(action: {
                            viewModel.deleteContact(id: contactId)
                            self.dismiss()
                        }) {
                            Text("DELETE CONTACT")
                        }
                        .foregroundColor(.blue)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 40)
                        .cornerRadius(10)
                        .padding(.horizontal, 10)
                    }
                }
            }
            .navigationBarTitle(isNewContact ? "Add Contact" : "Edit contact", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton())
            .background(Color(red: 235/255, green: 235/255, blue: 235/255))
            .padding(.top)
            .onAppear {
                if let contact = viewModel.getContact(with: contactId) {
                    firstName = contact.firstName
                    lastName = contact.lastName
                    phoneNumber = contact.phoneNumber
                } else {
                    firstName = ""
                    lastName = ""
                    phoneNumber = ""
                }
            }
        }
}
