//
//  File.swift
//  iExpenses
//
//  Created by Mete Alp Kizilcay on 23.10.2020.
//

import Foundation

class Expenses:ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items){
                self.items = decoded
                return
            }
            
        }
        self.items = []
    }
}


struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
}
