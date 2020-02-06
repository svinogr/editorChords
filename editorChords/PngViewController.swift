//
//  PngViewController.swift
//  editorChords
//
//  Created by IUser on 06/11/2019.
//  Copyright © 2019 Up Devel. All rights reserved.
//

import UIKit
import GoogleMobileAds

class PngViewController: UIViewController, GADBannerViewDelegate {
    var lads: [Lad]!
    var  chordMaker: ChordMaker!
    @IBOutlet weak var banner: GADBannerView!
    
    var isBare =  true {
    didSet {
               setupImage()
           }
    }
    
    @IBOutlet weak var chordLabel: UITextField!
    
    @IBOutlet weak var png: UIImageView!
    
    // в зависимотси от isGetImage apDele идет или шаринг или отправка обратно в приложение
    @IBAction func share(_ sender: UIBarButtonItem) {
        if AppDelegate.isGetImage {
            print("send back to chords")
        }else {
            let aPV = UIActivityViewController(activityItems: [png.image!], applicationActivities:  nil)
            
            aPV.popoverPresentationController?.barButtonItem = sender
            aPV.popoverPresentationController?.permittedArrowDirections = .any
            
            present(aPV, animated: true, completion: nil)
        }
    }
    
    @IBAction func barre(_ sender: Any) {
        isBare = !isBare
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chordLabel.addTarget(self, action: #selector(emptyFieldListener), for: .editingChanged)
        chordLabel.delegate = self
        setupKeyboard()
        setupImage()
        setupBanner()
    }
    
    private func setupBanner() {
        //banner = GADBannerView(adSize: kGADAdSizeBanner)
        banner!.adUnitID = "ca-app-pub-3940256099942544/2934735716" // поменять на свою
        banner!.rootViewController = self
        banner!.load(GADRequest())
        banner!.delegate = self
        banner!.translatesAutoresizingMaskIntoConstraints = false
        
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
        if let label = chordLabel.text {
            self.chordMaker  = ChordMaker(lads: lads, isBare: self.isBare, label: label)
        } else {
             self.chordMaker  = ChordMaker(lads: lads, isBare: self.isBare)
        }
         
        let image  =  self.chordMaker.getFinalChordPic()
        self.png.image = image
    }
    
}
extension PngViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


