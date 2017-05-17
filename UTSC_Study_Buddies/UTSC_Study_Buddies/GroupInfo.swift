//
//  GroupInfo.swift
//  UTSC_Study_Buddies
//
//  Created by Salman Sharif on 2017-02-21.
//  Copyright © 2017 Salman Sharif. All rights reserved.
//

import UIKit

class GroupInfo: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var group_id = Int32(0)
    var database = FMDatabase(path: DatabasePath as String)
    var name = ""
    var num_mem = 0
    var members = [String]()


    @IBOutlet weak var Group_name: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfo()
        Group_name.text = name

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func Update(_ sender: Any) {
        let alert = UIAlertController(title: "SORRY", message: "This Feature is not implemented yet", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default
            , handler: { action in
                self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "members")
        cell.textLabel?.text = members[indexPath.item]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return num_mem
    }
    func getInfo() {
        if openDatabase(){
            let q1 = "select name from GROUPS where group_id = \(group_id);"
            let q2 = "select firstname, lastname from UTORID inner join (select distinct utorid from MEMBERS where group_id = \(group_id)) as M on UTORID.utorid = M.utorid"
            do {
                let res = try database?.executeQuery(q1, values: nil)
            
                if (res?.next())! {
                    name = (res?.string(forColumn: "name"))!
                }
            } catch {
                print("Q1 error")
                
            }
            do {
                let r = try database?.executeQuery(q2, values: nil)
                while (r?.next())! {
                    let fname = (r?.string(forColumn: "firstname"))! as String
                    let lname = (r?.string(forColumn: "lastname"))! as String
                    members.append("\(fname) \(lname)")
                }
                num_mem = members.count
            } catch {
                print("Q2 error: \(database?.lastErrorMessage())")
            }
            database?.close()
        }
    }
    
    func openDatabase() -> Bool {
        if database == nil {
            if FileManager.default.fileExists(atPath: DatabasePath as String) {
                database = FMDatabase(path: DatabasePath as String)
            }
        }
        
        if database != nil {
            if (database?.open())! {
                return true
            }
        }
        
        return false
    }

}
