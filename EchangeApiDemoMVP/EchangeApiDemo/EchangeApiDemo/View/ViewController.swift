//
//  ViewController.swift
//  EchangeApiDemo
//
//  Created by Abd-Elmalek on 4/23/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController, CurrencyViewProtocol {
    var currencyPresenter: CurrencyPresenterProtocol?
    var eur:Eur?
    @IBOutlet private weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPresenter = CurrencyPresenter(currencyView: self)
        currencyPresenter?.getcurrency()
       
    }

    func showErrorMessage(error: AFError) {
        showAlert(title: "Error", message: error.errorDescription ?? "", button: "Retry"){
            self.currencyPresenter?.getcurrency()
        }
    }
    func UpdateCurrencyDate(currency: Eur) {
        eur = currency
        self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        eur?.rates.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CusomTableViewCell
        
        cell.code =  Array<String>((eur?.rates.keys)!)[indexPath.row].description
        cell.value =  Array<Double>((eur?.rates.values)!)[indexPath.row].description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
}

