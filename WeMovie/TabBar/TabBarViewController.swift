//
//  TabBarViewController.swift
//  WeMovie
//
//  Created by Gabriel Fontenele da Silva on 07/11/24.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    private let cartManager: CartManagerProtocol
    private let notificationCenter: NotificationCenter
    private var gradientViews: [UIView] = []
    private var customTabButtons: [UIButton] = []

    init(
        cartManager: CartManagerProtocol,
        notificationCenter: NotificationCenter = .default
    ) {
        self.cartManager = cartManager
        self.notificationCenter = notificationCenter
        super.init(nibName: nil, bundle: nil)
        self.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBarController()
        self.navigationItem.setHidesBackButton(true, animated: true)
        notificationCenter.addObserver(self, selector: #selector(handleCartUpdate), name: .cartUpdate, object: nil)
        setupGradientViews()
        setupCustomTabButtons()
        updateGradientVisibility()
        updateTabButtonStyles()
    }

    private func setupTabBarController() {
        let symbolConfiguration = UIImage.SymbolConfiguration(scale: .medium)

        let addToCartSymbol = UIImage(named: "shopping_cart", in: nil, with: symbolConfiguration)
        let cartViewModel = CartViewModel(cartManager: cartManager, profileService: ProfileService())
        let addToCart = UINavigationController(rootViewController: CartViewController(viewModel: cartViewModel))
        addToCart.tabBarItem.image = nil
        addToCart.tabBarItem.title = nil
        addToCart.navigationBar.backgroundColor = UIColor(named: "primaryBackgroundColor")
        addToCart.tabBarItem.title = ""
    
        let homeViewModel = HomeViewModel(movieService: MovieServiceImpl(), cartManager: cartManager)
        let home = UINavigationController(rootViewController: HomeViewController(viewModel: homeViewModel))
        home.navigationBar.backgroundColor = UIColor(named: "primaryBackgroundColor")
        home.tabBarItem.image = nil
        home.tabBarItem.title = ""
        

       

        let profile = UINavigationController(rootViewController: MenuViewController())
        profile.tabBarItem.image = nil
        profile.tabBarItem.title = nil

        self.setViewControllers([addToCart, home, profile], animated: true)
        self.selectedIndex = 1
    }

    private func setupGradientViews() {
        gradientViews.forEach { $0.removeFromSuperview() }
        gradientViews.removeAll()

        let itemCount = CGFloat(tabBar.items?.count ?? 0)
        let itemWidth = tabBar.bounds.width / itemCount
        let itemHeight = tabBar.bounds.height

        for i in 0..<Int(itemCount) {
            let x = itemWidth * CGFloat(i)
            let gradientView = UIView(frame: CGRect(x: x, y: 0, width: itemWidth, height: itemHeight))
            
            let topColor = UIColor(white: 1.0, alpha: 0.08).cgColor
            let bottomColor = UIColor.clear.cgColor

            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [topColor, bottomColor]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.frame = gradientView.bounds
            gradientView.layer.insertSublayer(gradientLayer, at: 0)

            let topLine = UIView(frame: CGRect(x: 0, y: 0, width: itemWidth, height: 2))
            topLine.backgroundColor = .white
            topLine.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
            gradientView.addSubview(topLine)

            gradientView.isHidden = true
            tabBar.addSubview(gradientView)
            tabBar.sendSubviewToBack(gradientView)
            gradientViews.append(gradientView)
        }
    }

    private func setupCustomTabButtons() {
        let titles = ["Carrinho", "Home", "Perfil"]
        let imageNames = ["shopping_cart", "house", "user"]

        let itemCount = CGFloat(titles.count)
        let itemWidth = tabBar.bounds.width / itemCount
        let itemHeight = tabBar.bounds.height

        for (index, title) in titles.enumerated() {
            let button = UIButton(type: .system)
            button.frame = CGRect(x: itemWidth * CGFloat(index), y: 0, width: itemWidth, height: itemHeight)
            button.setTitle(" " + title, for: .normal)
            button.setTitleColor(UIColor.white.withAlphaComponent(index == selectedIndex ? 1 : 0.5), for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .medium)
            button.tag = index

            if let image = UIImage(named: imageNames[index]) {
                button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
                button.tintColor = .white
            }

            button.contentHorizontalAlignment = .center
            button.semanticContentAttribute = .forceLeftToRight
            button.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)

            tabBar.addSubview(button)
            customTabButtons.append(button)
        }
    }

    @objc private func tabButtonTapped(_ sender: UIButton) {
        self.selectedIndex = sender.tag
        updateGradientVisibility()
        updateTabButtonStyles()
    }

    private func updateTabButtonStyles() {
        for (index, button) in customTabButtons.enumerated() {
            let isSelected = index == selectedIndex
            button.setTitleColor(UIColor.white.withAlphaComponent(isSelected ? 1 : 0.5), for: .normal)
        }
    }

    private func updateGradientVisibility() {
        for (index, view) in gradientViews.enumerated() {
            view.isHidden = index != selectedIndex
        }
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        updateGradientVisibility()
        updateTabButtonStyles()
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

        if customTabButtons.indices.contains(0) {
            customTabButtons[0].setTitle(" " + text, for: .normal)
        }
    }
}
