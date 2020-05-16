//
//  ViewContorollerExtension.swift
//  Teamsocity
//
//  Created by Abd-Elmalek on 4/22/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, button: String, completionHandler: (() -> ())?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction(title: button, style: UIAlertAction.Style.destructive){ action in
            (completionHandler ?? {})()
        })
        self.present(alert, animated: true, completion: nil)
    }
}
