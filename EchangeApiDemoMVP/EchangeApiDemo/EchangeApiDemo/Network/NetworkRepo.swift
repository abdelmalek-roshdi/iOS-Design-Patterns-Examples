//
//  NetworkRepo.swift
//  EchangeApiDemo
//
//  Created by Abd-Elmalek on 4/23/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import Foundation
import Alamofire

class NetworkRepo{
    
    lazy var networkQueue = DispatchQueue(label: "networkQueue", qos: .utility, attributes: .concurrent)
    
    func getCurrency<T>(type :T.Type, compleationHandler: @escaping (T)->()?, errorHandler: @escaping (AFError)->()?) where T:Codable {
            
            networkQueue.async {
                AF.request(Constannts.BaseURL)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseJSON{ response in
                    switch response.result {
                    case .success:
                        guard let data = response.data else{return}
                        let currency = try? JSONDecoder().decode(T.self, from: data)
                        
                        DispatchQueue.main.async {
                            compleationHandler(currency!)
                        }
                        
                        print("Successfully Fetched Data")
                    case let .failure(error):
                        errorHandler(error)
                    }
                }
            }
        }
    
    
    //    func getCurrency<T: Codable>(type: T.Type) {
    //
    //        networkQueue.async {
    //            AF.request(Constannts.BaseURL)
    //            .validate(statusCode: 200..<300)
    //            .validate(contentType: ["application/json"])
    //            .responseJSON{ response in
    //                switch response.result {
    //                case .success:
    //                    guard let _ = response.data else{return}
    //
    //                    //mcurrency = JS
    //
    //                    if let currency = try? response.result.get(){
    //
    //
    //
    //                        print(currency as! [String:Any])
    //
    //                    }
    //
    //                    DispatchQueue.main.async {
    ////                        for currency in currencyArray!{
    ////                            print(currency.rates)
    ////                        }
    //                    }
    //                    print("Successfully Fetched Data")
    //                case let .failure(error):
    //                    print(error)
    //                }
    //            }
    //        }
    //    }
        
}
