//
//  String + Extension.swift
//  WeMovie
//
//  Created by Gabriel Fontenele da Silva on 09/11/24.
//

import Foundation

extension String {
    func formatToTwoDecimalPlaces() -> String {
        if let number = Double(self) {
            return String(format: "%.2f", number)
        } else {
            return self
        }
    }
    
    func formatDate(from inputFormat: String = "yyyy-MM-dd HH:mm:ss Z", to outputFormat: String = "dd/MM/yyyy") -> String? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = inputFormat
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

            if let date = dateFormatter.date(from: self) {
                dateFormatter.dateFormat = outputFormat
                dateFormatter.timeZone = TimeZone.current
                return dateFormatter.string(from: date)
            } else {
                return nil 
            }
        }
    
    func replaceDotWithComma() -> String {
           return self.replacingOccurrences(of: ".", with: ",")
       }
}
