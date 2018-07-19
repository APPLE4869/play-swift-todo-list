//
//  AddViewController.swift
//  ToDoList
//
//  Created by shokei-takanashi on 2018/07/19.
//  Copyright © 2018年 shokei-takanashi. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard

    @IBOutlet weak var addTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AddItem(_ sender: UIButton) {
        var items : Array<String> = []
        if userDefaults.object(forKey: "items") != nil {
            items = userDefaults.object(forKey: "items") as! Array<String>
        }

        let addTextFieldValue : String = addTextField.text!

        items.append(addTextFieldValue)

        userDefaults.set(items, forKey: "items")
        userDefaults.synchronize()
        
        // Home画面に戻る
        self.navigationController?.popToRootViewController(animated: true)
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
