//
//  UIcolor+Extension.swift
//  AppDoseCerta
//
//  Created by Gabriel Fontenele da Silva on 22/04/25.
//

import UIKit

extension UIColor {
    static let primaryBackground = UIColor(hex: "#1D1D2B")
    static let secundaryBackground = UIColor(hex: "#2F2E41")
    
    static let primaryButton = UIColor(hex: "#90E0EF")

    // Inicializador para usar cores em hex
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexSanitized.hasPrefix("#") {
            hexSanitized.remove(at: hexSanitized.startIndex)
        }
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}

