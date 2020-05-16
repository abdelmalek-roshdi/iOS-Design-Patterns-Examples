//
//  DetailsViewController.swift
//  MovieList
//
//  Created by Abd-Elmalek on 3/25/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import UIKit
class DetailsViewController: UIViewController {
    var movie : Movie?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var genersLabel: UILabel!
  
    @IBOutlet weak var reLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLabel.text = movie?.title
        ratingLabel.text = movie?.rating.description
        reLabel.text = movie?.realseYear.description
        movieImage?.load.request(with: movie?.image ?? "")
        genersLabel.text = movie?.gener.description
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
