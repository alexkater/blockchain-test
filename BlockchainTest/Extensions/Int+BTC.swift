//
//  Int+BTC.swift
//  Blockchain
//
//  Created by Alejandro Arjonilla Garcia on 20/07/2020.
//  Copyright © 2020 aarjincc. All rights reserved.
//

import Foundation

extension Int {

    /// Conver from Int to formatted string for BTC
    func btcFormat(with locale: Locale = Locale.current) -> String {
        return BTCConverter(satoshis: Double(self), locale: locale).convert()
    }
}
