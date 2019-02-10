//
//  NetworkManager.swift
//  Pay With Friends
//
//  Created by Tillson Galloway on 2/10/19.
//  Copyright © 2019 Dangling Pointers LLC. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    
    static let shared = NetworkManager()

    static let baseURL = "https://paywithfriends.appspot.com/api/"
    
    var receiptItems = [ReceiptItem]()
    
    func uploadReceipt(data: Data, onSuccess: @escaping([ReceiptItem]) -> Void, onFailure: @escaping(Error) -> Void) {
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(data, withName: "receipt")
                    },
                  to: NetworkManager.baseURL + "uploadReceipt").responseJSON { response in
            if let error = response.error {
                onFailure(error)
                return
            }
            guard let object = response.result.value else {
                print("Oh, no!!!")
                return
            }
            var array = [ReceiptItem]()
            let json = JSON(object)
            if let jArray = json.array {
                print(jArray)
                for jObject in jArray {
                    if let id = jObject["id"].string,
                        let name = jObject["name"].string,
                        let price = jObject["price"].float {
                        array.append(ReceiptItem(id: id, name: name, price: price))
                    }
                }
            }
            self.receiptItems = array
            onSuccess(array)
        }
    }

    func getReceiptItems(onSuccess: @escaping([ReceiptItem]) -> Void, onFailure: @escaping(Error) -> Void) {
        AF.request(NetworkManager.baseURL + "getReceiptItems").responseJSON { response in
            print(response.request?.httpBody)
            if let error = response.error {
                
                onFailure(error)
                return
            }
            var array = [ReceiptItem]()
            guard let object = response.result.value else {
                print("Oh, no!!!")
                return
            }
            let json = JSON(object)
            if let jArray = json.array {
                for jObject in jArray {
                    if let id = jObject["id"].string,
                        let name = jObject["name"].string,
                        let price = jObject["price"].float {
                        array.append(ReceiptItem(id: id, name: name, price: price))
                    }
                }
            }
            self.receiptItems = array
            onSuccess(array)
        }
    }
    
    func addReceiptItem(receiptItem: ReceiptItem, onSuccess: @escaping() -> Void, onFailure: @escaping(Error) -> Void) {
        AF.request(NetworkManager.baseURL + "addReceiptItem", method: .post, parameters: ["id":receiptItem.id, "user": 1]).responseJSON { response in
            if let error = response.error {
                onFailure(error)
                return
            }
            onSuccess()
        }
    }

    func removeReceiptItem(receiptItem: ReceiptItem, onSuccess: @escaping() -> Void, onFailure: @escaping(Error) -> Void) {
        AF.request(NetworkManager.baseURL + "removeReceiptItem", method: .post, parameters: ["id":receiptItem.id, "user": 1]).responseJSON { response in
            if let error = response.error {
                onFailure(error)
                return
            }
            onSuccess()
        }
    }

    
}
