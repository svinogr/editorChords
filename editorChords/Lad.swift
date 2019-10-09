//
//  Lad.swift
//  editorChords
//
//  Created by Up Devel on 09/10/2019.
//  Copyright © 2019 Up Devel. All rights reserved.
//

import Foundation

class Lad {
    let id: Int
    var strings = [false,false,false,false,false,false]
    
    init(id: Int) {
        self.id = id
    }
    
    func printStr()  {
        for el in strings {
            print(el)
        }
    }
}
