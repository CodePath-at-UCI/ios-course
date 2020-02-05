//
//  APICaller.swift
//  Flix
//

import Foundation

class API {
    func getMovies(urlString: String, completion: @escaping ([[String: Any]]) -> Void) {
        let url = URL(string: urlString)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let results = dataDictionary["results"] as! [[String:Any]]
                
                // TODO: Convert `results` into a list of movies
                //  For reference, this is what's in `results`
                //  results = [{
                //      "title": String
                //      "overview": String
                //      "poster_path": String
                //      "backdrop_path": String
                //      ...
                //  }]
                
                
                return completion(results)
            }
        }
        task.resume()
    }
}
