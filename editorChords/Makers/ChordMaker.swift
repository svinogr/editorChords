//
//  ChordMaker.swift
//  editorChords
//
//  Created by IUser on 26/11/2019.
//  Copyright © 2019 Up Devel. All rights reserved.
//

import Foundation
import UIKit

class ChordMaker {
    private let sizeFinalPic = CGSize(width: 1400, height: 1314)
    private var lads: [Lad]
    private var bareMaker: BareMaker!
    private var shemeMaker: ShemmeMaker!
    private var context: CGContext!
    private var quantitiPlayedStrings = 0
    private var isBare =  false
    private let offset = 50
    
    init(lads: [Lad], isBare: Bool = true ) {
        self.lads = lads
      
        if isBare {
        analizeBare()
        }
        
        UIGraphicsBeginImageContext(sizeFinalPic)
        self.context = UIGraphicsGetCurrentContext()!
        self.lads = lads
        self.bareMaker = BareMaker(lads: lads, context: context)
        self.shemeMaker = ShemmeMaker(with: isBare)
    }
    
    private func analizeQuantityPlayedStrings() {
        for id in 1..<lads.count {
    
            for str in lads[id].strings {
                if str == StatusString.played {
                 quantitiPlayedStrings = quantitiPlayedStrings + 1
                }
            }
        }
    }
    
    
    private func playedLads() -> Int {
        var playedLad = 0
        
        for id in 1..<lads.count {
            
            for str in lads[id].strings {
                if str == StatusString.played {
                    playedLad += 1
                    break
                }
            }
        }
        print("playedLads", playedLad)
        return playedLad
    }
    
    private func analizeBare() {
        analizeQuantityPlayedStrings()

        switch quantitiPlayedStrings {
        case 5... :
            isBare = true
        case 4:
            if playedLads() > 2 {
                isBare = true
            }
        default:
            print("error in anilize lads")
        }
        
    }
    
    
    private func createAckord() {
        reinitializedFirstLadWithClosedStrings()
        
        for i in 1..<lads.count {
            var shmeme: [ShemmeMaker.ShemeString]
            
            if isBare {
                 shmeme = shemeMaker.getShemesStringsForTwoVariant(from: lads[i]) // несколько вариантов
            } else {
                 shmeme = shemeMaker.getShemesStrings(from: lads[i]) // несколько вариантов
            }
            
            var image: UIImage
            let stepX = 200
            
            let widthPicChord = 200
            let heightPicChord = 242
            let offsetFromPorogY = 104
            
            for j in 0..<shmeme.count {
                let namePic = shmeme[j].toString()
                image = UIImage(named: namePic)!
                
                let x = j * stepX + offset
                let y =  (i - 1) * heightPicChord + offsetFromPorogY
                
                let areaSize =  CGRect(x: x, y: y, width: widthPicChord, height: heightPicChord)
                image.draw(in: areaSize)
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
       
       private func createGriff() {
           var image: UIImage
           let step = 200
           
           for i in 0..<7 {
               let namePic = "0_0\(i + 1)"

               image = UIImage(named: namePic)!
               
               let x = i * step + offset
               
               let areaSize =  CGRect(x: x, y: 0, width: 200, height: 104)
               image.draw(in: areaSize)
           }
       }
    
    private func createBareLine() {
        if isBare {
            bareMaker.createBarreLine()
        }
    }
       
       private func createLadImage() {
           let numberOfStartLad = lads[1].id
           var stepForImagePosition = 0
           let textColor = UIColor.black
           let textFont = UIFont(name: "Menlo", size: 100)!
           
           let textFontAttributes = [
               NSAttributedString.Key.font: textFont,
               NSAttributedString.Key.foregroundColor: textColor,
           ]
           
           for i in numberOfStartLad..<numberOfStartLad + 5 {
               UIGraphicsBeginImageContext(sizeFinalPic)
               
               let letter = String(i)
               
               let xLetter = 0
               let yLetter = stepForImagePosition * 242 + 104
               let areaSizeLad = CGRect(x: xLetter, y: yLetter, width: 200, height: 242)
               
               UIGraphicsEndImageContext()
               letter.draw(in: areaSizeLad, withAttributes: textFontAttributes)
               stepForImagePosition = stepForImagePosition + 1
           }
       }
    
    func getFinalChordPic() -> UIImage {
        createGriff()
         createAckord()
        createBareLine()
       
        createLadImage()
        
        let  image: UIImage =  UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
