//
//  NetworkManager.swift
//  Pay With Friends
//
//  Created by Tillson Galloway on 2/10/19.
//  Copyright © 2019 Dangling Pointers LLC. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()

    static let baseURL = "https://paywithfriends.appspot.com/"
    
    var receiptItems = [ReceiptItem]()

    
}
