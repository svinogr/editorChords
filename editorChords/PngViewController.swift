//
//  PngViewController.swift
//  editorChords
//
//  Created by IUser on 06/11/2019.
//  Copyright © 2019 Up Devel. All rights reserved.
//

import UIKit

class PngViewController: UIViewController {
    private let im1 = UIImage(named: "1")!
    private let im2 = UIImage(named: "2")!
    private let size = CGSize(width: 240, height: 240)
    
    @IBOutlet weak var png: UIImageView!
    
    var lads: [Lad]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in lads {
            i.printStr()
            // i.printStrWithNumberStr()
        }
        createPNG()
        // Do any additional setup after loading the view.
    }
    
    private func createPNG() {
        UIGraphicsBeginImageContext(size)
        
        createGriff()
        createAckord()
        createLadImage()
        
        let  newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        png.image = newImage
    }
    
    private func createAckord() {
        
        for i in 1..<lads.count {
            var image: UIImage
            
            
            for j in 0..<lads[i].strings.count {
                if lads[i].strings[j] == false {
                    image = im1
                } else {
                    image = im2
                }
                
                let x = j * 24 + 24
                let y = i * 24
                
                let areaSize =  CGRect(x: x, y: y, width: 24, height: 24)
                image.draw(in: areaSize)
            }
        }
    }
    
    private func createGriff() {
        var image: UIImage
        let grif = lads[0]
        
        for j in 0..<grif.strings.count {
            if grif.strings[j] == false {
                image = im1
            } else {
                image = im2
            }
            
            let x = j * 24 + 24
            let y =  0
            
            let areaSize =  CGRect(x: x, y: y, width: 24, height: 24)
            image.draw(in: areaSize)
        }
    }
    
    private func createLadImage() {
        let numberOfStartLad = lads[1].id
        var stepForImagePosition = 1
        let textColor = UIColor.red
        let textFont = UIFont(name: "Helvetica Bold", size: 24)!
        
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
        ]
        
        for i in numberOfStartLad..<numberOfStartLad + 5 {
            UIGraphicsBeginImageContext(CGSize(width: 24, height: 24))
            
            let letter = String(i)
            
            let xLetter = 0
            let yLetter = stepForImagePosition * 24
            let areaSizeLad = CGRect(x: xLetter, y: yLetter, width: 24, height: 24)
            
            UIGraphicsEndImageContext()
            letter.draw(in: areaSizeLad, withAttributes: textFontAttributes)
            stepForImagePosition = stepForImagePosition + 1
        }
    }
}
