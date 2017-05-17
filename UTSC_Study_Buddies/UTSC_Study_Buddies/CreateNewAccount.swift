//
//  CreateNewAccount.swift
//  UTSC_Study_Buddies
//
//  Created by Salman Sharif on 2017-02-21.
//  Copyright © 2017 Salman Sharif. All rights reserved.
//

import UIKit

class CreateNewAccount: UIViewController {

    @IBOutlet weak var utorid: UITextField!
    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var lname: UITextField!
    
    var database = FMDatabase(path: DatabasePath as String)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        database = FMDatabase(path: DatabasePath as String)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signup(_ sender: Any) {
        var created = false
        let id = utorid.text! as String
        let f_name = fname.text! as String
        let l_name = lname.text! as String
        if !((id.isEmpty) || (f_name.isEmpty) || (l_name.isEmpty)) {
            if openDatabase() {
                let statement = "insert into UTORID (utorid, firstname, lastname) values ('\(id)', '\(f_name)', '\(l_name)');"
                print(statement)
                if !((database?.executeStatements(statement))!) {
                    print("Table : \(database?.lastErrorMessage())")
                } else {
                    created = true
                }
                database?.close()
                
            } else {
                print("Table: \(database?.lastErrorMessage())")
            }
            if created {
                let alert = UIAlertController(title: "Success", message: "Account Created!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "DONE", style: UIAlertActionStyle.default
                    , handler: { action in
                        self.navigationController?.popViewController(animated: true)
                    }))
                self.present(alert, animated: true, completion: nil)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
