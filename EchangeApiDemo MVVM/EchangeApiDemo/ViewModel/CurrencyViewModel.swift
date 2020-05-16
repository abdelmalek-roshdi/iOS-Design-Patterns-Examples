//
//  CurrencyViewModel.swift
//  EchangeApiDemo
//
//  Created by Abd-Elmalek on 4/25/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelProtocol {
  
    var currencyDriver:Driver<Dictionary<String, Double>>?{set get}
    func fetchCurrencyFromNetwork()
    func filterWord(_ word: String)
}

class CurrencyViewModel: ViewModelProtocol{
    
    private var currency: CurrencyEur?
    private var disposeBag: DisposeBag?
    private var currencySubject: PublishSubject<CurrencyEur>?
    var currencyDriver:Driver<Dictionary<String, Double>>?
    
    init() {
        disposeBag = DisposeBag()
        currencySubject = PublishSubject<CurrencyEur>()
        currencyDriver = currencySubject?.asDriver(onErrorJustReturn: CurrencyEur(rates: [:], base: "", date: "")).map{$0.rates}
    }
    
    func fetchCurrencyFromNetwork(){
        let currencyObservable:Observable<CurrencyEur> = fetchDataFromNetwork()
        
        currencyObservable.subscribe(onNext: {[weak self] (currency) in
            self?.currencySubject?.onNext(currency)
            self?.currency = currency
            
        }, onError: {[weak self] (error) in
            self?.currencySubject?.onError(error)
        }).disposed(by: disposeBag ?? DisposeBag())
    }
    
    func filterWord(_ word: String){
        
        let filteredCurrencies = self.currency?.rates.filter{$0.key.hasPrefix(word.uppercased())
        }
        
        if let filteredCurrencies = filteredCurrencies{
            currencySubject?.onNext(CurrencyEur(rates: filteredCurrencies, base: self.currency?.base ?? "", date: self.currency?.date ?? ""))
        }
    }
    
}
