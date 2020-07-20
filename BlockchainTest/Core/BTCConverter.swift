//
//  BTCConverter.swift
//  Blockchain
//
//  Created by Alejandro Arjonilla Garcia on 20/07/2020.
//  Copyright © 2020 aarjincc. All rights reserved.
//
import Foundation

/// Bitcoin formatter converter to handle easily different bitcoin conversions
struct BTCConverter {

    fileprivate let formatter = NumberFormatter()

    let btc: Double
    let locale: Locale

    init(satoshis: Double, locale: Locale = Locale.current) {
        self.btc = satoshis / pow(10, 8)
        self.locale = locale
    }

    func convert() -> String {
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 8
        formatter.decimalSeparator = ((locale as NSLocale).object(forKey: NSLocale.Key.decimalSeparator) as? String ?? "")

        return formatter.string(from: NSNumber(value: self.btc)) ?? "0.00"
    }

}
