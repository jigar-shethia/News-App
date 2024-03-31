//
//  Date+Extention.swift
//  News App
//
//  Created by Jigar Shethia on 30/03/24.
//

import Foundation
extension Date {
    func toString(format: String = "MMMM yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
