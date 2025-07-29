//
//  ContentView.swift
//  Income
//
//  Created by mac on 7/27/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var transactions: [Transaction] = [
        
        Transaction(title: "Apple", type: .expense, amount: 5.00, date: Date())
    ]
    
    
    var body: some View {
        VStack {
            List {
                ForEach(transactions) { transaction in
                    
                    VStack {
                        HStack {
                            
                            Spacer()
                            
                            Text("13/11/24")
                                .font(.system(size: 14))
                            
                            Spacer()
                            
                        }
                        .padding(.vertical, 5)
                        .background(Color.lightGrayShade.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                        HStack {
                            Image(systemName: transaction.type == .income ?
                                  "arrow.up.forward" :
                                    "arrow.down.forward")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(transaction.type == .income ?
                                             Color.green :
                                                Color.red)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                
                                HStack {
                                    Text(transaction.title)
                                        .font(.system(size: 15, weight: .bold))
                                    Spacer()
                                    Text(String(transaction.amount))
                                        .font(.system(size: 15, weight: .bold))
                                }
                                Text("Completed")
                                    .font(.system(size: 14))
                                
                            }
                        }
                    }
                    }
                }
            }
        }
    }
    
    
#Preview {
    ContentView()
}
