//
//  MovieDetailsViewController.swift
//  Flix
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    // TODO: Change the type of movie from `[String:Any]` to `Movie`
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = movie["title"] as? String
        synopsisLabel.text = movie["overview"] as? String
        
        let posterPath = movie["poster_path"] as! String
        let posterBase = "https://image.tmdb.org/t/p/w185"
        let posterUrl = URL(string: posterBase + posterPath)
        posterView.af_setImage(withURL: posterUrl!)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropBase = "https://image.tmdb.org/t/p/w780"
        let backdropURL = URL(string: backdropBase + backdropPath)
        backdropView.af_setImage(withURL: backdropURL!)
        
        synopsisLabel.sizeToFit() //Prevents the text from getting cut-off with ...
    }
}
