//
//  SceneDelegate.swift
//  WeMovie
//
//  Created by Gabriel Fontenele da Silva on 07/11/24.
//

import Foundation
import UIKit

extension UIView {
    
    func setCardShadow(){
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 8
        layer.shouldRasterize = true
        layer.masksToBounds = false
        layer.rasterizationScale = UIScreen.main.scale
        
    }
    
    func setCornerRadius(cornesRadius: CGFloat, typeCorners: CACornerMask){
        self.layer.cornerRadius = cornesRadius
        self.layer.maskedCorners = typeCorners
        self.clipsToBounds = true
        
    }
    
    func constraintsZero(to superView: UIView){
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor),
           leadingAnchor.constraint(equalTo: superView.leadingAnchor),
          trailingAnchor.constraint(equalTo: superView.trailingAnchor),
           bottomAnchor.constraint(equalTo: superView.bottomAnchor),
        ])
    }
    
    
    
}

extension CACornerMask {
    
    static public let bottomRight: CACornerMask = .layerMaxXMaxYCorner
    static public let bottomLeft: CACornerMask = .layerMinXMaxYCorner
    static public let topRight: CACornerMask = .layerMaxXMinYCorner
    static public let topLeft: CACornerMask = .layerMinXMinYCorner
}
