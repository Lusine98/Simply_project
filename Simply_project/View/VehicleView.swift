//
//  MapView.swift
//  Simply_project
//
//  Created by Lusine Gasparyan on 12.02.23.
//

import Foundation
import SwiftUI

struct VehicleView: View {
    @State private var buttons: [ButtonModel] = []
    @State private var showAnotherView = false
    @State private var index = -1
    @State private var selected = false
    var completionClosure: ((Bool) -> Void)?
    let viewModel = ContactViewModel()
    
    init(completion: ((Bool) -> Void)?) {
        buttons = getButtons()
        completionClosure = completion
    }
    
    func nextIndex() -> Int {
        self.index += 1
        return index
    }
    
    var buttonColor: Color {
        selected ? Color(red: 29/255, green: 104/255, blue: 150.255, opacity: 0.8) :
        Color(red: 64/255, green: 160/255, blue: 218/255)
    }
    
    func getButtons() -> [ButtonModel] {
        var buttons: [ButtonModel] = []
        let contacts = viewModel.getContacts()
        for contact in contacts {
            let button = ButtonModel(id: contact.id, firstName: contact.firstName, lastName: contact.lastName)
            buttons.append(button)
        }
        return buttons
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("List up to four people we can call upon your request in event of an emergency")
                .padding()
                .frame(height: 80)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.white)
                .cornerRadius(10)
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.top, 10)
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(Array(buttons.enumerated()), id: \.1.id) { index, button in
                        NavigationLink(destination: ContactView(id: button.id, completion: nil)) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(button.firstName)
                                    Text(button.lastName)
                                        .foregroundColor(.secondary)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            
                            .padding()
                            .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.white)
                        .cornerRadius(10)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                    }
                }
            }
           Button(action: {
               self.selected.toggle()
            }) {
                NavigationLink(destination: ContactView(id: Int(arc4random()), isNewContact: true, completion:
                                                            completionClosure)) {
                    Text("+ ADD A CONTACT")
                }
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(buttonColor)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.bottom, 10)
            .padding(.leading, 10)
            .padding(.trailing, 10)
        }
        .background(Color(red: 235/255, green: 235/255, blue: 235/255))
        .padding(.top)
        .onAppear(perform: {
            buttons = getButtons()
        })
    }
}
