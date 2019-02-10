//
//  PaymentTipViewViewController.swift
//  Pay With Friends
//
//  Created by Charles on 2/10/19.
//  Copyright © 2019 Dangling Pointers LLC. All rights reserved.
//

import UIKit

class PaymentTipViewViewController: UIViewController {

    @IBOutlet weak var tip18: UIButton!
    @IBOutlet weak var tip20: UIButton!
    @IBOutlet weak var tip22: UIButton!
    @IBOutlet weak var tipOther: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipOther.keyboardType = .numberPad
    }
    
    func tipChanged(to: Int) {
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
        }
    }
    
    func animateChange(set: AnyObject, on: Bool) {
        if let object = set as? UIView {
            UIView.animateKeyframes(withDuration: 0.2, delay: 0.0, options: [.calculationModeCubicPaced], animations: {
                object.backgroundColor = UIColor(red: 0.40, green: 0.73, blue: 0.42, alpha: (on ? 1 : 0) )
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
        tipChanged(to: Int(sender.text ?? "21") ?? 21)
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
