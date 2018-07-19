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
    let fruits = ["apple", "orange", "melon", "banana", "pineapple"]
    var selectedCellText : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        self.selectedCellText = fruits[indexPath.row]
        // ID「toDetail」というSegueを呼び出す
        performSegue(withIdentifier: "toDetail",sender: nil)
    }

    // Tableに表示するセルの数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    
    // セルの内容(オブジェクト)を返す
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "SampleCell", for: indexPath)
        
        // セルに表示する値を設定する
        cell.textLabel!.text = fruits[indexPath.row]
        
        return cell
    }
}

