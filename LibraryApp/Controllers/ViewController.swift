//
//  ViewController.swift
//  LibraryApp
//
//  Created by Anoop on 03/10/23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tabbarCollectionView: UICollectionView!
    
    var responseData = [DataResponse]()
    var albumIdResponse = [LibraryResponse]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Library App"
        collectionView.delegate = self
        collectionView.dataSource = self
        tabbarCollectionView.delegate = self
        tabbarCollectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        getApiResponse()
        let url = Constants.ALBUMID_URL+"\(2)"
        getApiResponseforImage(url)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return albumIdResponse.count
        } else if collectionView == self.tabbarCollectionView {
            return responseData.count
        }
      return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LibraryCollectionViewCell", for: indexPath) as! LibraryCollectionViewCell
            let thumburl = albumIdResponse[indexPath.row].url
            ImageDownloader().imageForCollection(url: thumburl) { image in
                cell.libraryImage.image = image
            }
            return cell
        } else {
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "TabbarCollectionViewCell", for: indexPath) as! TabbarCollectionViewCell
            let data = responseData[indexPath.row].title
            cellB.nameLbl.text = data.components(separatedBy: " ").first
            return cellB
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView{
            performSegue(withIdentifier: "DetailsViewController", sender: self)
        } else if collectionView == self.tabbarCollectionView {
            let id = responseData[indexPath.row].id
            let title = responseData[indexPath.row].title
            print("Anoop_title:\(title)")
            let url = Constants.ALBUMID_URL+"\(id)"
            getApiResponseforImage(url)
        }
    }
    
    func getApiResponse() {
        let url = URL(string: Constants.ALBUM_URL)
        APIService.shared.getApiData(requestUrl: url!, resultType: [DataResponse].self) { result in
            self.responseData = result
            self.tabbarCollectionView.reloadData()
        }
    }
    
    func getApiResponseforImage(_ url: String) {
        let url = URL(string: url)
        APIService.shared.getApiData(requestUrl: url!, resultType: [LibraryResponse].self) { result in
            self.albumIdResponse = result
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

