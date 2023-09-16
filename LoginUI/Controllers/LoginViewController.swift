//
//  ViewController.swift
//  LoginUI
//
//  Created by mjeed on 15/09/2023.
//

import UIKit

class LoginViewController: UITableViewController {

    // MARK: - Outlets

    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
        

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let tableViewHeight = self.tableView.frame.height
        let contentHeight = self.tableView.contentSize.height
        
        
        let centeringInset = (tableViewHeight - contentHeight) / 2.0
        let topInset = max(centeringInset, 0.0)
        
        self.tableView.contentInset = UIEdgeInsets(top: topInset, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    // MARK: -  Configure Action - Func
    
    


}

