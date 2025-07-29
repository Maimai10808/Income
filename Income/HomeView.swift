//
//  ContentView.swift
//  Income
//
//  Created by mac on 7/27/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var transactions: [Transaction] = [
        
        Transaction(title: "Apple", type: .expense, amount: 5.00, date: Date()),
        Transaction(title: "Apple", type: .expense, amount: 5.00, date: Date())
    ]
    
    
    var body: some View {
        VStack {
            List {
                ForEach(transactions) { transaction in
                    
               TransactionView(transaction: transaction)
                    }
                }
            .scrollContentBackground(.hidden)
            }
        }
    }
    


    
#Preview {
    HomeView()
}




