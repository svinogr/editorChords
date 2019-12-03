//
//  TableViewCellIpad.swift
//  editorChords
//
//  Created by IUser on 03/12/2019.
//  Copyright © 2019 Up Devel. All rights reserved.
//

import Foundation

class TableViewCellIpad: TableViewCell {
    var closure: (()->())!
    
    override func cloAndCompl() {
        closure()
        complision()
    }
}
