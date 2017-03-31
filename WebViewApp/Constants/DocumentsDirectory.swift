//
//  DocumentsDirectory.swift
//  Trial1
//
//  Created by Jaya   on 22/03/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit

enum SwitchItems{
    case YouTubeImage,YouTubeVideo
}

class DocumentsDirectory {
    
    class func getDocumentDirectoryPath() -> URL {
        
        var documentsDirectoryURL : URL? = nil
        do {
            documentsDirectoryURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            createDirectory(directoryType: SwitchItems.YouTubeImage)
            
        } catch { }
        
        return documentsDirectoryURL!
    }
    
    class func getDocumentDirectoryURL()->URL{
        var documentDirectoryURL : URL? = nil
        do {
            
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let documentDirectory = paths[0] as NSString
            
            let audioPlayerPath = documentDirectory.appendingPathComponent("YouTubeImage")
            
            
            if !FileManager.default.fileExists(atPath: audioPlayerPath){
                try FileManager.default.createDirectory(atPath: audioPlayerPath, withIntermediateDirectories: true, attributes: nil)
            }
            
            documentDirectoryURL = URL(fileURLWithPath: audioPlayerPath)
            
        } catch {
            print("Unable to fetch documentDirectoryURL")
        }
        return documentDirectoryURL!
    }

    
    class func createDirectory(directoryType: SwitchItems)->NSString{
        
        let fileManager = FileManager.default
        var paths: String
        
        switch directoryType{
        case .YouTubeImage:
            paths = getDirectoryPath().appendingPathComponent("YouTubeImage")
        case .YouTubeVideo:
            paths = getDirectoryPath().appendingPathComponent("YouTubeVideo")
        }
        if !fileManager.fileExists(atPath: paths){
            try! fileManager.createDirectory(atPath: paths, withIntermediateDirectories: true, attributes: nil)
        }else{
            print("Already dictionary created.")
        }
        return paths as NSString
    }
    
        class func getDirectoryPath() -> NSString {
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let documentsDirectory = paths[0] as NSString
            return documentsDirectory
        }
    
    class func saveInDocumentDirectory(data: Data, fileName: String, directoryType: SwitchItems){
        
        let itemName = fileName
        let path = createDirectory(directoryType: directoryType).appendingPathComponent(itemName)
        //print(path)
        let itemData = data
        do{
            try itemData.write(to: URL(fileURLWithPath:path))
        }catch{
            print("This is an error")
        }
    }
    
    class func ifFileExist(fileName: String,item: SwitchItems)->Bool{
        let fileManager = FileManager.default
        let imageName = fileName
        let imagePath = createDirectory(directoryType: item).appendingPathComponent(imageName)
        if fileManager.fileExists(atPath: imagePath){
            return true
        }else{
            return false
        }
    }
    
    class func getPodCast(fileName:String) -> String{
        let imageName = fileName
        let path = createDirectory(directoryType: SwitchItems.YouTubeVideo).appendingPathComponent(imageName)
        return path
    }
    
    class func getImage(fileName:String) -> UIImage{
        let imageName = fileName
        var image = UIImage(named: "")
        let imagePath = createDirectory(directoryType: SwitchItems.YouTubeImage).appendingPathComponent(imageName)
        image = UIImage(contentsOfFile: imagePath)
        return image!
    }
    
    
}
