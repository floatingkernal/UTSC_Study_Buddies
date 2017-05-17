//
//  ViewController.swift
//  UTSC_Study_Buddies
//
//  Created by Salman Sharif on 2017-02-18.
//  Copyright © 2017 Salman Sharif. All rights reserved.
//

import UIKit

var DatabasePath = NSString()

class ViewController: UIViewController {
    
    var database = FMDatabase(path: DatabasePath as String)

    @IBOutlet weak var signin: UIButton!
    @IBOutlet weak var utorid: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //DatabasePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Database").path as NSString
        DatabasePath = ((NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String).appending("/Database.sqlite") as NSString
        database = FMDatabase(path: DatabasePath as String)
        
        self.DBCreation()
        
    }
    @IBAction func SignIn(_ sender: Any) {
        if login() {
            performSegue(withIdentifier: "signin", sender: sender)
        } else {
            let alert = UIAlertController(title: "FAILED", message: "UTORID or Password is incorrect!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "DONE", style: UIAlertActionStyle.default
                , handler: { action in
                    self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func login() -> Bool {
        let id = utorid.text! as String
        if id.isEmpty {
            return false
        }
        var b = false
        if openDatabase() {
            let q = "select utorid from UTORID where utorid = '\(id)';"
            do {
                let res = try database?.executeQuery(q, values: nil)
                if (res?.next())! {
                    let r = res?.string(forColumn: "utorid")
                    if r == id {
                        b = true
                    }
                }
            } catch {
                print("Query Failed")
            }
            
            database?.close()
        }
        return b
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signin" {
            let mainVC: MainView = segue.destination as! MainView
            mainVC.recieved = utorid.text!
        }
    }
    
    func DBCreation() {
        
        if openDatabase() {
            let q1 = "create table if not exists UTORID (utorid TEXT PRIMARY KEY, firstname TEXT, lastname TEXT);"
            let q2 = "create table if not exists TAKES (utorid TEXT, COURSE TEXT);"
            let q3 = "create table if not exists GROUPS (group_id INTEGER PRIMARY KEY, name TEXT, num_mem INTEGER);"
            let q4 = "create table if not exists MEMBERS(group_id INTEGER, utorid TEXT);"
            let b1 = (database?.executeStatements(q1))!
            let b2 = (database?.executeStatements(q2))!
            let b3 = (database?.executeStatements(q3))!
            let b4 = (database?.executeStatements(q4))!

            if !(b1 && b2 && b3 && b4) {
                print("Table was not created")
            }
            database?.close()
        } else {
            print("Database was not created")
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

