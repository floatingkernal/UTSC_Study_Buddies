//
//  NewGroup.swift
//  UTSC_Study_Buddies
//
//  Created by Salman Sharif on 2017-02-21.
//  Copyright © 2017 Salman Sharif. All rights reserved.
//

import UIKit

class NewGroup: UIViewController {
    
    var utorid = ""

    @IBOutlet weak var selectpplselector: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createGroup(_ sender: Any) {
        let alert = UIAlertController(title: "SORRY", message: "This Feature is not implemented yet", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default
            , handler: { action in
                self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func randomppl(_ sender: Any) {
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
