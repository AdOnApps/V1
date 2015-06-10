//
//  ViewController.swift
//  AdOnApps
//
//  Created by Elodie on 08/06/2015.
//  Copyright (c) 2015 Elodie. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(queue, {[weak self] in
            var image: UIImage?
            dispatch_sync(queue, {
                /* Download the image here */
                /* Put your own URL here */
                let urlAsString = "http://les-simpson-streaming.fr/wp-content/uploads/2015/03/Celebrity-Image-Simpsons-Homer-Simpson-72594.jpg"
                let url = NSURL(string: urlAsString)
                let urlRequest = NSURLRequest(URL: url!)
                var downloadError: NSError?
                let imageData = NSURLConnection.sendSynchronousRequest(urlRequest,
                    returningResponse: nil, error: &downloadError)
                if let error = downloadError
                {
                    println("Error happened = \(error)")
                }
                else
                {
                    if imageData!.length > 0
                    {
                        image = UIImage(data: imageData!)
                        /* Now we have the image */
                    }
                    else
                    {
                        println("No data could get downloaded from the URL")
                    }
                }
            })
            dispatch_sync(dispatch_get_main_queue(), {
                /* Show the image to the user here on the main queue */
                if let theImage = image {
                    let imageView = UIImageView(frame: self!.view.bounds)
                    imageView.contentMode = .ScaleAspectFit
                    imageView.image = theImage
                    self!.view.addSubview(imageView)
                }
            })
            
            })
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

