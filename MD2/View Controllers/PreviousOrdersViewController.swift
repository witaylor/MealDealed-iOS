//
//  PreviousOrdersViewController.swift
//  MD2
//
//  Created by Will Taylor on 15/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import UIKit

class PreviousOrdersViewController: UITableViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Previous Orders"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coordinator?.orderManager?.orderCount() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PreviousOrderTableViewCell", for: indexPath) as? PreviousOrderTableViewCell else { return UITableViewCell() }
        
        let order = coordinator?.orderManager?.order(forIndex: indexPath.item)
        cell.order = order
        cell.reorderFunction = coordinator?.checkout(withMeal:)
        
        return cell
    }
}
