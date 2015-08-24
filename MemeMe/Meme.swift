//
//  Meme.swift
//  MemeMe
//
//  Created by Cineron on 8/24/15.
//  Copyright (c) 2015 Cineron. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    
    var topText : String
    var bottomText : String
    var originalImage : UIImage
    var memeImage : UIImage
    
    init (topText : String, bottomText : String, originalImage : UIImage, memeImage : UIImage){
        self.bottomText = bottomText
        self.topText = topText
        self.originalImage = originalImage
        self.memeImage = memeImage
    }
    
}


//struct MMMeme {
//    /// The image used to create the meme, without the text
//    var original :UIImage
//    /// The "memed" image
//    var meme :UIImage
//    /// Text displayed on top of the meme
//    var top :NSString
//    /// Text displayed on bottom of the meme
//    var bottom :NSString
//}