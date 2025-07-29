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
    
}
