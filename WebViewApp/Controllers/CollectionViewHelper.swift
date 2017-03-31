//
//  CollectionViewHelper.swift
//  WebViewApp
//
//  Created by Jaya   on 30/03/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation

// MARK: Load Data from URL if data found in coredata, fetch coredata context else save to coreData

extension CollectionViewController {
    
    func dataHandler(completion: @escaping(_ items : [YouTubeEntity]) -> Void) {
        
        LoadDataFromURl.instance.getData(urlString: baseURLString) {
            (data: Data) -> Void in
            
            let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
            
            let itemsArray = json["items"] as! NSArray
            
            for itemsObj in itemsArray {
                
                _ = CoreDataManager.instance.persistentContainer.viewContext
                
                let youTubeCast = YouTubeEntity(context: CoreDataManager.instance.persistentContainer.viewContext)
                
                let object = itemsObj as AnyObject
                
                youTubeCast.videoURL = object["id"] as? String
                
                let snippetObj = object["snippet"] as AnyObject
                
                let resourceId = snippetObj["resourceId"] as AnyObject
                
                youTubeCast.playlistId = resourceId["videoId"] as? String
                
                youTubeCast.title = snippetObj["title"] as? String
                
                let thumbnails = snippetObj["thumbnails"] as AnyObject
                
                let medium = thumbnails["medium"] as AnyObject
                
                youTubeCast.imageURL = medium["url"] as? String
                
                self.resultArray.append(youTubeCast)
            }
            completion(self.resultArray)
            CoreDataManager.instance.saveContext()
            
        }
        
    }
}
