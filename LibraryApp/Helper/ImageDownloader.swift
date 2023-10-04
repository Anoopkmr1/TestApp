//
//  ImageDownloader.swift
//  LibraryApp
//
//  Created by Anoop on 04/10/23.
//

import Foundation
import UIKit


class ImageDownloader {
    func imageForPlaceHolder() -> UIImage {
        return UIImage(named: "hero")!
    }
    
    func imageForCollection(url: String, completion: @escaping (UIImage) -> ()) {
        guard let imageURL = URL(string: url) else {
            completion(self.imageForPlaceHolder())
            return
        }
        // url is converted to the data format and then image is retrieved from there
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageURL) {
                if let downloadImage = UIImage(data: data) {
                    DispatchQueue.main.async{
                        completion(downloadImage)
                    }
                }
            }
        }
    }
}
