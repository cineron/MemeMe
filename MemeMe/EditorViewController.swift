//
//  EditorViewController.swift
//  MemeMe
//
//  Created by Cineron on 7/27/15.
//  Copyright (c) 2015 Cineron. All rights reserved.
//

import UIKit

class EditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    // MARK: - Outlets
    
    @IBOutlet weak var _imagePickerView: UIImageView!
    @IBOutlet weak var _cameraButton: UIBarButtonItem!
    @IBOutlet weak var _imagePickerButton: UIBarButtonItem!
    @IBOutlet weak var _topText: UITextField!
    @IBOutlet weak var _bottomText: UITextField!
    @IBOutlet weak var _cancel: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // text attributes
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "Impact", size: 40)!,
            NSStrokeWidthAttributeName : -4.0,
        ]
        
        //TODO: how do I set the textalignment programmatically?

        
        // set the default text properties referencing dictionary above
        _topText.defaultTextAttributes = memeTextAttributes
        _bottomText.defaultTextAttributes = memeTextAttributes
        
        // set textfield delegates. e.g. keyboard can be dismissed.
        _topText.delegate = self
        _bottomText.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UILayout
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //Disable Camera Button from "What about the camera?" section in the classroom.
        _cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        // Subscribe to keyboard notifications to allow the view to raise when necessary
        self.subscribeToKeyboardNotifications()
        
        // set textField alignment
        _topText.textAlignment = .Center
        _bottomText.textAlignment = .Center
        
    }
    
    // Add built-in func for use in Notification unsubscribe
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // unsubscribe
        self.unsubscribeFromKeyboardNotifications()
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
    
    @IBAction func cancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func share(sender: AnyObject) {
        _topText.resignFirstResponder()
        _bottomText.resignFirstResponder()
        //let newmemedImage: Meme? = memeImage()
        let newmemedImage = memeImage() as? Meme
        if let meme = newmemedImage {
            let activityVC = UIActivityViewController(activityItems: [meme.memeImage], applicationActivities: nil);
            self.presentViewController(activityVC, animated:true, completion: nil)
            
            _cancel.enabled = true
            }
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // image via delegate

    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            _imagePickerView.image = image
        }else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            _imagePickerView.image = image
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func save() {
        //Create the meme
        var meme = Meme(
            topText: _topText.text!,
            bottomText: _bottomText.text,
            originalImage: _imagePickerView.image!,
            memeImage: memeImage()
        )

        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func memeImage() -> UIImage
    {
        //hide the navigationitems before taking a "snapshot"
    //    bottomToolbar.hidden = true
     //   navigationBar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //"snapshot" taken, time to bring back the navigationitems
   //     bottomToolbar.hidden = false
   //     navigationBar.hidden = false
        
        return memedImage
    }
    
    // Get Keyboard height
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    // Move the view when the keyboard covers the bottom text field
    func keyboardWillShow(notification: NSNotification) {
        if _bottomText.isFirstResponder() {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }

    
    // subscribe: Watch for keyboard use notification
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // unsubscribe: Don't watch for Keyboard use anymore
    func unsubscribeFromKeyboardNotifications () {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    // move the keyboard back
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    // clear text when typing starts
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    // dismiss keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
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
