## Unit 4 - Models

1. Create model for Movie  
    - New file "Movie.swift" in Models folder  
    - Add the following to the new file:
     ```Swift
        struct Movie {
                let title: String
                let overview: String
                let posterURL: URL
                let backdropURL: URL
        }
      ```
            
2. Update MovieDetailsViewController to use the new movie model instead of the JSON
    - Line 20: "var movie: Movie!"
    - Update viewDidLoad func
    
3. Update MovieViewController to use the new movie model instead of the JSON
    - Line 15: "var movies = [Movie]()"
    - Update viewDidLoad func to turn json into list of movies (see completed file)
    - Update tableView func
    
4. Repeat step 3 for MovieGridViewController

5. Create an enum for the the Cell identififiers and implement it in MovieGridViewController and MoviesViewController

Bonus (if you have extra time): 
    - replace the urls in viewDidLoad with its own enum
    - let the students spend the remaining time updating their Twitter assignment to use models instead of JSON

