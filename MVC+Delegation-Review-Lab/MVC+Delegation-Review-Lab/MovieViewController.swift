//
//  ViewController.swift
//  MVC+Delegation-Review-Lab
//
//  Created by Benjamin Stone on 8/19/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies = Movie.allMovies
    
    
    var fontSizes = 13 {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    
    }
    @IBAction func settings(segue: UIStoryboardSegue) {
        guard let createMovieController = segue.source as? FontChangeViewController else {
            fatalError("failed to access FontChangeViewController")
        }
        fontSizes = Int(createMovieController.fontSize)
    }

}



extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        let movieData = movies[indexPath.row]
        
        cell.textLabel?.text = movieData.name
        cell.detailTextLabel?.text = movieData.year.description
        
        cell.textLabel?.font = UIFont(name: "Didot", size: 17)
        cell.detailTextLabel?.font = UIFont(name: "Didot", size: CGFloat(fontSizes))
           
        return cell
    }
}

