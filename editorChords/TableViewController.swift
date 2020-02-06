//
//  TableViewController.swift
//  editorChords
//
//  Created by Up Devel on 09/10/2019.
//  Copyright © 2019 Up Devel. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var isBare: Bool = false

    var lads = [Lad]()

    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0..<13 {
            let lad = Lad(id: i)
            lads.append(lad)
        }
        tableView.estimatedRowHeight = 400
        tableView.rowHeight = UITableView.automaticDimension
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return lads.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell
    
        cell!.lad = lads[indexPath.row]
        cell!.lads = lads
        cell!.complision = {
            tableView.reloadData()
        }
        return cell!
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        let smal = createArrayAckord(from: lads)
        
        let vc = segue.destination as! PngViewController
        
        vc.lads = smal
    }

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
       
        var smallAr = [Lad]()
        let grif = lads[0]
        
        smallAr.append(grif.copy())
        
        var endLad = startLad + 5
                   if endLad > 12 {
                       endLad = 13
                       startLad = 8
                   }
        
        for i in startLad..<endLad {
            smallAr.append(array[i].copy())
        }
        
        return smallAr
    }
}
