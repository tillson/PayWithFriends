//
//  ViewController.swift
//  Pay With Friends
//
//  Created by Charles on 2/8/19.
//  Copyright © 2019 Dangling Pointers LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var codeTextField: UITextField!
    
    @IBOutlet weak var joinPaymentGroup: UIButton!
    @IBOutlet weak var createPaymentGroup: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        joinPaymentGroup.layer.cornerRadius = 15
        createPaymentGroup.layer.cornerRadius = 15
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        codeTextField.autocorrectionType = .no
        codeTextField.spellCheckingType = .no
        codeTextField.autocapitalizationType = .allCharacters
        codeTextField.keyboardType = .alphabet
        codeTextField.delegate = self
        
        joinPaymentGroup.isEnabled = false
        joinPaymentGroup.isUserInteractionEnabled = false        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let count = text.count + string.count - range.length
        if count == 5 {
            joinPaymentGroup.backgroundColor = UIColor(red: 0.26, green: 0.65, blue: 0.96, alpha: 1.0)
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

