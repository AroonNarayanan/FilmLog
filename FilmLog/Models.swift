//
//  FilmStock.swift
//  FilmLog
//
//  Created by Aroon Narayanan on 12/25/21.
//

import Foundation

struct FilmStock: Identifiable {
    let id = UUID()
    var manufacturer: String = ""
    var stockName: String = ""
    var ISO: Int = 0
    var stockType: StockType = .ColorNegative
}

enum StockType {
    case ColorNegative
    case ColorReversal
    case BWNegative
    case BWReversal
}

enum StockListViewMode {
    case ViewOnly
    case Select
    case Edit
}
