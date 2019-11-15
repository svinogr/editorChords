//
//  Lad.swift
//  editorChords
//
//  Created by Up Devel on 09/10/2019.
//  Copyright © 2019 Up Devel. All rights reserved.
//

import Foundation

enum StatusString {
   case played
   case closed
   case open
}

class Lad {
    let id: Int
   // var strings = [false,false,false,false,false,false]
    var strings = [StatusString.open, StatusString.open, StatusString.open, StatusString.open, StatusString.open, StatusString.open]
    
    init(id: Int) {
        self.id = id
    }
    
    func printStr()  {
        for el in  (0..<strings.count) {
            print(strings[el], separator: "-", terminator: "")
        }
        print(" ")
    }
    
    func printStrWithNumberStr() {
        for (pos,  el)  in  strings.enumerated() {
            print(el ,"( \(pos) )", separator: "-", terminator: "")
             }
             print(" ")
    }
    
}
