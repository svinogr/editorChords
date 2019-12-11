//
//  PngViewController.swift
//  editorChords
//
//  Created by IUser on 06/11/2019.
//  Copyright © 2019 Up Devel. All rights reserved.
//

import UIKit

class PngViewController: UIViewController {
    var lads: [Lad]!
    var  chordMaker: ChordMaker!
    
    var isBare =  true {
    didSet {
               setupImage()
           }
    }
    
    @IBOutlet weak var chordLabel: UITextField!
    
    @IBOutlet weak var png: UIImageView!
    
    @IBAction func share(_ sender: UIBarButtonItem) {
        let aPV = UIActivityViewController(activityItems: [png.image!], applicationActivities: nil)
        
        aPV.popoverPresentationController?.barButtonItem = sender
        aPV.popoverPresentationController?.permittedArrowDirections = .any
        
        present(aPV, animated: true, completion: nil)
    }
    
    @IBAction func barre(_ sender: Any) {
        isBare = !isBare
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chordLabel.addTarget(self, action: #selector(emptyFieldListener), for: .editingChanged)
        
        setupKeyboard()
        
        setupImage()
        
//        let chordMaker = ChordMaker(lads: lads, isBare: isBare)
//        png.image = chordMaker.getFinalChordPic()
        // Do any additional setup after loading the view.
    }
    
    @objc func emptyFieldListener() { // tgis
            setupImage()
    }
    
    
    private func setupKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIWindow.keyboardWillShowNotification   , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIWindow.keyboardDidHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        if self.view.frame.origin.y == 0{self.view.frame.origin.y -= keyboardFrame.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
              guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
              let keyboardFrame = keyboardSize.cgRectValue
             if self.view.frame.origin.y != 0{self.view.frame.origin.y += keyboardFrame.height
              }
    }
    
    private func setupImage() {
//        let  newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        png.image = newImage
        
        if let label = chordLabel.text {
            self.chordMaker  = ChordMaker(lads: lads, isBare: self.isBare, label: label)
        } else {
             self.chordMaker  = ChordMaker(lads: lads, isBare: self.isBare)
        }
         
        let image  =  self.chordMaker.getFinalChordPic()
        self.png.image = image
    }
}


