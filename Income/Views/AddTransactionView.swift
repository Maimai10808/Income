//
//  AddTransactionView.swift
//  Income
//
//  Created by mac on 7/30/25.
//

import SwiftUI

struct AddTransactionView: View {
    
    @State private var amount = 0.0
    @State private var transactionTitle = ""
    @State private var selectedTransactionType: TransactionType = .expense
    
    @State private var alertTitle   = ""
    @State private var alertMessage = ""
    @State private var showaAlert   = false
    
    @Binding var transactions: [Transaction]
    
    @Environment(\.dismiss) var dismiss
    
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }
    
    var body: some View {
        VStack {
            
            TextField("0.00", value: $amount, formatter: numberFormatter)
                .font(.system(size: 60, weight: .thin))
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
            
            Rectangle()
                .fill(Color(uiColor: UIColor.lightGray))
                .frame(height: 0.5)
                .padding(.horizontal, 30)
            
            
            Picker("Choose Type", selection: $selectedTransactionType) {
                ForEach(TransactionType.allCases) { transactionType in
                    Text(transactionType.title)
                        .tag(transactionType)
                }
            }
            
            TextField("title", text: $transactionTitle)
                .font(.system(size: 15))
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 30)
                .padding(.top)
            
            Button(action: {
                guard transactionTitle.count >= 2 else {
                    alertTitle   = "Invaild Title"
                    alertMessage = "Title must be 2 or more characters long."
                    showaAlert   = true
                    return
                }
                
                let transaction = Transaction(title: transactionTitle, type: selectedTransactionType, amount: amount, date: Date())
                
                transactions.append(transaction)
                
                dismiss()
                
            }, label: {
                Text("Create")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.white)
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .background(Color.primaryLightGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            })
            .padding(.top)
            .padding(.horizontal, 30)
            
            Spacer()
        }
        .padding(.top)
        .alert(alertTitle, isPresented: $showaAlert) {
            Button {
                
                
            } label: {
                Text("OK")
            }
        } message: {
            Text(alertMessage)
        }
    }
}

#Preview {
    AddTransactionView(transactions: .constant([]))
}
