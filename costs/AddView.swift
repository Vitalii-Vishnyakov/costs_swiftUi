//
//  AddView.swift
//  costs
//
//  Created by Виталий on 12.03.2022.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses : Expenses
    @State private var name = ""
    @State private var type = 0
    @State private var amount = ""
    
    let types = ["Семья" , "Дело" , "Я"]
    
    var body: some View {
        NavigationView{
        Form{
            TextField("Название", text: $name)
            
            Picker("", selection: $type){
                Text(types[0]).tag(0)
                Text(types[1]).tag(1)
                Text(types[2]).tag(2)
            }.pickerStyle(SegmentedPickerStyle())
            TextField("Затраты", text: $amount).keyboardType(.numberPad)
        }
        .navigationTitle("Добавить")
        .navigationBarItems(trailing: Button("Сохронить", action: {
            if let actualAmount = Int(self.amount)  {
                let item = ExpenseItem(name: name, type: types[type], amount: actualAmount)
                expenses.items.append(item)
                self.presentationMode.wrappedValue.dismiss()
            }
            
            
        }))
        }
        
    }
}

