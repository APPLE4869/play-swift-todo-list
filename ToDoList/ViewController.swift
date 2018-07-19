//
//  ViewController.swift
//  ToDoList
//
//  Created by shokei-takanashi on 2018/07/18.
//  Copyright © 2018年 shokei-takanashi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var TableView: UITableView!
    
    // ５種類のフルーツ
    var selectedCellText : String?
    var items : Array<String> = []
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // 画面表示直前に呼ばれる処理
    override func viewWillAppear(_ animated: Bool) {
        reloadItems()
        TableView.reloadData()
    }
    
    // UserDefaultsからitemsを取得してインスタンス変数に格納する処理
    func reloadItems() {
        if userDefaults.object(forKey: "items") != nil {
            self.items = userDefaults.object(forKey: "items") as! Array<String>
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Segueで遷移時の処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueのIDがtoDetailの時だけこの処理を実行
        if (segue.identifier == "toDetail") {
            // 遷移先のコントローラーのインスタンスを生成
            let detailVC: DetailViewController = segue.destination as! DetailViewController

            // 遷移先コントローラーのインスタンス変数に値を格納
            // これを遷移先コントローラーから参照する
            detailVC.selectedText = selectedCellText
        }
    }

    // セルが選択された時の処理
    func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        self.selectedCellText = items[indexPath.row]
        // ID「toDetail」というSegueを呼び出す
        performSegue(withIdentifier: "toDetail",sender: nil)
    }

    // Tableに表示するセルの数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    // Tableからセルを削除する処理
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        userDefaults.set(items, forKey:"items")
        tableView.reloadData()
    }

    // セルの内容(オブジェクト)を返す
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "SampleCell", for: indexPath)
        
        // セルに表示する値を設定する
        cell.textLabel!.text = items[indexPath.row]
        
        return cell
    }
}

