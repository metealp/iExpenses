//
//  ContentView.swift
//  iExpenses
//
//  Created by Mete Alp Kizilcay on 23.10.2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) {
                    item in
                    HStack {
                        VStack (alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text("$\(item.amount)")
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpenses")
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.showingAddExpense.toggle()
                                    }) {
                                        Image(systemName: "plus")
                                    }
            )
            .sheet(isPresented: $showingAddExpense, content: {
                AddView(expenses: self.expenses)
            })
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
