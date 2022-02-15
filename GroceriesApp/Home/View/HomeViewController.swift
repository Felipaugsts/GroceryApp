//
//  HomeViewController.swift
//  GroceriesApp
//
//  Created by FELIPE AUGUSTO SILVA on 15/02/22.
//

import UIKit
protocol homeViewControllerDelegate: AnyObject {
    func didTapMenuButton()
}

class HomeViewController: UIViewController {
    weak var delegate: homeViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "grey-bg")
        title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "list.dash"),
            style: .done,
            target: self, action: #selector(didTapMenuButton) )
    }
    

    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }

}
