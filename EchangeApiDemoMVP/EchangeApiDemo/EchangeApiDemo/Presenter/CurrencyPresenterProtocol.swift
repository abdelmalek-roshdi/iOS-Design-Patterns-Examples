//
//  CurrencyPresenterProtocol.swift
//  EchangeApiDemo
//
//  Created by Abd-Elmalek on 4/23/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import Foundation
import Alamofire
protocol CurrencyPresenterProtocol: AnyObject{
    var handler: ((Eur)->())? {get set}
    var errorHandler: ((AFError)->())? {get set}
    func getcurrency()
   
    
}
