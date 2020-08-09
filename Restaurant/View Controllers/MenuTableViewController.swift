//
//  MenuTableViewController.swift
//  Restaurant
//
//  Created by Dimon on 28.06.2020.
//  Copyright © 2020 Dimon. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    var category: String!
    var menuItems = [MenuItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = category.capitalized
        MenuController.shared.fetchMenuItems(forCategory: category) { (menuItems) in
            if let menuItems = menuItems {
                self.updateUI(with: menuItems)
            }
        }
        
    }

    func updateUI(with menuItems: [MenuItem]) {
        DispatchQueue.main.async {
            self.menuItems = menuItems
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCellIdentifier", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let menuItem = menuItems[indexPath.row]
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = String(format: "$%.2f", menuItem.price)
        
        MenuController.shared.fetchImage(url: menuItem.imageURL) { (image) in
            guard let image = image else {return}
        
            DispatchQueue.main.async {
                if let currentIndexPath = self.tableView.indexPath(for: cell),
                    currentIndexPath != indexPath {
                    return
                }
                
                cell.imageView?.image = image
                cell.setNeedsLayout()
                cell.layoutIfNeeded()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuDetailSegue" {
            let menuItemDetailViewController = segue.destination as! MenuItemDetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            menuItemDetailViewController.menuItem = menuItems[index]
        }
    }
    
}



final class MenuItemCell: UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.frame.size.width = 88.0
        
        let maxX = detailTextLabel?.frame.maxX ?? .zero
        let minX = imageView.map { $0.frame.maxX + 16.0 } ?? .zero
        let detailWidth = detailTextLabel?.sizeThatFits(bounds.size).width ?? .zero
        detailTextLabel?.frame.origin.x = maxX - detailWidth
        detailTextLabel?.frame.size.width = detailWidth
        
        textLabel?.frame.origin.x = minX
        textLabel?.frame.size.width = maxX - detailWidth - 8.0 - minX
        
        separatorInset.left = minX
    }
}
