//
//  NavigationController.swift
//  Test App MVVM
//
//  Created by Victor on 01.02.2021.
//

import UIKit

class NavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    func configureStyle() {
        self.navigationBar.isTranslucent = false
        
        self.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont(name: "Helvetica-Bold", size: 26.0)!
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        self.interactivePopGestureRecognizer?.delegate = self
        self.configureStyle()
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.viewControllers.count > 1 && !self.viewControllers.last!.navigationItem.hidesBackButton
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        let navigationController = NavigationController.init(rootViewController: viewControllerToPresent)
        return super.present(navigationController, animated: flag, completion: completion)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        super.pushViewController(viewController, animated: animated)
    }
}
