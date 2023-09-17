//
//  SiginViewController.swift
//  LoginUI
//
//  Created by mjeed on 17/09/2023.
//

import UIKit

class SiginViewController: UITableViewController {
    // MARK: - Outlets

    
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    
    // MARK: -  Configure Action - Func

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        
        
    }
    

}

// MARK: -  TableView Delegate & DataSource
extension SiginViewController {
    
    // center table view in viewContloer
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
       // let selectedCell = tableView.cellForRow(at: indexPath)
        let selectedCell = tableView.cellForRow(at: indexPath)

        
        // تحريك الخلية لأعلى قليلاً
        UIView.animate(withDuration: 0.2, animations: {
            selectedCell?.transform = CGAffineTransform(translationX: 0, y: -10)
        }) { (_) in
            // إعادة الخلية إلى وضعها الأصلي بعد انتهاء التحريك
            UIView.animate(withDuration: 0.2) {
                selectedCell?.transform = .identity
            }
        }
        
        // إضافة نجمة بسيطة (سمايل) إلى موقع الضغط
        let starImageView = UIImageView(image: UIImage(named: "star"))
        starImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        starImageView.center = selectedCell?.contentView.center ?? CGPoint.zero
        starImageView.contentMode = .scaleAspectFit
        selectedCell?.contentView.addSubview(starImageView)
        
        // إزالة النجمة بعد فترة زمنية (مثلاً 2 ثانية)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            starImageView.removeFromSuperview()
        }


    }
    
}
