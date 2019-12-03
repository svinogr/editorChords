//
//  IpadViewController.swift
//  editorChords
//
//  Created by IUser on 03/12/2019.
//  Copyright © 2019 Up Devel. All rights reserved.
//

import UIKit

class IpadViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var png: UIImageView!
    @IBOutlet var switc: UIView!
    
    @IBAction func switchBare(_ sender: Any) {
        isBare = !isBare
    }
    
    
    var isBare: Bool = true {
        didSet {
           setImage()
        }
    }
    
    var chordMaker: ChordMaker!
    
        @IBAction func tempBareBtn(_ sender: UIBarButtonItem) {
            isBare = !isBare
        }
        var lads = [Lad]()

        override func viewDidLoad() {
            super.viewDidLoad()

            for i in 0..<13 {
                let lad = Lad(id: i)
                lads.append(lad)
            }
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.estimatedRowHeight = 400
            tableView.rowHeight = UITableView.automaticDimension
            
        }

        // MARK: - Table view data source

    
      func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }

         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return lads.count
        }

        
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCellIpad
        
            cell!.lad = lads[indexPath.row]
            cell!.lads = lads
            cell!.complision = {
                tableView.reloadData()
            }
            
            cell!.closure = {
                self.setImage()
            }
            
            return cell!
        }
     
    func setImage() {
        let lad = self.createArrayAckord(from: self.lads)
             self.chordMaker  = ChordMaker(lads: lad, isBare: self.isBare)
             let image  =  self.chordMaker.getFinalChordPic()
             self.png.image = image
    }
    
//        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//            let smal = createArrayAckord(from: lads)
//
//            let vc = segue.destination as! PngViewController
//
//            vc.lads = smal
//            vc.isBare = isBare
//
//    //        for i in smal {
//    //           // i.printStr()
//    //           // i.printStrWithNumberStr()
//    //        }
//    //
//        }

        private func createArrayAckord(from array: [Lad]) -> [Lad] {
            var startLad = 0
           
            for  i in array {
                var flag = false
                
                if i.id == 0 {continue} // не с нулевого потому что первый лад закрыте струны
                
                for j in i.strings {
                    
                    if j == StatusString.played {
                        startLad = i.id
                        flag = true
                    }
                }
               
                if flag {
                    break
                }
            }
            
          //  print(startLad)
           
            var smallAr = [Lad]()
            let grif = lads[0]
            
            smallAr.append(grif.copy())
            
            var endLad = startLad + 5
            if endLad > 12 {
                endLad = 13
                //startLad = 8
            }
            
            
            for i in startLad..<endLad {
                //      array[i].printStr()
                
                smallAr.append(array[i].copy())
            }
            
            return smallAr
            
        }
        

    }
