//
//  TabBarViewController.swift
//  WeMovie
//
//  Created by Gabriel Fontenele da Silva on 07/11/24.
//

import UIKit

class TabBarViewController: UITabBarController {
    private let cartManager: CartManagerProtocol
    private let notificationCenter: NotificationCenter

    init(
        cartManager: CartManagerProtocol,
        notificationCenter: NotificationCenter = .default
    ) {
        self.cartManager = cartManager
        self.notificationCenter = notificationCenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBarController()
        self.navigationItem.setHidesBackButton(true, animated: true)
        notificationCenter.addObserver(self, selector: #selector(handleCartUpdate), name: .cartUpdate, object: nil)
    }
    
    private func setupTabBarController(){
        let symbolConfiguration = UIImage.SymbolConfiguration(scale: .medium)

        let addToCartSymbol = UIImage(systemName: "cart", withConfiguration: symbolConfiguration)
        let cartViewModel = CartViewModel(cartManager: cartManager, profileService: ProfileService())
        let addToCart = UINavigationController(rootViewController: CartViewController(viewModel: cartViewModel))
        addToCart.tabBarItem.image = addToCartSymbol
        addToCart.tabBarItem.title = "Carrinho"
        addToCart.navigationBar.backgroundColor = UIColor(named: "primaryBackgroundColor")
        
        let homeViewModel = HomeViewModel(movieService: MovieServiceImpl(), cartManager: cartManager)
        let home = UINavigationController(rootViewController: HomeViewController(viewModel: homeViewModel))
        home.navigationBar.backgroundColor = UIColor(named: "primaryBackgroundColor")
        let homeSymbol = UIImage(systemName: "house", withConfiguration: symbolConfiguration)
        home.tabBarItem.image = homeSymbol
        home.tabBarItem.title = "Home"
        
      
        let profileSymbol = UIImage(systemName: "person", withConfiguration: symbolConfiguration)
        let profile = UINavigationController(rootViewController:MenuViewController())
        profile.tabBarItem.image = profileSymbol
        profile.tabBarItem.title = "Perfil"
        
        self.setViewControllers([addToCart, home, profile], animated: true)
        self.selectedIndex = 1
    }

    @objc func handleCartUpdate() {
        var amountOfItemsInCart = 0
        cartManager.cartItems.forEach { item in
            amountOfItemsInCart += item.amount
        }
        var text = "Carrinho"
        if amountOfItemsInCart > 0 {
            text += " (\(amountOfItemsInCart))"
        }
        tabBar.items?.first?.title = text
    }
}
