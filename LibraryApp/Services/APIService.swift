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

    
    func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(_ result: T)-> Void) {
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            if(error == nil && responseData != nil && responseData?.count != 0)
            {
                //parse the responseData here
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: responseData!)
                    DispatchQueue.main.async {
                        _=completionHandler(result)
                    }
                }
                catch let error{
                    debugPrint("error occured while decoding = \(error.localizedDescription)")
                }
            }
            
        }.resume()
    }

}
