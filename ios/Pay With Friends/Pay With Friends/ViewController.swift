//
//  ViewController.swift
//  Pay With Friends
//
//  Created by Charles on 2/8/19.
//  Copyright © 2019 Dangling Pointers LLC. All rights reserved.
//

import UIKit
import NavKit

class ViewController: UIViewController, CustomizableNavigation, UIGestureRecognizerDelegate, UITextFieldDelegate {

    @IBOutlet weak var codeTextField: UITextField!
    
    @IBOutlet weak var navItem: UIBarButtonItem!
    @IBOutlet weak var stackBack: UIView!
    @IBOutlet weak var joinPaymentGroup: UIButton!
    @IBOutlet weak var createPaymentGroup: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navItem.tintColor = .white
        joinPaymentGroup.layer.cornerRadius = 15
        createPaymentGroup.layer.cornerRadius = 15
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        codeTextField.autocorrectionType = .no
        codeTextField.spellCheckingType = .no
        codeTextField.autocapitalizationType = .allCharacters
        codeTextField.keyboardType = .alphabet
        codeTextField.delegate = self
        codeTextField.attributedPlaceholder = NSAttributedString(string: "Code", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red:0.40, green:0.73, blue:0.42, alpha:0.3)])
        
        joinPaymentGroup.isEnabled = false
        joinPaymentGroup.isUserInteractionEnabled = false
        
        self.updateNavigation()

        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let count = text.count + string.count - range.length
        if count >= 5 {
            joinPaymentGroup.backgroundColor = UIColor(red:0.40, green:0.73, blue:0.42, alpha:1.0)
            joinPaymentGroup.isEnabled = true
            joinPaymentGroup.isUserInteractionEnabled = true
        } else {
            joinPaymentGroup.backgroundColor = UIColor(red:0.67, green:0.67, blue:0.67, alpha:1.0)
            joinPaymentGroup.isEnabled = false
            joinPaymentGroup.isUserInteractionEnabled = false
        }
        return count <= 5
    }
    
    @IBAction func joinPaymentGroupAction(_ sender: Any) {
        if codeTextField.text?.count != 5 { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "joinVC") as! PaymentListTableView
        controller.code = codeTextField.text!
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension CustomizableNavigation where Self: UIViewController, Self: UIGestureRecognizerDelegate {
    var titleColor: UIColor { return .white }
    var titleFont: UIFont { return UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold) }
    var barBackgroundColor: UIColor { return UIColor(red:0.40, green:0.73, blue:0.42, alpha:1.0) }
}

// UIColor(red:0.40, green:0.73, blue:0.42, alpha:1.0)
