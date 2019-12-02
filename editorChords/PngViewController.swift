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
    var isBare: Bool!
    
    @IBOutlet weak var png: UIImageView!
    @IBAction func share(_ sender: UIBarButtonItem) {
        let aPV = UIActivityViewController(activityItems: [png.image!], applicationActivities: nil)
        
        aPV.popoverPresentationController?.barButtonItem = sender
        aPV.popoverPresentationController?.permittedArrowDirections = .any
        
        present(aPV, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for l in lads {
            print(l.printStr())
        }
        print("-----------------------")
        
        let chordMaker = ChordMaker(lads: lads, isBare: isBare)
        png.image = chordMaker.getFinalChordPic()
        // Do any additional setup after loading the view.
    }
    
    private func setupImage() {
        let  newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        png.image = newImage
    }
}


