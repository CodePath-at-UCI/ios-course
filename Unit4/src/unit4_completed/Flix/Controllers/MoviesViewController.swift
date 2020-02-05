//
//  MoviesViewController.swift
//  Flix
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    // TODO: Change the type of movies from `[[String:Any]]` to `[Movie]`
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        //Extends the cells to fit the larger 'synopsis label'
        //Estimated row height comes from the image view ( height=130, top constraint=8,
        //bottom constraint=8)  -> 130 + 8 + 8
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 130 + 8 + 8
        
        
        API().getMovies(urlString: MovieBaseURL.NowPlaying.rawValue, completion: { (movies) in
                self.movies = movies
                self.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.MovieCell.rawValue) as! MovieCell
        
        let movie = movies[indexPath.row]
        
        cell.titleLabel.text = movie.title
        cell.synopsisLabel.text = movie.overview
        
        cell.posterView.af_setImage(withURL: movie.posterURL)
        
        
        return cell
    }
    
    
    //MARK: - Navigation

    //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Get the new view controller using segue.destination.
        //Pass the selected object to the new view controller.
        
        //Find the selected movie
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        //Pass the selected movie to the details movies controller
        let detailsViewController = segue.destination as! MovieDetailsViewController
        
        //There is a variable in the class that we want to send stuff to that we define here
        detailsViewController.movie = movie
        
        //Deselects the row after you come back to the view
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
