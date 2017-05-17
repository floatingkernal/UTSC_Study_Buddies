//
//  MyInfo.swift
//  UTSC_Study_Buddies
//
//  Created by Salman Sharif on 2017-02-25.
//  Copyright © 2017 Salman Sharif. All rights reserved.
//

import UIKit

struct user {
    let firstname:String
    let lastname:String
}

class MyInfo: UIViewController {
    
    var utorid:String = ""
    var database = FMDatabase(path: DatabasePath as String)

    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var lname: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //tableview.register(UINib(nibName: "CustomTableViewCell", Bundle: nil), forCellReuseIdentifier: "ccode")
        getuser()
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
    func getuser() {
        if !utorid.isEmpty && openDatabase() {
            let q = "select firstname, lastname from UTORID where utorid = '\(utorid)';"
            print(q)
            do {
                let res = try database?.executeQuery(q, values: nil)
                if (res?.next())! {
                    id.text = utorid
                    fname.text = res?.string(forColumn: "firstname")
                    lname.text = res?.string(forColumn: "lastname")
                } else {
                    print("***** res is empty *****")
                }
            } catch{
                print("Query FAILED: \(q)")
            }
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
