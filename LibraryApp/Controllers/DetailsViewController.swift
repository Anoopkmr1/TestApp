//
//  DetailsViewController.swift
//  LibraryApp
//
//  Created by Anoop on 03/10/23.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var image: UIImage?
    var name: String = ""
    var lastName: String = ""
    var descriptionString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstName.text = lastName
        descriptionLbl.text = descriptionString
        dateLbl.text = "\(Date())"
        getImage()
    }
    
    func getImage() {
        ImageDownloader().imageForCollection(url: lastName) { image in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
}
