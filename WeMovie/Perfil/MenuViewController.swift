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
    
    override func loadView() {
        self.view = self.menuScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuScreen.configTableViewDelegate(delegate: self, dataSource: self)
        self.alert = Alert(controller: self)
    }
}

extension MenuViewController: UITableViewDelegate,UITableViewDataSource {
    
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
        if indexPath.row == 0 {
            self.alert?.getAlert(title: "Informações do usuario", message: "Projeto desenvolvido por Gabriel Fontenele da Silva Dev iOS")
        } else if indexPath.row == 1 {
            self.alert?.getAlert(title: "Filmes", message: "O catálogo do aplicativo atualmente possui seis filmes disponíveis.")
        } else  if indexPath.row == 2 {
          
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
