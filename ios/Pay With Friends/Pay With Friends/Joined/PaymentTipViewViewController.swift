//
//  PaymentTipViewViewController.swift
//  Pay With Friends
//
//  Created by Charles on 2/10/19.
//  Copyright © 2019 Dangling Pointers LLC. All rights reserved.
//

import UIKit

class PaymentTipViewViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tip18: UIButton!
    @IBOutlet weak var tip20: UIButton!
    @IBOutlet weak var tip22: UIButton!
    @IBOutlet weak var tipOther: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    var tip: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipOther.delegate = self
        
        tip18.layer.cornerRadius = 20
        tip20.layer.cornerRadius = 20
        tip22.layer.cornerRadius = 20
        tipOther.layer.cornerRadius = 20
        confirmButton.layer.cornerRadius = 20
        
        confirmButton.isUserInteractionEnabled = false
        confirmButton.backgroundColor = .gray
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        tipOther.keyboardType = .numberPad
    }
    
    func tipChanged(to: Int) {
        tip = to
        switch to {
        case 18:
            animateChange(set: tip18, on: true)
            animateChange(set: tip20, on: false)
            animateChange(set: tip22, on: false)
            animateChange(set: tipOther, on: false)
        case 20:
            animateChange(set: tip18, on: false)
            animateChange(set: tip20, on: true)
            animateChange(set: tip22, on: false)
            animateChange(set: tipOther, on: false)
        case 22:
            animateChange(set: tip18, on: false)
            animateChange(set: tip20, on: false)
            animateChange(set: tip22, on: true)
            animateChange(set: tipOther, on: false)
        default:
            animateChange(set: tip18, on: false)
            animateChange(set: tip20, on: false)
            animateChange(set: tip22, on: false)
            animateChange(set: tipOther, on: true)
            customTipUpdater(to: to)
        }
    }
    
    func customTipUpdater(to: Int) {
        tipOther.text = "\(to) %"
    }
    
    func animateChange(set: AnyObject, on: Bool) {
        if let button = set as? UIButton {
            UIView.animateKeyframes(withDuration: 0.2, delay: 0.0, options: [.calculationModeCubicPaced], animations: {
                button.backgroundColor = UIColor(red: 0.40, green: 0.73, blue: 0.42, alpha: (on ? 1 : 0) )
                button.setTitleColor((on ? .white : UIColor(red: 0.40, green: 0.73, blue: 0.42, alpha: 1)), for: .normal)
            }, completion: nil)
        }
        if let textField = set as? UITextField {
            UIView.animateKeyframes(withDuration: 0.2, delay: 0.0, options: [.calculationModeCubicPaced], animations: {
                textField.backgroundColor = UIColor(red: 0.40, green: 0.73, blue: 0.42, alpha: (on ? 1 : 0) )
                textField.textColor = (on ? .white : UIColor(red: 0.40, green: 0.73, blue: 0.42, alpha: 1))
                (on ? print("on") : print("off"))
            }, completion: nil)
        }
    }
    
    @IBAction func clickTip18(_ sender: Any) {
        tipChanged(to: 18)
    }
    
    @IBAction func clickTip20(_ sender: Any) {
        tipChanged(to: 20)
    }
    
    @IBAction func clickTip22(_ sender: Any) {
        tipChanged(to: 22)
    }
    
    @IBAction func clickTipOther(_ sender: UILabel) {
        if sender.text == "" { tipChanged(to: 20); return }
        let result = sender.text?.trimmingCharacters(in: CharacterSet(charactersIn: "01234567890").inverted)
        tipChanged(to: Int(result ?? "21") ?? 21)
    }

}
