import UIKit

class ApiIndexTableViewController: UITableViewController {
    
    let apiUrl = "https://nuxt-api.herokuapp.com/messages"
    var fetchedData : Array<ApiFormatsBody>? = nil
    
    // APIで取得するデータの型を定義
    struct ApiFormats:Codable {
        let body: Array<ApiFormatsBody>
    }

    // APIで取得するデータの要素の型を定義
    struct ApiFormatsBody:Codable {
        let id: Int
        let title: String
        let text: String
        let created_at: String
        let updated_at: String
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // APIを利用してデータを取得後、取得したデータを描画
        drawDataByApi()
    }
    
    // APIを利用してデータを取得後、取得したデータを描画する処理
    func drawDataByApi() {
        // APIのURLを元にNSURLオブジェクトを生成
        let url = NSURL(string: self.apiUrl)!
        
        // APIにアクセスして、取得したデータを処理
        let task = URLSession.shared.dataTask(with: url as URL, completionHandler: {data, response, error in
            // リソースの取得が終わると、ここに書いた処理が実行される
            if let data = data, let _ = response {
                do {
                    // 取得したJSONをパース
                    let fetchedObject = try JSONDecoder().decode(ApiFormats.self, from: data)
                    
                    // パースしたデータのBody内の要素をインスタンス変数に格納
                    self.fetchedData = fetchedObject.body
                } catch {
                    print("Serialize Error")
                }
            } else {
                print(error ?? "Error")
            }

            // reloadDataがメインスレッドじゃないと実行できないので、mainスレッドで実行されるようにしている
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (fetchedData == nil) {
            return 0
        }
        return fetchedData!.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "apiDataCell", for: indexPath)

        if (self.fetchedData != nil) {
            cell.textLabel!.text = self.fetchedData![indexPath.row].title
        }

        return cell
    }
}
