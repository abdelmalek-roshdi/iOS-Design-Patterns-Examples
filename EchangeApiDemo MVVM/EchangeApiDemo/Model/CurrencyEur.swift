//
//  CurrencyEur.swift
//  EchangeApiDemo
//
//  Created by Abd-Elmalek on 4/23/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//
import Foundation

struct CurrencyEur: Codable {
    let rates: Dictionary<String, Double>
    let base: String
    let date: String
}
