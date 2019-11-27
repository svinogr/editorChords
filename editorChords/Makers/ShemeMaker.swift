//
//  ShemeMaker.swift
//  editorChords
//
//  Created by IUser on 26/11/2019.
//  Copyright © 2019 Up Devel. All rights reserved.
//

import Foundation

class ShemmeMaker {
    
    let isBare: Bool
    
    init(with bare: Bool) {
        self.isBare = bare
    }
    
    class ShemeString {
        var start = "6"
        var end = "o"
        
        func toString() -> String {
            return "\(start)_\(end)"
        }
    }
    
     func getShemesStrings(from lad: Lad) -> [ShemeString] {
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
            //print(i, strladIm.start, strladIm.end)
            
            if i == 5 {
                let end = ShemeString()
                end.start = "1"
                end.end = closedChemeString(for: arrayShemeStrings[5].end)
                arrayShemeStrings.append(end)
              //  print(end.start, end.end)
            }
        }
        return arrayShemeStrings
    }
    
     func getShemesStringsForTwoVariant(from lad: Lad) -> [ShemeString] {
        var arrayShemeStrings = [ShemeString]()
        
        for i in 0..<6 {
            
            let iPast = i - 1
            
            let strladIm = ShemeString()
            
            if iPast > -1 {
                if isBare  && lad.id < 2 {
                    strladIm.start = "o"
                }
                strladIm.start = closedChemeString(for: arrayShemeStrings[iPast].end)
            }
            
            switch lad.strings[i] {
            case StatusString.open:
                strladIm.end = "o"
            case StatusString.closed:
                strladIm.end = ")"
            case StatusString.played:
                if isBare && lad.id < 2 {
                    strladIm.end = "o"
                } else{
                    
                    strladIm.end = "("
                }
            }
            
            arrayShemeStrings.append( strladIm)
         //   print(i, strladIm.start, strladIm.end)
            
            if i == 5 {
                let end = ShemeString()
                end.start = "1"
                end.end = closedChemeString(for: arrayShemeStrings[5].end)
                arrayShemeStrings.append(end)
             //   print(end.start, end.end)
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
}
