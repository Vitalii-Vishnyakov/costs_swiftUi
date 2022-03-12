//
//  ContentView.swift
//  costs
//
//  Created by Виталий on 12.03.2022.
//

import SwiftUI
struct ExpenseItem  : Identifiable , Codable{
    let id = UUID( )
    let name : String
    let type : String
    let amount : Int
    
}
class Expenses : ObservableObject {
    @Published var items = [ ExpenseItem]( ){
        didSet {
            let encoder = JSONEncoder ( )
            if let encoded  = try? encoder.encode(items){
                UserDefaults.standard.set(encoded , forKey: "data")
            }
        }
    }
    init( ){
        if let items = UserDefaults.standard.value(forKey: "data"){
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items as! Data){
                self.items = decoded
                return
            }
                
        }
    }
}



struct ContentView: View {
    
    @ObservedObject var expenses = Expenses( )
    
    @State private var showAddExpense = false
    var body: some View {
        NavigationView{
            List {
                ForEach(expenses.items ){ item in
                    HStack{
                        Text(item.name)
                        Spacer()
                        Text(item.type)
                        Spacer()
                        Text("\(item.amount) руб")
                    }
                    
                }
                .onDelete(perform: removeItem)
            }
            .navigationTitle("Мои расходы")
            .navigationBarItems(trailing: Button( action: {
                self.showAddExpense = true
            }, label: {
                Image(systemName: "plus")
            })).sheet(isPresented: $showAddExpense, onDismiss: nil) {
                AddView(expenses: self.expenses)
            }
        }
        
        
        
    }
    func removeItem(as offsets : IndexSet){
        expenses.items.remove(atOffsets:  offsets)
    }
}


























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
