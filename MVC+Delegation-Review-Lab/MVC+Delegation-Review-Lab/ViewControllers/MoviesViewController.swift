import UIKit

class MoviesViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var moviesTableView: UITableView!
    
    // MARK: - Private Properties
    
    private var movies = [Movie]() {
        didSet {
            moviesTableView.reloadData()
        }
    }
    
    private var fontSize: CGFloat = Constants.startingFontSize
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        loadMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        moviesTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "settingsSegue" else { fatalError("Unexpected Segue ID") }
        guard let settingsVC = segue.destination as? FontChangeSettingsViewController else {
            fatalError("Unexpected segue destination")
        }
        settingsVC.delegate = self
        settingsVC.initialStartingFontSize = fontSize
    }
    
    // MARK: - Private methods
    
    private func loadMovies() {
        self.movies = Movie.allMovies
    }
}

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = moviesTableView.dequeueReusableCell(withIdentifier: "movieCell") else {
            fatalError("Invalid cell ID")
        }
        let movie = movies[indexPath.row]
        cell.textLabel?.text = movie.name
        cell.textLabel?.font = cell.textLabel?.font.withSize(fontSize)
        cell.detailTextLabel?.text = "\(movie.year)"
        cell.detailTextLabel?.font = cell.detailTextLabel?.font.withSize(fontSize - 3)
        return cell
    }
}

extension MoviesViewController: UITableViewDelegate {}

extension MoviesViewController: FontSizeChangeable {
    func changeFontSize(to newFontSize: CGFloat) {
        fontSize = newFontSize
    }
}
