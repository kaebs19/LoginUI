//
//  SiginViewController.swift
//  LoginUI
//
//  Created by mjeed on 17/09/2023.
//

import UIKit

class SiginViewController: UITableViewController {
    // MARK: - Outlets

    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var userNameTextfield: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var confgerTextField: UITextField!

    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tapGesture()
        
        circlImage()
    }
    
    // func objt
    
    private func circlImage() {
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.size.height / 2
    }
    
    fileprivate func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureReognizer:)))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tapGesture)
    }

    
    @objc func imageTapped(tapGestureReognizer: UITapGestureRecognizer) {
        print("image Tapped!")
        openGallery()
    }
    
    
    
    // MARK: -  Configure Action - Func

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        guard let user = userNameTextfield.text,
              let email = emailTextField.text,
              let password = passwordTextField.text,
              let confirmPassword = confgerTextField.text else {
            return
        }
        
        let imageSystem = UIImage(systemName: "person.fill.badge.plus")
        
        if profileImage.image?.pngData() == imageSystem?.pngData() {
            // إذا لم يتم اختيار صورة الملف الشخصي
            showAlert(title: "Error", message: "Please select profile picture frist")
        }else if user.isEmpty {
            self.showAlert(title: "Error", message: "Please enter user name")
        } else if !email.validateEmailId() {
            // إذا كان البريد الإلكتروني غير صحيح
            showAlert(title: "Error", message: "Please enter a valid email")
        } else if !password.validatePassword() {
            // إذا كانت كلمة المرور غير صحيحة
            showAlert(title: "Error", message: "Please enter a valid password")
        } else if user.isEmpty {
            showAlert(title: "Error", message: "Please enter user name")
        } else if !confirmPassword.isEmpty {
            if password == confirmPassword {
                // navigation code
                print("Navigation code")
            } else {
                showAlert(title: "Error", message: "Passwords do not match")
            }
        }
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

extension SiginViewController:UINavigationControllerDelegate , UIImagePickerControllerDelegate {
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .savedPhotosAlbum
            present(picker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            profileImage.image = image
        }
        dismiss(animated: true)
    }
}
