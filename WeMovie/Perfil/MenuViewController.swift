//
//  PerfilViewController.swift
//  WeMovie
//
//  Created by Gabriel Fontenele da Silva on 09/11/24.
//

import UIKit

class MenuViewController: UIViewController {
        
    private let menuScreen = MenuScreen()
    var alert: Alert?
    
    let listMenu: [Menu] = [
          Menu(id: 1, title: "Conta", icon: "person.circle"),
          Menu(id: 2, title: "WeMovie", icon: "film"),
          Menu(id: 3, title: "Linkedin", icon: "link.circle"),
      ]
    
    override func loadView() {
        self.view = self.menuScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuScreen.configTableViewDelegate(delegate: self, dataSource: self)
        self.alert = Alert(controller: self)
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.identifier, for: indexPath) as? MenuTableViewCell {
            let menu = listMenu[indexPath.row]
            cell.configurationCell(menu: menu)
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            self.alert?.getAlert(title: AppMessages.titleDeveloperCredits, message: AppMessages.developerCredits)
        case 1:
            self.alert?.getAlert(title: AppMessages.titleCatalogInfo, message: AppMessages.catalogInfo)
        case 2:
            if let url = URL(string: AppMessages.urlLinkedin) {UIApplication.shared.open(url)}
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
