//
//  NetworkRepo.swift
//  EchangeApiDemo
//
//  Created by Abd-Elmalek on 4/23/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
    
    func fetchDataFromNetwork<T>() -> Observable<T> where T:Codable  {
        
      return  Observable<T>.create { (obj) -> Disposable in
           
            AF.request(Constannts.BaseURL)
            .validate(contentType: ["application/json"])
            .responseJSON{ response in
                switch response.result {
                
                case .success:
                    
                    guard let data = response.data else{return}
                    
                    let fetchedData = try? JSONDecoder().decode(T.self, from: data)
                    
                    if let fetchedData = fetchedData {
                        obj.onNext(fetchedData)
                    }
                    
                case let .failure(error):
                    obj.onError(error)
                }
            }

            return Disposables.create()
        }
            
}
    

