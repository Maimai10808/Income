//
//  Currency.swift
//  Income
//
//  Created by mac on 7/31/25.
//

import Foundation

enum Currency: CaseIterable {
    
    case usd, pounds
    
    var title: String {
        switch self {
        case .usd:
            return "USD"
            
        case .pounds:
            return "Pounds"
        }
    }
}
