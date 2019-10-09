//
//  TableViewCell.swift
//  editorChords
//
//  Created by Up Devel on 09/10/2019.
//  Copyright © 2019 Up Devel. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    var lad: Lad! {
        didSet {
            numberLad.text = String(lad.id)
            buttons = [oneString, twoString, threeString, fourString, fiveString, sixString]
            for str in 0..<lad.strings.count {
                changePicForString(number: str)
            }
        }
    }
    var complision : (() -> ())!
    
    var lads: [Lad]!
    
    var buttons: [UIButton]?
    
    @IBOutlet weak var sixString: UIButton!
    
    @IBAction func SixStringAction(_ sender: Any) {
        let id = 5
        self.lad.strings[id] = !self.lad.strings[id]
        
        
        if(lad.strings[id]) {
            diselectOtherstringsInLads(number: id)
        }
        changePicForString(number: id)
    }
    
    @IBAction func FiveStringAction(_ sender: Any) {
        let id = 4
        self.lad.strings[id] = !self.lad.strings[id]
        if(lad.strings[id]) {
            diselectOtherstringsInLads(number: id)
        }
        changePicForString(number: id)
        
    }
    
    @IBAction func FourStringAction(_ sender: Any) {
        let id = 3
        self.lad.strings[id] = !self.lad.strings[id]
        if(lad.strings[id]) {
            diselectOtherstringsInLads(number: id)
        }
        changePicForString(number: id)
        
    }
    
    @IBAction func ThreStringAction(_ sender: Any) {
        let id = 2
        self.lad.strings[2] = !self.lad.strings[id]
        if(lad.strings[id]) {
            diselectOtherstringsInLads(number: id)
        }
        changePicForString(number: id)
        
    }
    
    @IBAction func TwoStringAction(_ sender: Any) {
        let id = 1
        self.lad.strings[id] = !self.lad.strings[id]
        if(lad.strings[id]) {
            diselectOtherstringsInLads(number: id)
        }
        changePicForString(number: id)
    }
    
    @IBAction func OneStringAction(_ sender: Any) {
        let id = 0
        self.lad.strings[0] = !self.lad.strings[0]
        if(lad.strings[id]) {
            diselectOtherstringsInLads(number: id)
        }
        changePicForString(number: id)
    }
    
    @IBOutlet weak var numberLad: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBOutlet weak var fiveString: UIButton!
    @IBOutlet weak var fourString: UIButton!
    @IBOutlet weak var threeString: UIButton!
    @IBOutlet weak var twoString: UIButton!
    @IBOutlet weak var oneString: UIButton!
    
    func changePicForString(number: Int) {
        
        
        
        var button: UIButton?
        
        switch number {
        case 0:
            button = self.oneString
        case 1:
            button = self.twoString
        case 2:
            button = self.threeString
        case 3:
            button = self.fourString
        case 4:
            button = self.fiveString
        case 5:
            button = self.sixString
        default:
            print("notNet")
        }
        
        if (self.lad.strings[number]){
            button!.backgroundColor = .black
            
        }else {button!.backgroundColor = .green}
        
    }
    
    
    func diselectOtherstringsInLads(number: Int)  {
        
        for i in lads {
            if i.id != lad.id {
                i.strings[number] = false
                complision()
            }
        }
    }
    
}
