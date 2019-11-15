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
          //  buttons = [oneString, twoString, threeString, fourString, fiveString, sixString]
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
      actionPressStringButton(id: id)
    }
    
    @IBAction func FiveStringAction(_ sender: Any) {
        let id = 4
actionPressStringButton(id: id)
    }
    
    @IBAction func FourStringAction(_ sender: Any) {
        let id = 3
      actionPressStringButton(id: id)
    }
    
    @IBAction func ThreStringAction(_ sender: Any) {
        let id = 2
   actionPressStringButton(id: id)
    }
    
    @IBAction func TwoStringAction(_ sender: Any) {
        let id = 1
      actionPressStringButton(id: id)
    }
    
    @IBAction func OneStringAction(_ sender: Any) {
        let id = 0
        actionPressStringButton(id: id)
    }
    
    private func actionPressStringButton(id: Int) {
        if self.lad.strings[5 - id] == StatusString.open {
            self.lad.strings[5 - id] = StatusString.played
        } else {
             self.lad.strings[5 - id] = StatusString.open
        }
        
       // self.lad.strings[5 - id] =  !self.lad.strings[5 - id]
       
        if(lad.strings[5 - id] == StatusString.played) {
            diselectOtherstringsInLads(number: 5 - id)
        }
        changePicForString(number: 5 - id)
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
        case 5:
            button = self.oneString
        case 4:
            button = self.twoString
        case 3:
            button = self.threeString
        case 2:
            button = self.fourString
        case 1:
            button = self.fiveString
        case 0:
            button = self.sixString
        default:
            print("notNet")
        }
        
        let name = "\(self.lad.id)_\(number)"
        print(name)
        
        if (self.lad.strings[number]) == StatusString.played{
          //  button!.backgroundImage(for: .normal) = UIImage(named: "1")
            
            
            button!.setBackgroundImage(UIImage(named: "\(name)p"), for: .normal)
             
        }else
        {
       button!.setBackgroundImage(UIImage(named: name), for: .normal)
            
        }
        
    }
    
    
    func diselectOtherstringsInLads(number: Int)  {
        
        for i in lads {
            if i.id != lad.id {
                i.strings[number] = StatusString.open
                complision()
            }
        }
    }
    
}
