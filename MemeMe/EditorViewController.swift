//
//  EditorViewController.swift
//  MemeMe
//
//  Created by Ron Wilson on 7/27/15.
//  Copyright (c) 2015 Cineron. All rights reserved.
//

import UIKit

class EditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - Outlets
    
    @IBOutlet weak var _imagePickerView: UIImageView!
    @IBOutlet weak var _cameraButton: UIBarButtonItem!
    @IBOutlet weak var _imagePickerButton: UIBarButtonItem!
    @IBOutlet weak var _topText: UITextField!
    @IBOutlet weak var _bottomText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UILayout
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //Disable Camera Button in toolbar in case there is no Camera supported by the current used device
        _cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    
        // text attributes
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "Impact", size: 40)!,
            NSStrokeWidthAttributeName : -4.0,
        ]
        
        // set the default text properties
        _topText.defaultTextAttributes = memeTextAttributes
        _bottomText.defaultTextAttributes = memeTextAttributes
        
        
    
    }
    
    // MARK: - Actions
    
    @IBAction func pickAnImage(sender: AnyObject) {
        let pickController = UIImagePickerController()
        pickController.delegate = self
        pickController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pickController, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }    
    
//    func pop(sender: UIBarButtonItem) {
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
    
    // image via delegate

    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            _imagePickerView.image = image
        }else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            _imagePickerView.image = image
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
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
