//
//  ReceiptItemTableViewCell.swift
//  Pay With Friends
//
//  Created by Charles on 2/9/19.
//  Copyright © 2019 Dangling Pointers LLC. All rights reserved.
//

import UIKit

class ReceiptItemTableViewCell: UITableViewCell {

    @IBOutlet weak var foodItemPriceLabel: UILabel!
    @IBOutlet weak var foodItemLabel: UILabel!
    @IBOutlet weak var splitLabel: UILabel!
    
    var receiptItem: ReceiptItem
    var chosen: Bool
        
    public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, receiptItem: ReceiptItem) {
        self.receiptItem = receiptItem
        self.chosen = false
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.receiptItem = ReceiptItem(id: "Err", name: "Err", price: -1)
        self.chosen = false
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
}
