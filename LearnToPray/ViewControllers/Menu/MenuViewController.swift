//
//  SettingsViewController.swift
//  LearnToPray
//
//  Created by Mark Tapia on 6/21/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var menuTableView: UITableView!
    lazy var menu = Menu(with: self)
    
    convenience init(transitioningDelegate: UIViewControllerTransitioningDelegate) {
        self.init(nibName: nil, bundle: nil)
        
        self.transitioningDelegate = transitioningDelegate
        modalPresentationStyle = .custom
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.delegate = self
        menuTableView.dataSource = self
    }
    
    @IBAction func backgroundTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.options.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.applyMenuTableViewHeaderStyling()
        label.text = "Menu"
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuCell: UITableViewCell
        let identifier = "menuCell"
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            menuCell = cell
        } else {
            let cellNibName = "MenuTableViewCell"
            let nib = Bundle.main.loadNibNamed(cellNibName, owner: self, options: nil)
            menuCell = nib?.first! as! MenuTableViewCell
        }
        
        menuCell.textLabel?.text = menu.options[indexPath.row].title
        return menuCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        menu.options[indexPath.row].launcher()
    }
}
