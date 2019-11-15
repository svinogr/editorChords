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
    private let size = CGSize(width: 1400, height: 1314)
    
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
       // createAckord()
       // createLadImage()
        
        let  newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        png.image = newImage
    }
    
    private func createAckordOLD() {
        
        for i in 1..<lads.count {
            var image: UIImage
            
            
            for j in 0..<lads[i].strings.count {
                if lads[i].strings[j] == StatusString.open {
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
    
    private func createAckord() {
         reinitializedFirstLadWithClosedStrings()
        
         for i in 1..<lads.count {
             var image: UIImage
             let curentLad = lads[i]
            
            if i == 1 {
                
                for j in 0..<lads[i].strings.count {
                    if j == 0  {
                        // только для первой струны
                        
                        switch curentLad.strings[j] {
                        case StatusString.closed:
                            image = UIImage(named: "6_x")!
                        case StatusString.open:
                            image = UIImage(named: "6_empty")!
                        case StatusString.played:
                            image = UIImage(named: "6_o")!
                        }
                        
                        if curentLad.strings[j] == StatusString.closed {
                            
                        }
                        
                    } else {
                    
                    //  остальные струны
                    }
                }
                
                
                
            } else {
            
             
             for j in 0..<lads[i].strings.count {
                
                if j == 0  {
                    // только для первой струны
                  //  if curentLad.strings[j] == StatusString.closed {
                        
                    }
                    
                    continue
                }
                
                if lads[i].strings[j] == StatusString.open {
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
     }
    
    private func reinitializedFirstLadWithClosedStrings() {
        let zeroLad = lads[0]
        let oneLad = lads[1]
        
        for i in 0..<zeroLad.strings.count {
            
            if zeroLad.strings[i] == StatusString.played {
               oneLad.strings[i] = StatusString.closed
            }
        }
    }
    
    
    private func createGriffOLD() {
      var image: UIImage
        let step = 200
            let grif = lads[0]
    
            for j in 0..<grif.strings.count {
                if grif.strings[j] == StatusString.open {
                    image = im1
                } else {
                    image = im2
                }
    
                let x = j * step + step
                let y =  0
    
                let areaSize =  CGRect(x: x, y: y, width: 24, height: 24)
                image.draw(in: areaSize)
            }
    }
    
    private func createGriff() {
        var image: UIImage
        let step = 200
        
        for i in 1..<8 {
            let namePic = "0_0\(i)"
            print(namePic)
            image = UIImage(named: namePic)!
            
            let x = i * step
            
            let areaSize =  CGRect(x: x, y: 0, width: 200, height: 104)
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
