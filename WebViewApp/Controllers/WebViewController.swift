//
//  WebViewController.swift
//  WebViewApp
//
//  Created by Jaya   on 30/03/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    
    @IBOutlet weak var webView: UIWebView!
    
    var requestPlayListId : String?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let videoURL = videoURLString + requestPlayListId!
        print(videoURL)
        let url = NSURL(string: videoURL)!
        let urlRequest = NSURLRequest(url: url as URL)
        webView.loadRequest(urlRequest as URLRequest)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
