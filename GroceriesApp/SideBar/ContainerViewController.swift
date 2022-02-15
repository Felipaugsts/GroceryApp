//
//  ViewController.swift
//  GroceriesApp
//
//  Created by FELIPE AUGUSTO SILVA on 15/02/22.
//

import UIKit

class ContainerViewController: UIViewController {
    
    enum MenuState {
        case opened
        case closed
    }
    private var menuState: MenuState = .closed
    
    let menuVC = MenuViewController()
    let homeVC = HomeViewController()
    var navVC: UINavigationController?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addChildsVC()
    }

    func addChildsVC() {
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        homeVC.delegate = self
        let navVc = UINavigationController(rootViewController: homeVC)
        addChild(navVc)
        view.addSubview(navVc.view)
        navVc.didMove(toParent: self)
        self.navVC = navVc
    }
}


extension ContainerViewController: homeViewControllerDelegate {
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> Void)?) {
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 120
            } completion: { done in
                if done {
                    self.menuState = .opened
                }
            }

        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
            } completion: { done in
                if done {
                    self.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
    
}


extension ContainerViewController: MenuViewControllerDelegate {
    func didSelect(menuItem: MenuViewController.MenuOptions) {
        toggleMenu { [weak self] in 
            switch menuItem {
                
            case .home:
                break
            case .info:
                break
            case .settings:
                let sttg = settingsViewController()
                self?.present(UINavigationController(rootViewController: sttg), animated: true, completion: nil)
            }
        }
    }
    
 
    
}
