//
//  TabBarViewController.swift
//  WeMovie
//
//  Created by Gabriel Fontenele da Silva on 07/11/24.
//

import UIKit

final class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    enum TabItem: CaseIterable {
        case cart, home, profile

        var title: String {
            switch self {
            case .cart: return "Carrinho"
            case .home: return "Home"
            case .profile: return "Perfil"
            }
        }

        var image: UIImage? {
            switch self {
            case .cart: return UIImage(named: "shopping_cart")
            case .home: return UIImage(named: "house")
            case .profile: return UIImage(named: "user")
            }
        }

        func viewController(using cartManager: CartManagerProtocol) -> UIViewController {
            switch self {
            case .cart:
                let viewModel = CartViewModel(cartManager: cartManager, profileService: ProfileService())
                return UINavigationController(rootViewController: CartViewController(viewModel: viewModel))
            case .home:
                let viewModel = HomeViewModel(movieService: MovieServiceImpl(), cartManager: cartManager)
                return UINavigationController(rootViewController: HomeViewController(viewModel: viewModel))
            case .profile:
                return UINavigationController(rootViewController: MenuViewController())
            }
        }
    }

    private let cartManager: CartManagerProtocol
    private let notificationCenter: NotificationCenter
    private var gradientViews: [UIView] = []
    private var customTabButtons: [UIButton] = []

    init(cartManager: CartManagerProtocol, notificationCenter: NotificationCenter = .default) {
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
        setupViewControllers()
        setupGradientViews()
        setupCustomTabButtons()
        updateGradientVisibility()
        updateTabButtonStyles()
        notificationCenter.addObserver(self, selector: #selector(handleCartUpdate), name: .cartUpdate, object: nil)
    }

    private func setupViewControllers() {
        let controllers = TabItem.allCases.map { $0.viewController(using: cartManager) }
        setViewControllers(controllers, animated: false)
        selectedIndex = 1
    }

    private func setupGradientViews() {
        gradientViews.forEach { $0.removeFromSuperview() }
        gradientViews.removeAll()

        guard let itemCount = tabBar.items?.count, itemCount > 0 else { return }
        let itemWidth = tabBar.bounds.width / CGFloat(itemCount)
        let itemHeight = tabBar.bounds.height

        for i in 0..<itemCount {
            let frame = CGRect(x: CGFloat(i) * itemWidth, y: 0, width: itemWidth, height: itemHeight)
            let gradientView = UIView(frame: frame)
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor(white: 1.0, alpha: 0.08).cgColor, UIColor.clear.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.frame = gradientView.bounds
            gradientView.layer.insertSublayer(gradientLayer, at: 0)

            let topLine = UIView(frame: CGRect(x: 0, y: 0, width: itemWidth, height: 2))
            topLine.backgroundColor = .white
            topLine.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
            gradientView.addSubview(topLine)

            gradientView.isHidden = true
            tabBar.insertSubview(gradientView, at: 0)
            gradientViews.append(gradientView)
        }
    }

    private func setupCustomTabButtons() {
        let tabItems = TabItem.allCases
        let itemCount = CGFloat(tabItems.count)
        let itemWidth = tabBar.bounds.width / itemCount
        let itemHeight = tabBar.bounds.height

        customTabButtons = tabItems.enumerated().map { index, tabItem in
            let button = UIButton(type: .system)
            button.frame = CGRect(x: itemWidth * CGFloat(index), y: 0, width: itemWidth, height: itemHeight)
            button.tag = index
            button.setTitle(" " + tabItem.title, for: .normal)
            button.setTitleColor(.white.withAlphaComponent(index == selectedIndex ? 1 : 0.5), for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)

            if let image = tabItem.image {
                button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
                button.tintColor = .white
            }

            button.contentHorizontalAlignment = .center
            button.semanticContentAttribute = .forceLeftToRight
            button.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)

            tabBar.addSubview(button)
            return button
        }
    }

    @objc private func tabButtonTapped(_ sender: UIButton) {
        guard selectedIndex != sender.tag else { return }
        selectedIndex = sender.tag
        updateGradientVisibility()
        updateTabButtonStyles()
    }

    private func updateTabButtonStyles() {
        for (index, button) in customTabButtons.enumerated() {
            button.setTitleColor(.white.withAlphaComponent(index == selectedIndex ? 1 : 0.5), for: .normal)
        }
    }

    private func updateGradientVisibility() {
        for (index, view) in gradientViews.enumerated() {
            view.isHidden = index != selectedIndex
        }
    }

    @objc private func handleCartUpdate() {
        let totalItems = cartManager.cartItems.reduce(0) { $0 + $1.amount }
        let cartTitle = totalItems > 0 ? "\(TabItem.cart.title) (\(totalItems))" : TabItem.cart.title

        if let cartButton = customTabButtons[safe: 0] {
            cartButton.setTitle(" " + cartTitle, for: .normal)
        }
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        updateGradientVisibility()
        updateTabButtonStyles()
    }
}

private extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
