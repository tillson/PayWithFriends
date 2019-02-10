//
//  PaymentListTableView.swift
//  Pay With Friends
//
//  Created by Charles on 2/9/19.
//  Copyright © 2019 Dangling Pointers LLC. All rights reserved.
//

import UIKit

class PaymentListTableView: UITableViewController {
    
    var code = ""
    
    var timer = Timer()

    var receiptArray = [ReceiptItem]()
    var userSelectedItems = [String]()
    
    override func viewDidLoad() {
        self.title = "Group \(code)"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            NetworkManager.shared.getReceiptItems(onSuccess: { (newItems) in
                self.receiptArray = newItems
                self.tableView.reloadData()
            }, onFailure: { (error) in
            })
        })
        
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextView))
        self.navigationItem.rightBarButtonItem = nextButton
        
        NetworkManager.shared.getReceiptItems(onSuccess: { (items) in
            self.receiptArray = items
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
        
        let nib = UINib(nibName: "ReceiptItemTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        //tableView.register(UINib(nibName: "ReceiptItemTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "cell")
    }
    
    @objc func nextView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "tipVC")
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receiptArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ReceiptItemTableViewCell {
        let item = receiptArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReceiptItemTableViewCell
        cell.selectionStyle = .none

        cell.foodItemLabel.text = item.name
        let moneyString = String(format: "%.2f", (item.price / Float(item.people)))
        cell.foodItemPriceLabel.text = "$\(moneyString)"
        if item.people > 1 {
            cell.splitLabel.text = "Split between \(item.people) friends"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ReceiptItemTableViewCell
        if (cell.chosen == false) {
            cell.backgroundColor = .green
            cell.chosen = true
            NetworkManager.shared.addReceiptItem(receiptItem: cell.receiptItem, onSuccess: {  }, onFailure: { _ in })
        } else {
            tableView.cellForRow(at: indexPath)?.backgroundColor = .none
            cell.chosen = false
            NetworkManager.shared.removeReceiptItem(receiptItem: cell.receiptItem, onSuccess: {  }, onFailure: { _ in })
        }

    }
    
}
