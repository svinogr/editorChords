//
//  IpadViewController.swift
//  editorChords
//
//  Created by IUser on 03/12/2019.
//  Copyright © 2019 Up Devel. All rights reserved.
//

import UIKit
import GoogleMobileAds

class IpadViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GADBannerViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var png: UIImageView!
    @IBOutlet var switc: UIView!
    @IBOutlet weak var banner: GADBannerView!
    @IBOutlet weak var chordLabel: UITextField!
    
    @IBAction func share(_ sender: UIBarButtonItem) {
        let aPV = UIActivityViewController(activityItems: [png.image!], applicationActivities: nil)
               
               aPV.popoverPresentationController?.barButtonItem = sender
               aPV.popoverPresentationController?.permittedArrowDirections = .any
               
               present(aPV, animated: true, completion: nil)
    }
        
    @IBAction func switchBare(_ sender: Any) {
        isBare = !isBare
    }
    
    var isBare: Bool = true {
        didSet {
            setImage()
        }
    }
    
    var chordMaker: ChordMaker!
 
    var lads = [Lad]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chordLabel.addTarget(self, action: #selector(emptyFieldListener), for: .editingChanged)
        chordLabel.delegate = self
        setupKeyboard()
        
       // view.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        tableView.backgroundView = UIImageView(image: UIImage())
        
        for i in 0..<13 {
            let lad = Lad(id: i)
            lads.append(lad)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 400
        setupDefaultImag()
        setupBanner()
    }
    
    @objc func emptyFieldListener() { // tgis
            setImage()
    }
    
    private func setupBanner() {
        //banner = GADBannerView(adSize: kGADAdSizeBanner)
        banner!.adUnitID = "ca-app-pub-3940256099942544/2934735716" // поменять на свою
        banner!.rootViewController = self
        banner!.load(GADRequest())
        banner!.delegate = self
        banner!.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setupDefaultImag() {
        var defaultLad = [Lad]()
        
        for i in 0...4 {
            let lad = Lad(id: i)
            defaultLad.append(lad)
        }
        defaultLad = createArrayAckord(from: defaultLad)
        chordMaker = ChordMaker(lads: defaultLad, isBare: self.isBare)
        png.image = chordMaker.getFinalChordPic()
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return lads.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCellIpad
        
        cell!.lad = lads[indexPath.row]
        cell!.lads = lads
        cell!.complision = {
            tableView.reloadData()
        }
        
        cell!.closure = {
            self.setImage()
        }
        
        return cell!
    }
    
    func setImage() {
        let lad = self.createArrayAckord(from: self.lads)
        if let label = chordLabel.text {
                   self.chordMaker  = ChordMaker(lads: lad, isBare: self.isBare, label: label)
               } else {
                    self.chordMaker  = ChordMaker(lads: lad, isBare: self.isBare)
               }
        
        
      //  self.chordMaker  = ChordMaker(lads: lad, isBare: self.isBare)
        let image  =  self.chordMaker.getFinalChordPic()
        self.png.image = image
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
    
    private func createArrayAckord(from array: [Lad]) -> [Lad] {
        var startLad = 0
        
        for  i in array {
            var flag = false
            
            if i.id == 0 {continue} // не с нулевого потому что первый лад закрыте струны
            
            for j in i.strings {
                
                if j == StatusString.played {
                    startLad = i.id
                    flag = true
                }
            }
            
            if flag {
                break
            }
        }
        
        var smallAr = [Lad]()
        let grif = lads[0]
        
        smallAr.append(grif.copy())
        
        var endLad = startLad + 5
        if endLad > 12 {
            endLad = 13
            //startLad = 8
        }
        
        for i in startLad..<endLad {
            smallAr.append(array[i].copy())
        }
        
        return smallAr
    }
}

extension IpadViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
