//
//  UITableView+Extension.swift
//  WeMovie
//
//  Created by Gabriel Fontenele da Silva on 07/11/24.
//


import UIKit

protocol ReusableView: AnyObject {
    static var reuseIdentifier: String {get}
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: self.reuseIdentifier, bundle: Bundle.main)
    }
    
}

extension UITableViewCell: ReusableView {}

extension UITableView {

    func registerViewCode<T: UITableViewCell>(type: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func register<T: UITableViewCell>(type: T.Type) {
        self.register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        
        return cell
    }
}

