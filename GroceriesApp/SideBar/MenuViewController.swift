//
//  MenuViewController.swift
//  GroceriesApp
//
//  Created by FELIPE AUGUSTO SILVA on 15/02/22.
//

import UIKit

protocol MenuViewControllerDelegate: AnyObject {
    func  didSelect(menuItem: MenuViewController.MenuOptions)
}

class MenuViewController: UIViewController {

    
    weak var delegate: MenuViewControllerDelegate?
    enum MenuOptions: String, CaseIterable {
        case home = "Home"
        case info = "About us"
        case settings = "Settings"

        var imageName: String {
            switch self {
            case .home:
                return "house"
            case .info:
                return "pencil"
            case .settings:
               return "gear"
            }
        }
    }
    let purple = UIColor(named: "purple-default")
    private let WelcomeText: UILabel = {
           var label = UILabel()
            label.text = "Olá, como vai?"
            return label
        }()
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.backgroundColor = nil
        table.separatorStyle = .none
        return table
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(WelcomeText)
        WelcomeText.textColor = purple
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        WelcomeText.frame = CGRect(x: 60, y: view.safeAreaInsets.top, width: view.bounds.size.width, height: 50)
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top + 90, width: view.bounds.size.width, height: view.bounds.size.height)
    }

}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        cell.backgroundColor = .white
        cell.contentView.backgroundColor = .white
        cell.textLabel?.textColor = purple
        cell.imageView?.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
        cell.imageView?.tintColor = purple
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOptions.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }
    
    
}
