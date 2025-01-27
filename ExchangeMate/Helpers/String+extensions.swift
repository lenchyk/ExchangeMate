//
//  String+extensions.swift
//  ExchangeMate
//
//  Created by Lena Soroka on 27.01.2025.
//

import Foundation

extension String {
    // today date in 2025-01-27 format
    var todayString: String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: currentDate)
    }
    
    var isToday: Bool {
        self == todayString
    }
}
