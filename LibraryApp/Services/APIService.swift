//
//  APIService.swift
//  LibraryApp
//
//  Created by Anoop on 03/10/23.
//

import Foundation

//https://jsonplaceholder.typicode.com/albums

//https://jsonplaceholder.typicode.com/photos?albumId={id}

class APIService: NSObject {
    
    static let shared = APIService()
    
    private override init() {
        super.init()
    }

    func getAlbumIdResponse(_ url: String, completion:@escaping([LibraryResponse]) -> ()) {
        let UrlString = URL(string: url)
        let urlRequest = URLSession.shared
        
        let task = urlRequest.dataTask(with: UrlString!) { data, response, error in
            if error != nil {
                print("Error:\(error?.localizedDescription)")
            }
            do {
                //  var resultData: [LibraryResponse]?
                let decoder = JSONDecoder()
                let result = try decoder.decode([LibraryResponse].self, from: data!)
                DispatchQueue.main.async {
                    completion(result)
                }
            } catch {
                print("Anoop_error")
            }
        }
        task.resume()
    }
    
    
    //    var resultData = [DataResponse]()
        
    //    func getData(completion:@escaping([DataResponse]) -> Void) {
    //        let url = Constants.ALBUM_URL
    //        let UrlString = URL(string: url)
    //        let urlRequest = URLSession.shared
    //
    //        let task = urlRequest.dataTask(with: UrlString!) { [self] data, response, error in
    //            if error != nil {
    //                print("Error:\(error?.localizedDescription)")
    //            }
    //            do {
    //                var resultData: [DataResponse]?
    //                let decoder = JSONDecoder()
    //                let result = try decoder.decode([DataResponse].self, from: data!)
    //                resultData = result
    //                DispatchQueue.main.async {
    //                    completion(resultData!)
    //                }
    //            } catch {
    //                print("Anoop_error")
    //            }
    //        }
    //        task.resume()
    //    }

}
