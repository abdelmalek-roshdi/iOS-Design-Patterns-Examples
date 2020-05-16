//
//  CusomCollectionViewCell.swift
//  EchangeApiDemo
//
//  Created by Abd-Elmalek on 4/23/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import UIKit

class CusomTableViewCell: UITableViewCell {
    var code:String?{
        didSet{
            codeLabel.text = code
        }
    }
    var value:String?{
        didSet{
            valueLabel.text = value
        }
    }
    @IBOutlet private weak var codeLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    
}
