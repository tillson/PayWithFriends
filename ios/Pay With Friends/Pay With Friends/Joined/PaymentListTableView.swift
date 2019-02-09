//
//  PaymentListTableView.swift
//  Pay With Friends
//
//  Created by Charles on 2/9/19.
//  Copyright © 2019 Dangling Pointers LLC. All rights reserved.
//

import UIKit

class PaymentListTableView: UITableViewController {
    
    let testArray = [ReceiptItem(name: "Spcy Sand", price: 3.75), ReceiptItem(name: "Ckn Minis 4ct", price: 3.39)]
    
    override func viewDidLoad() {
        print("view")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        print(testArray.count)
        
        let nib = UINib(nibName: "ReceiptItemTableViewCell", bundle: nil)
        print(nib)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        //tableView.register(UINib(nibName: "ReceiptItemTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ReceiptItemTableViewCell {
        let item = testArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReceiptItemTableViewCell
        cell.selectionStyle = .none
        //let cell = ReceiptItemTableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell", receiptItem: item)

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
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("count")
//        return testArray.count
//    }
//
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//
//        print("ran")
//        let item = testArray[indexPath.row]
//        let cell = ReceiptItemTableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell", receiptItem: item)
//
//        cell.foodItemLabel.text = item.name
//        return cell
//    }
    
}
