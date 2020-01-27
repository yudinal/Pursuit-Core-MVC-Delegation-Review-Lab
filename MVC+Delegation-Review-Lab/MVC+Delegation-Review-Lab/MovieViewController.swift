//
//  ViewController.swift
//  MVC+Delegation-Review-Lab
//
//  Created by Benjamin Stone on 8/19/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController, FontSize {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies = [Movie]()
 
    
    var fontSizes = 13.0 {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadItems()
    
    }
    
    private func loadItems() {
        movies = Movie.allMovies
     }
    
    @IBAction func settings(segue: UIStoryboardSegue) {
        guard let createMovieController = segue.source as? FontChangeViewController else {
            fatalError("failed to access FontChangeViewController")
        }
        fontSizes = Double(createMovieController.fontSize)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let createMovieController = segue.destination as? FontChangeViewController else {
            fatalError("failed to access FontChangeViewController")
        }
        createMovieController.delegate = self
    }
    
    func changeFontSize(_ size: CGFloat) {
        self.fontSizes = Double(size)
    }
    
    
    private func showFontChangeVC(_ movie: Movie? = nil) {
        guard let fontChangeViewController = storyboard?.instantiateViewController(identifier: "FontChangeViewController") as? FontChangeViewController else {
            fatalError("Could not downcast to FontChangeViewController")
        }
        fontChangeViewController.movie = movie
        present(fontChangeViewController, animated: true)
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

extension MovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        showFontChangeVC(movie)
    }
}


