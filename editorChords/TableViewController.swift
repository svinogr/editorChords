//
//  TableViewController.swift
//  editorChords
//
//  Created by Up Devel on 09/10/2019.
//  Copyright © 2019 Up Devel. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var lads = [Lad]()

    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0..<25 {
            let lad = Lad(id: i)
            lads.append(lad)
        }
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
     
        var smal = createArrayAckord(from: lads)
        
        for i in smal {
           // i.printStr()
            i.printStrWithNumberStr()
        }
        
    }

    private func createArrayAckord(from array: [Lad]) -> [Lad] {
        var startLad = 0
        
       
        for  i in array {
            var flag = false
            
            if i.id == 0 {continue} // не с нулевого потому что первый лад закрыте струны
            
            for j in i.strings {
                
                if j == true {
                    startLad = i.id
                    flag = true
                }
            }
           
            if flag {
                break
            }
            
        }
        
        print(startLad)
       
       var smallAr = [Lad]()
       
        for i in startLad..<startLad + 5 {
      //      array[i].printStr()
            smallAr.append(array[i])
        }

        return smallAr
        
    }
    

}
