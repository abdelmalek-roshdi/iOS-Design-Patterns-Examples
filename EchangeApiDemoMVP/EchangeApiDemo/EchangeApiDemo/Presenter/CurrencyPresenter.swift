//
//  CurrencyPresenter.swift
//  EchangeApiDemo
//
//  Created by Abd-Elmalek on 4/23/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import Foundation
import Alamofire
class CurrencyPresenter: CurrencyPresenterProtocol {
    
    weak var currencyView:CurrencyViewProtocol?
    private lazy var repo = NetworkRepo()
    var handler: ((Eur)->())?
    var errorHandler: ((AFError)->())?
    
    init(currencyView:CurrencyViewProtocol) {
        self.currencyView = currencyView
        handler = {[weak currencyView] eur in
            
            currencyView?.UpdateCurrencyDate(currency: eur)
        }
        
        errorHandler = {[weak currencyView] error in
            
            currencyView?.showErrorMessage(error: error)
        }
    }
    
    func getcurrency() {
        repo.getCurrency(type: Eur.self, compleationHandler: (handler!),errorHandler: errorHandler!)
    }
    
    
    
 
    
}
