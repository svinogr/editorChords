//
//  Draw.swift
//  editorChords
//
//  Created by IUser on 26/11/2019.
//  Copyright © 2019 Up Devel. All rights reserved.
//

import Foundation
import UIKit

class BareMaker {
    private let lads: [Lad]
    private let context: CGContext
    
    private let size = CGSize(width: 1400, height: 1314)
    
    init(lads: [Lad], context: CGContext) {
        self.lads = lads
        self.context = context
    }
    
    func createBarreLine() {
        var maxStringInFirstlad = 5
        
        for i in 1..<lads.count {
            let max = maxStringForBare(lad: lads[i])
            
            if maxStringInFirstlad > max {
                maxStringInFirstlad = max
            }
        }
        print("maxStringInFirstlad", maxStringInFirstlad)
        print("LadCount", lads.count)
        //    if quantitiPlayedStrings > 4 {
        drowBare(from: maxStringInFirstlad)
        //   }
        
        
    }
    
    private func maxStringForBare(lad: Lad) -> Int {
        var max = 0
        var flagOfOpenStrings = 0
        let strings = lad.strings
        
        for stringNumber in 0...5 {
            flagOfOpenStrings += 1
            if strings[stringNumber] == StatusString.played {
                max = stringNumber
                break
            }
            
        }
        
        if flagOfOpenStrings == 6 && max == 0 {
            max = 6
        }
        print("max", max)
        print("flagOfOpenStrings", flagOfOpenStrings)
        return max
    }
    
    private func drowBare(from: Int) {
        let step = from * 200 + 200
        print("step", step)
        // let context = UIGraphicsGetCurrentContext()!
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
        
        let ab = (2000.0  - Double (from * 400)) / 2
        let c = 200.0
        let d = Double (ab  * ab) / c
        let r = (d + c )/2
        let point = CGPoint(x:700 + Double (from * 100), y: r + 160 )
        let angl = acos(Double ((ab/2)/r))
        
        print("a = \(ab)  b = \(ab)  c = \(c)  r = \(r) po = \(point) abgle = \(angl)")
        
        context.addArc(center: point, radius: CGFloat (r), startAngle: CGFloat (3.1416 + angl), endAngle: CGFloat (6.2832 - angl), clockwise: false)
        context.drawPath(using: .stroke) // or .fillStroke if need filling
    }
}
