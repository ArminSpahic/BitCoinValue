//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Armin Spahic on 25/03/2018.
//  Copyright © 2018 Armin Spahic. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencySign = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var currencySelected = ""
    var finalURL = ""

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
       
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //TODO: Place your 3 UIPickerView delegate methods here
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        finalURL = baseURL + currencyArray[row]
        print(finalURL)
        getBitCoinData(url: finalURL)
        currencySelected = currencySign[row]
    }
    
    
    func getBitCoinData(url : String) {
        Alamofire.request(url, method: .get).responseJSON { (response) in
            if response.result.isSuccess{
                print("Success, got the BitCoin data")
                let bitCoinJSON : JSON = JSON(response.result.value)
                print(bitCoinJSON)
                self.updateBitCoinData(json : bitCoinJSON)
            } else {
                print("Data unavailable")
                self.bitcoinPriceLabel.text = "Connection Issues"
                
            }
        }
    }
    
    func updateBitCoinData(json : JSON) {
        if let bitCoinResult = json["ask"].double {
           let bitCoinPrice = String(bitCoinResult)
            self.bitcoinPriceLabel.text =  currencySelected + " " + bitCoinPrice
        } else {
            self.bitcoinPriceLabel.text = "Price unavailable"
        }
        
    }
    
//    
//
//
//    
//    
//    
//    
//
//    




}

