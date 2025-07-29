//
//  TransactionModel.swift
//  Income
//
//  Created by mac on 7/29/25.
//

import Foundation

struct Transaction: Identifiable {
    
    let id = UUID()
    let title: String
    let type: TransactionType
    let amount: Double
    let date: Date
    var displayDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: date)
        
    }
    
    var displayAmout: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: amount as NSNumber) ?? "$0.00"
    }
    
}
