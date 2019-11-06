//
//  PngViewController.swift
//  editorChords
//
//  Created by IUser on 06/11/2019.
//  Copyright © 2019 Up Devel. All rights reserved.
//

import UIKit

class PngViewController: UIViewController {

    @IBOutlet weak var png: UIImageView!
    
    var lad: [Lad]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      for i in lad {
                    i.printStr()
                   // i.printStrWithNumberStr()
                }
createPNG()
        // Do any additional setup after loading the view.
    }
    
    private func createPNG() {
        let im1 = UIImage(named: "1")
        let im2 = UIImage(named: "2")
        
        var size = CGSize(width: 240, height: 240)
        UIGraphicsBeginImageContext(size)
        
        var areaSize = CGRect(x: 0, y: 0, width: 24, height: 24)
        im1!.draw(in: areaSize)
        
         areaSize = CGRect(x: 24, y: 0, width: 24, height: 24)
        im1!.draw(in: areaSize)
        

        im2!.draw(in: areaSize, blendMode: .normal, alpha: 0.8)

        var newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        png.image = newImage
        
    }
    

}
