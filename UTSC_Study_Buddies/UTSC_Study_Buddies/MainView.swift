//
//  MainView.swift
//  UTSC_Study_Buddies
//
//  Created by Salman Sharif on 2017-02-21.
//  Copyright © 2017 Salman Sharif. All rights reserved.
//

import UIKit

struct Group {
    let g_id : Int32
    let num_mem : Int32
    let name : String
}

class MainView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var database = FMDatabase(path: DatabasePath as String)
    var groups : [Group] = []
    var g_selected = Int32(0)

    var recieved: String = ""
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var L: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //L.text = recieved
        createFakeGroups()
        insertFakePpl()
        getGroups()
        
        
    }

    @IBAction func info_pressed(_ sender: Any) {
        performSegue(withIdentifier: "myinfo", sender: sender)
    }
    
    @IBAction func new_group(_ sender: Any) {
        performSegue(withIdentifier: "newgroup", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "myinfo" {
            let vc:MyInfo = segue.destination as! MyInfo
            vc.utorid = self.recieved
        } else if segue.identifier == "newgroup" {
            let vc:NewGroup = segue.destination as! NewGroup
            vc.utorid = self.recieved
        } else if segue.identifier == "chatview" {
            let vc:ChatView = segue.destination as! ChatView
            vc.group_id = self.g_selected
            vc.utorid = self.recieved
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = "\(groups[indexPath.row].name)"//: \(groups[indexPath.row].num_mem) members"
        cell.backgroundColor = UIColor.clear
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        g_selected = groups[indexPath.item].g_id
        performSegue(withIdentifier: "chatview", sender: indexPath)
    }
    
    
    func createFakeGroups() {
        let g1 = Group(g_id: 1, num_mem: 0, name: "CSCA08")
        let g2 = Group(g_id: 2, num_mem: 0, name: "Management 1")
        let g3 = Group(g_id: 3, num_mem: 0, name: "Media Studies")
        let g4 = Group(g_id: 4, num_mem: 0, name: "Politics 1")
        let g5 = Group(g_id: 5, num_mem: 0, name: "Psychology 1")
        
        let fakeGroups:[Group] = [g1, g2, g3, g4, g5]
        
        for g in fakeGroups {
            let q = "insert into GROUPS (group_id, name, num_mem) values (\(g.g_id as Int32), '\(g.name as String)', \(g.num_mem as Int32));"
            if openDatabase() {
                if !(database?.executeStatements(q))! {
                    print("Groups creation failed: \(database?.lastErrorMessage())")
                }
                database?.close()
            }
        }

    }
    
    func insertFakePpl() {
        if openDatabase() {
            var g = [Int32]()
            let q = "select group_id from GROUPS;"
            do {
                let res = try database?.executeQuery(q, values: nil)
                while (res?.next())! {
                    g.append((res?.int(forColumn: "group_id"))!)
                }
            } catch {
                print("Selection Failed: \(database?.lastErrorMessage())")
            }
            var s = ""
            for id in g{
                s += "insert into MEMBERS (utorid, group_id) values ('\(recieved)', \(id));"
                s += ""
            }
            if !(database?.executeStatements(s))! {
                print("insertion failed in insertFakePpl: \(database?.lastErrorMessage())")
            }
            database?.close()
        }
    }
    
    func getGroups() {
        if openDatabase() {
            groups = [Group]()
            let q = "select distinct name, num_mem, GROUPS.group_id as group_id from GROUPS inner join MEMBERS on GROUPS.group_id = MEMBERS.group_id where utorid = '\(recieved)';"
            do {
                let res = try database?.executeQuery(q, values: nil)
                while (res?.next())! {
                    let r = Group(g_id: (res?.int(forColumn: "group_id"))!, num_mem: (res?.int(forColumn: "num_mem"))!, name: (res?.string(forColumn: "name"))!)
                    
                    groups.append(r)
                }
            } catch {
                print("Select name, num_mem FAILED: \(database?.lastErrorMessage())")
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
