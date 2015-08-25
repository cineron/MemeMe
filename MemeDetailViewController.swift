//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Cineron on 8/25/15.
//  Copyright (c) 2015 Cineron. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    
    @IBOutlet private weak var _memeImageView: UIImageView!
    
    var meme: Meme?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let image:UIImage = meme?.memeImage {
            _memeImageView.image = image
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}