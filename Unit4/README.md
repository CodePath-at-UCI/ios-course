## Unit 4 - Models

#### Download the starter: [unit4_starter.zip](https://github.com/CodePath-at-UCI/ios-course/raw/master/Unit4/unit4_starter.zip)

#### Instructions 

1. Create model for Movie  
    - New swift file "Movie.swift" in Models folder  
    - Add the following to the new file:
        ```Swift
        struct Movie {
            let title: String
            let overview: String
            let posterURL: URL
            let backdropURL: URL
        }
        ```
            
2. In "Helpers/APICaller.swift", convert the results `[Dictionary]` to `[Movie]`
    - Note: explain that basePosterUrl & baseBackdropUrl are coming from the controller classes. We are constructing the URL here, so we don't have to do it there.
    - Add the following after line 30:
        ```Swift
        var movies = [Movie]()
                
        for movieDict in results{
            // Poster URL
            let posterPath = movieDict["poster_path"] as! String
            let posterBase = "https://image.tmdb.org/t/p/w185"
            let posterUrl = URL(string: posterBase + posterPath)!
                    
            // Backdrop URL
            let backdropPath = movieDict["backdrop_path"] as! String
            let backdropBase = "https://image.tmdb.org/t/p/w780"
            let backdropURL = URL(string: backdropBase + backdropPath)!
                            
            let movie = Movie(
                title: movieDict["title"] as! String,
                overview: movieDict["overview"] as! String,
                posterURL: posterUrl,
                backdropURL: backdropURL
            )
                    
            movies.append(movie)
        }
        ```
    - Change line 53 to `return completion(results)`
    - Change line 9 from `@escaping ([[String: Any]])` to `@escaping ([Movie])`

3. Update MovieViewController to use the new movie model instead of the JSON
    - Line 14: `var movies = [Movie]()`
    - Update tableView func to use Movie class

4. Update MovieGridViewController to use the new movie model instead of the JSON
    - Line 14: `var movies = [Movie]()`
    - Update tableView func to use Movie class

5. Update MovieDetailsViewController to use the new movie model instead of the JSON
    - Line 17: `var movie: Movie!`
    - Update viewDidLoad func to use Movie class
    
6. Create an enum file for the the Cell identifiers 
    - Explain that this helps prevent errors when typing cell identifiers (no SIGABRTs!)
    - New file "Enums.swift" in Models folder
    - Add the following to the new file:
        ```Swift
        enum Cell: String {
            case MovieCell, MovieGridCell
        }
        ```
    - Implement it in MovieGridViewController (line 45: `Cell.MovieGridCell.rawValue`
 and MoviesViewController (line 40: `Cell.MovieCell.rawValue`)

7. Create an enum in "Enums.swift" for URLs
    - Add the following to "Enums.swift":
        ```Swift
        enum MovieBaseURL: String {
            case NowPlaying = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
            case SuperHeroes = "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
            case Poster = "https://image.tmdb.org/t/p/w185"
            case Backdrop = "https://image.tmdb.org/t/p/w780"
        }
        ```
    - Implement them in the following places 
        - MoviesViewController line 29: `MovieBaseURL.NowPlaying.rawValue`
        - MovieGridViewController line 32: `MovieBaseURL.SuperHeroes.rawValue`
        - APICaller line 35: `MovieBaseURL.Poster.rawValue`
        - APICaller line 40: `MovieBaseURL.Backdrop.rawValue`

Bonus (if you have extra time):  
    - let the students spend the remaining time updating their Twitter assignment to use models instead of JSON

