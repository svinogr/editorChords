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
    
    private var quantitiPlayedStrings = 0
    private let offsetBareLine = 225
    private let widthBareLine = 10
    
    @IBOutlet weak var png: UIImageView!
    @IBAction func share(_ sender: UIBarButtonItem) {
        let aPV = UIActivityViewController(activityItems: [png.image!], applicationActivities: nil)
        
        aPV.popoverPresentationController?.barButtonItem = sender
        aPV.popoverPresentationController?.permittedArrowDirections = .any
        
        present(aPV, animated: true, completion: nil)
    }
    
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
        
      // createGriff()
        createBarreLine()
     //   createAckord()
     //   createLadImage()
        
        let  newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        png.image = newImage
        
        print("quantitiPlayedStrings", quantitiPlayedStrings )
    }
    
    private class ShemeString {
    var start = "6"
    var end = "o"
   
        func toString() -> String {
            return "\(start)_\(end)"
        }
    }
    
    private func createBarreLine() {
        var maxStringInFirstlad = -1
        let strings  = lads[1].strings
        
        for stringNumber in 0...5 {
            if strings[stringNumber] == StatusString.played {
                maxStringInFirstlad = stringNumber
                break
            }
        }
        
        for id in 1..<lads!.count {
                 for str in lads[id].strings {
                     if str == StatusString.played {
                      quantitiPlayedStrings = quantitiPlayedStrings + 1
                     }
                 }
                 
             }
        
       // if quantitiPlayedStrings > 4 {
            drowBarre(from: maxStringInFirstlad)
       // }
        
        print("maxStringInFirstlad" , maxStringInFirstlad )
               print("quantitiPlayedStrings", quantitiPlayedStrings)
    }
    
    private func drowBarre(from: Int) {
        let step = from * 188 + 188
        print("step", step)
        let context = UIGraphicsGetCurrentContext()!
        print(context)
        
        let endPoint = size.width - 188
        
        context.setLineWidth(5.0)
    //    context.setStrokeColor(UIColor.black.cgColor)
 //       context.move(to: CGPoint(x: step, y: 225))
  //      context.addLine(to: CGPoint(x: endPoint, y: 225))
  //      context.strokePath()
        
        context.setStrokeColor(UIColor.red.cgColor)
        //context.setAlpha(0.5)
        //context.setLineWidth(10.0)
    //    context.addArc(center: CGPoint(x: 500, y: 500), radius: 400, startAngle: 0, endAngle: 90, clockwise: true)
        
        let ab = 1314.0/2
        let c = 50.0
        let d = Double (ab * ab) / c
        let r = (d + c )/2
        let point = CGPoint(x:500, y:0 - r)
        let angl = acos(Double ((ab/2)/r))

        print("a = \(ab)  b = \(ab)  c = \(c)  r = \(r) po = \(point) abgle = \(angl)")
       
       //context.addArc(tangent1End: CGPoint(x: 5, y: 5), tangent2End: CGPoint(x: 10, y: 10), radius: 8000)
       // context.addArc(center: point, radius: CGFloat (r), startAngle: CGFloat (((180 * 3.14)/180) + angl), endAngle: CGFloat (((360 * 3.14)/180) - angl), clockwise: true)
        
        context.addArc(center: point, radius: CGFloat (r), startAngle: CGFloat (3.1416 + angl), endAngle: CGFloat (6.2832 - angl), clockwise: true)
       // context.addEllipse(in: CGRect(x: 188, y: 100, width:  657 * 2, height: 657 * 2))
     //   context.drawPath(using: .stroke) // or .fillStroke if need filling

        
        
    }
    
    private func createAckord() {
         reinitializedFirstLadWithClosedStrings()
       
         for i in 1..<lads.count {
            
            let shmeme =  getShemesStrings(from: lads[i])
        
             var image: UIImage
                let step = 200
            
            for j in 0..<shmeme.count {
                let namePic = shmeme[j].toString()
                    image = UIImage(named: namePic)!
                    
                    let x = j * 200
                    let y =  (i - 1) * 242 + 104
                print(x, y)
                    let areaSize =  CGRect(x: x, y: y, width: 200, height: 242)
                    image.draw(in: areaSize)
                }
        }
     }
    
    private func getShemesStrings(from lad: Lad) -> [ShemeString] {
        var arrayShemeStrings = [ShemeString]()
        
        for i in 0..<6 {
            
            let iPast = i - 1
            
            let strladIm = ShemeString()
            
            if iPast > -1 {
                strladIm.start = closedChemeString(for: arrayShemeStrings[iPast].end)
            }
                switch lad.strings[i] {
                case StatusString.open:
                    strladIm.end = "o"
                case StatusString.closed:
                    strladIm.end = ")"
                case StatusString.played:
                    strladIm.end = "("
            }

            arrayShemeStrings.append( strladIm)
            print(i, strladIm.start, strladIm.end)
            
            if i == 5 {
                let end = ShemeString()
                end.start = "1"
                end.end = closedChemeString(for: arrayShemeStrings[5].end)
                arrayShemeStrings.append(end)
                print(end.start, end.end)
            }
        }
        return arrayShemeStrings
    }
    
    private func closedChemeString(for input : String) -> String {
        switch input {
        case "(":
            return  ")"
        case ")":
             return  "("
        case "o":
             return  "o"
        default:
            return "error"
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
            print(namePic)
            image = UIImage(named: namePic)!
            
            let x = i * step
            
            let areaSize =  CGRect(x: x, y: 0, width: 200, height: 104)
            image.draw(in: areaSize)
        }
    }
    
    private func createLadImage() {
        let numberOfStartLad = lads[1].id
        var stepForImagePosition = 0
        let textColor = UIColor.black
        let textFont = UIFont(name: "Menlo", size: 220)!
        
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
        ]
        
        for i in numberOfStartLad..<numberOfStartLad + 5 {
            UIGraphicsBeginImageContext(size)
            
            let letter = String(i)
            
            let xLetter = 0
            let yLetter = stepForImagePosition * 242 + 104
            let areaSizeLad = CGRect(x: xLetter, y: yLetter, width: 200, height: 242)
            
            UIGraphicsEndImageContext()
            letter.draw(in: areaSizeLad, withAttributes: textFontAttributes)
            stepForImagePosition = stepForImagePosition + 1
        }
    }
}

extension PngViewController {
    
    func testGet(s: String) -> String {
        return closedChemeString(for: s)
    }
}
