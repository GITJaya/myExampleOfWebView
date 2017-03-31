//
//  ViewController.swift
//  WebViewApp
//
//  Created by Jaya   on 29/03/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    
    var resultArray : [YouTubeEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createActivityIndicator()
        
        dataHandler() {
        (resultArray: [YouTubeEntity]) -> Void in
            
            self.collectionView.reloadData()
            
            self.activityIndicator.stopAnimating()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

// MARK: CollectionView Implementation

extension CollectionViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Items count",resultArray.count)
        return resultArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        let youTubeCastObj = resultArray[indexPath.row]
       
        cell.imgView.image = self.loadImageURL(index: indexPath.row,youTubeCastObj : youTubeCastObj )
        cell.titleLabel.text = youTubeCastObj.title
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showWebView" {
            let indexPaths = self.collectionView.indexPathsForSelectedItems
            let indexPath = (indexPaths?[0])! as IndexPath
            let viewController = segue.destination as! WebViewController
            viewController.requestPlayListId = (resultArray[indexPath.row]).playlistId
        }
      }
   }

extension CollectionViewController {
    
    func loadImageURL(index : Int, youTubeCastObj : YouTubeEntity) ->  UIImage{
        
        let filePath = DocumentsDirectory.getDocumentDirectoryURL().appendingPathComponent("Image"+String(index)+".png")
        var img : UIImage = UIImage()
        do {
            let url = Foundation.URL(string: youTubeCastObj.imageURL!)
            let testImage =  try Data(contentsOf: url!)
            print(filePath)
             img = UIImage(data: testImage)!
            try testImage.write(to: filePath, options: .atomic)
           
        } catch{
            print(error as NSError)
        }
        return img
    }
}
// MARK: Activity Indicator

extension CollectionViewController {
    
    func createActivityIndicator() {
        
        activityIndicator.center = self.collectionView.center
        activityIndicator.isHidden = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
    }
    
}

