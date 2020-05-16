//
//  ViewController.swift
//  EchangeApiDemo
//
//  Created by Abd-Elmalek on 4/23/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import UIKit
import Alamofire
import RxCocoa
import RxSwift
import RxRelay
class ViewController: UIViewController {
    var currencyViewModel: ViewModelProtocol?
    lazy var disposeBag = DisposeBag()
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViewModel()
        setUpTableView()
        setUpSearchBar()
       
    }
    
    func setUpSearchBar(){
        searchBar
            .rx
            .text
            .orEmpty
            .throttle(.milliseconds(100), scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: {[weak self] (text) in
                self?.currencyViewModel?.filterWord(text)
            }).disposed(by: disposeBag)
    }
    
    func setUpViewModel(){
        currencyViewModel = CurrencyViewModel()
        currencyViewModel?.fetchCurrencyFromNetwork()
    
    }
    
    func setUpTableView(){
        tableView.rowHeight = 90
        currencyViewModel?.currencyDriver?.drive(tableView.rx.items(cellIdentifier: "cell", cellType: CusomTableViewCell.self)){(index, rate, cell) in
            cell.code = rate.key
            cell.value = rate.value.description
        }.disposed(by: disposeBag)
    }

    func showErrorMessage(error: AFError) {
        showAlert(title: "Error", message: error.errorDescription ?? "", button: "Retry"){
           
        }
    }
    
}




