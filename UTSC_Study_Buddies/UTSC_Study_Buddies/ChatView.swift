//
//  ChatView.swift
//  UTSC_Study_Buddies
//
//  Created by Salman Sharif on 2017-02-21.
//  Copyright © 2017 Salman Sharif. All rights reserved.
//

import UIKit

class ChatView: UIViewController {
    
    var utorid = ""
    var group_id = Int32(0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func Info(_ sender: Any) {
        performSegue(withIdentifier: "groupinfo", sender: sender)
//        let alert = UIAlertController(title: "SORRY", message: "This Feature is not implemented yet", preferredStyle: UIAlertControllerStyle.alert)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
//                self.dismiss(animated: true, completion: nil)
//        }))
//      self.present(alert, animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "groupinfo" {
            let vc:GroupInfo = segue.destination as! GroupInfo
            vc.group_id = self.group_id
        }
    }

}
