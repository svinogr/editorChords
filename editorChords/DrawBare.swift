//
//  Draw.swift
//  editorChords
//
//  Created by IUser on 26/11/2019.
//  Copyright © 2019 Up Devel. All rights reserved.
//

import Foundation
import UIKit

class DrawBare {
    private let lads: [Lad]
    private let context: CGContext
    var quantitiPlayedStrings = 0
    private let size = CGSize(width: 1400, height: 1314)
    
    init(lads: [Lad], context: CGContext) {
        self.lads = lads
        self.context = context
    }
    
     func createBarreLine() {
            var maxStringInFirstlad = -1
            let strings  = lads[1].strings
            
            for stringNumber in 0...5 {
                if strings[stringNumber] == StatusString.played {
                    maxStringInFirstlad = stringNumber
                    break
                }
            }
            
            for id in 1..<lads.count {
                     for str in lads[id].strings {
                         if str == StatusString.played {
                          quantitiPlayedStrings = quantitiPlayedStrings + 1
                         }
                     }
                     
                 }
            
        //    if quantitiPlayedStrings > 4 {
                drowBarre(from: maxStringInFirstlad)
         //   }
            
            print("maxStringInFirstlad" , maxStringInFirstlad )
                   print("quantitiPlayedStrings", quantitiPlayedStrings)
        }
        
        private func drowBarre(from: Int) {
            let step = from * 200 + 200
            print("step", step)
            let context = UIGraphicsGetCurrentContext()!
            print(context)
            let endPoint = size.width - 200
            
            context.setLineWidth(45.0)
            context.setStrokeColor(UIColor.black.cgColor)
            context.move(to: CGPoint(x: step, y: 225))
            context.addLine(to: CGPoint(x: endPoint, y: 225))
            context.strokePath()
            
            context.setStrokeColor(UIColor.black.cgColor)
            //context.setAlpha(0.5)
            context.setLineWidth(10.0)
        //    context.addArc(center: CGPoint(x: 500, y: 500), radius: 400, startAngle: 0, endAngle: 90, clockwise: true)
            
    //        let ab = 2000.0/2
    //        let c = 200.0
    //        let d = Double (ab * ab) / c
    //        let r = (d + c )/2
    //        let point = CGPoint(x:700, y: r + 170 )
    //        let angl = acos(Double ((ab/2)/r))
            let ab = (2000.0  - Double (from * 400)) / 2
            let c = 200.0
            let d = Double (ab  * ab) / c
            let r = (d + c )/2
            let point = CGPoint(x:700 + Double (from * 100), y: r + 160 )
            let angl = acos(Double ((ab/2)/r))

            print("a = \(ab)  b = \(ab)  c = \(c)  r = \(r) po = \(point) abgle = \(angl)")
           
           //context.addArc(tangent1End: CGPoint(x: 5, y: 5), tangent2End: CGPoint(x: 10, y: 10), radius: 8000)
           // context.addArc(center: point, radius: CGFloat (r), startAngle: CGFloat (((180 * 3.14)/180) + angl), endAngle: CGFloat (((360 * 3.14)/180) - angl), clockwise: true)
            
            context.addArc(center: point, radius: CGFloat (r), startAngle: CGFloat (3.1416 + angl), endAngle: CGFloat (6.2832 - angl), clockwise: false)
           // context.addEllipse(in: CGRect(x: 188, y: 100, width:  657 * 2, height: 657 * 2))
            context.drawPath(using: .stroke) // or .fillStroke if need filling
        }
}
