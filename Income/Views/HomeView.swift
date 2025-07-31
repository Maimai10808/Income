//
//  ContentView.swift
//  Income
//
//  Created by mac on 7/27/25.
//


/*
 1. Object Graph Management
 2. Persistence Store Coordinator
 3. Persistence -> SQLite
 
 */


/*
 1. Persistence Container -> Entity
 2. DataManager -> Managed Object Context
 3. Create
 4. Read -> FetchRequest
 5. Update
 6. Delete
 7. In Memory Persistence Store (PreViews)
 */

import SwiftUI

struct HomeView: View {
    
    @State private var transactions: [Transaction] = [
        
        Transaction(title: "Apple", type: .expense, amount: 5.00, date: Date()),
        Transaction(title: "Apple", type: .expense, amount: 5.00, date: Date()),
        Transaction(title: "Apple", type: .income, amount: 5.00, date: Date())
        
    ]
    
    @AppStorage("orderDescending") var orderDescending = false
    @AppStorage("currency") var currency: Currency = .usd
    @AppStorage("filterMinimum") var filterMinimum = 0.0
    
    private var displayTransactions: [Transaction] {
        let sortedTransactions = orderDescending ?
        transactions.sorted(by: { $0.date < $1.date }) :
        transactions.sorted(by: { $0.date > $1.date })
        let filteredTransactions = sortedTransactions.filter({ $0.amount > filterMinimum })
        return sortedTransactions
    }
    
   
    
    @State private var showAddTransactionView = false
    
    @State private var transactionToEdit: Transaction?
    
    @State private var showSettings = false
    
    private var expenses: String {
        let sumExpesnses = transactions
            .filter({ $0.type == .expense })
            .reduce(0, { $0 + $1.amount })
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter.string(from: sumExpesnses as NSNumber) ?? "$0.00"
    }
    
    private var incomes: String {
        let sumIncomes = transactions
            .filter({ $0.type == .income })
            .reduce(0, { $0 + $1.amount })

        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter.string(from: sumIncomes as NSNumber) ?? "$0.00"
    }
    
    private var total: String {
        let sumExpesnses = transactions
            .filter({ $0.type == .expense })
            .reduce(0, { $0 + $1.amount })
        
        let sumIncomes = transactions
            .filter({ $0.type == .income })
            .reduce(0, { $0 + $1.amount })
        
        let total = sumIncomes - sumExpesnses
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter.string(from: total as NSNumber) ?? "$0.00"
    }
    
    fileprivate func FloatingButton() -> some View {
        VStack {
            Spacer()
            NavigationLink {
                AddTransactionView(transactions: $transactions)
            } label: {
                Text("+")
                    .font(.largeTitle)
                    .frame(width: 70, height: 70)
                    .foregroundStyle(Color.white)
                    .padding(.bottom, 7)
            }
            .background(Color.primaryLightGreen)
            .clipShape(Circle())
        }
    }
    
    
    
    fileprivate func BalanceView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.primaryLightGreen)
            
            VStack(alignment: .leading) {
                
                HStack {
                    
                    VStack(alignment: .leading) {
                        
                        Text("BALANCE")
                            .font(.caption)
                            .foregroundStyle(Color.white)
                        
                        Text("\(total)")
                            .font(.system(size: 42, weight: .light))
                            .foregroundStyle(Color.white)
                    }
                    
                    Spacer()
                }
                .padding(.top)
                
                
                
                HStack(spacing: 25) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Expense")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(Color.white)
                        
                        Text("\(expenses)")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(Color.white)
                        
                    }
                    
                    VStack {
                        Text("Income")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(Color.white)
                        
                        Text("\(incomes)")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(Color.white)
                        
                    }
                    
                }
                
                Spacer()
                
            }
            .padding(.horizontal)
        }
        .shadow(color: Color.black.opacity(0.3), radius: 10, x:0, y: 5)
        .frame(height: 150)
        .padding(.horizontal)
    }
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    BalanceView()
                    
                    List {
                        ForEach(displayTransactions) { transaction in
                            
                            Button(action: {
                                transactionToEdit = transaction
                            }, label: {
                                TransactionView(transaction: transaction)
                                    .foregroundStyle(Color.black)
                            })
                            
                           
                        }
                        .onDelete(perform: delete)
                    }
                    
                    .scrollContentBackground(.hidden)
                }
                .navigationTitle("Income")
                
                FloatingButton()
            }
            .navigationDestination(item: $transactionToEdit, destination: { transactionToEdit in
                AddTransactionView(transactions: $transactions, transactionToEdit: transactionToEdit)
                
            })
            .sheet(isPresented: $showSettings, content: {
                SettingsView()
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showSettings = true
                    }, label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(Color.black)
                    })
                    }
                }
            }
        }
    
    
    
    private func delete(at offsets: IndexSet) {
        transactions.remove(atOffsets: offsets)
    }
    
    }
    


    
#Preview {
    HomeView()
}




