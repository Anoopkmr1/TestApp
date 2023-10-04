//
//  ViewController.swift
//  LibraryApp
//
//  Created by Anoop on 03/10/23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tabScrollView: TabScrollView!
    
    var responseData = [DataResponse]()
    var albumIdResponse = [LibraryResponse]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Library App"
        collectionView.delegate = self
        collectionView.dataSource = self
        //        getApiResponse()
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        let url = Constants.ALBUMID_URL+"\(2)"
        getApiResponseforImage(url)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumIdResponse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LibraryCollectionViewCell", for: indexPath) as! LibraryCollectionViewCell
        let thumburl = albumIdResponse[indexPath.row].url
        ImageDownloader().imageForCollection(url: thumburl) { image in
            cell.libraryImage.image = image
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailsViewController", sender: self)
    }
    
//    func getApiResponse() {
//        APIService().getData { response in
//            self.responseData = response
//            self.collectionView.reloadData()
//        }
//    }
    
    func getApiResponseforImage(_ url: String) {
        APIService.shared.getAlbumIdResponse(url) { [self] response in
            self.albumIdResponse = response
            self.collectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsViewController" {
            prepareSegueForNewsDetails(segue)
        }
    }
    
    private func prepareSegueForNewsDetails(_ segue: UIStoryboardSegue) {
        guard let newsDetailsVC = segue.destination as? DetailsViewController else {
            print("Failed to segue")
            return
        }
        guard let indexPath = collectionView.indexPathsForSelectedItems?.last else {
            print("Unable to get the selected row")
            return
        }
        let thumburl = albumIdResponse[indexPath.last!]
        newsDetailsVC.lastName = thumburl.url
        newsDetailsVC.descriptionString = thumburl.title
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 200)
    }
}

