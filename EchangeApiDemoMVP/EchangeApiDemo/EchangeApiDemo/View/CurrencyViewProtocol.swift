//
//  CurrencyViewProtocol.swift
//  EchangeApiDemo
//
//  Created by Abd-Elmalek on 4/23/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import Foundation
import Alamofire
protocol CurrencyViewProtocol: AnyObject{
    func showErrorMessage(error: AFError)
    func UpdateCurrencyDate(currency:Eur)
}
