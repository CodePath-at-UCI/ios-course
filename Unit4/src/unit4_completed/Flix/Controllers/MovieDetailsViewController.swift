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
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = movie.title
        synopsisLabel.text = movie.overview
        
        posterView.af_setImage(withURL: movie.posterURL)

        backdropView.af_setImage(withURL: movie.backdropURL)
        
        synopsisLabel.sizeToFit() //Prevents the text from getting cut-off with ...
    }
}
