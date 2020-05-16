//
//  ViewController.swift
//  MovieListNetworking
//
//  Created by Abd-Elmalek on 3/31/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var indicator: UIActivityIndicatorView?
    @IBOutlet weak var tableView: UITableView!
    var movieList: [Movie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        indicator = UIActivityIndicatorView(style: .large)
        indicator?.center = self.view.center
        indicator?.startAnimating()
        if let ind = indicator{
           self.view.addSubview(ind)
        }
        
        let url = URL(string: "https://api.androidhive.info/json/movies.json")
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: .default)
        _ = session.dataTask(with: request) { (data, response, error) in
            do{
                let jsonArray = try JSONSerialization.jsonObject(with: data!, options: []) as! Array<Dictionary<String,Any>>
                for movieObj in jsonArray{
                    let title: String = movieObj["title"] as! String
                    let image: String = movieObj["image"] as! String
                    let nRating = movieObj["rating"]  as? NSNumber
                    let rating: Float = nRating?.floatValue ?? 0.0
                    let nReleaseYear = movieObj["releaseYear"]  as? NSNumber
                    let releaseYear: Int = nReleaseYear?.intValue ?? 0
                    let gener: [String] = movieObj["genre"] as! [String]
                    self.movieList.append(Movie(title: title, image: image, rating: rating, realseYear: releaseYear, gener: gener))
                    
                    
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    if let ind = self.indicator{
                        ind.stopAnimating()
                    }
                }
            }catch{
                print("error fetching data")
            }
            
        }.resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
//        if let index = self.selectedRowIndex{
//            self.tableView.visibleCells
//        }
//        for cell in self.tableView.visibleCells {
//            cell.setSelected(false, animated: true)
//        }
        
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell :CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        let movie = movieList[indexPath.row]
        cell.leftLabel?.text = movie.title
        cell.rightLabel?.text = String(movie.rating)
        cell.customImage?.load.request(with: movie.image)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dVC: DetailsViewController = (self.storyboard?.instantiateViewController(identifier: "detail_viewController"))!
        dVC.movie = movieList[indexPath.row]
        self.navigationController?.pushViewController(dVC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
        
    }

}

