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
    
    var receiptArray = [ReceiptItem]()
    
    override func viewDidLoad() {
        self.title = "Group \(code)"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        NetworkManager.shared.getReceiptItems(onSuccess: { (items) in
            self.receiptArray = items
            self.tableView.reloadData()
            print(items)
        }) { (error) in
            print(error)
        }
        
        let nib = UINib(nibName: "ReceiptItemTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        //tableView.register(UINib(nibName: "ReceiptItemTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receiptArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ReceiptItemTableViewCell {
        let item = receiptArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReceiptItemTableViewCell
        cell.selectionStyle = .none

        cell.foodItemLabel.text = item.name
        cell.foodItemPriceLabel.text = "$\(item.price)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ReceiptItemTableViewCell
        if (cell.chosen == false) {
            cell.backgroundColor = .green
            cell.chosen = true
        } else {
            tableView.cellForRow(at: indexPath)?.backgroundColor = .none
            cell.chosen = false
        }

    }
    
}
