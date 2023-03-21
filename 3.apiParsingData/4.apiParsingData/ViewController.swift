//
//  ViewController.swift
//  4.apiParsingData
//
//  Created by Rajeev on 17/03/23.
//

import UIKit

class ViewController: UIViewController {

    
    var data = [ToDo]()
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchingApiData(URL: "https://api.opendota.com/api/heroStats") {
            result in self.data = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        
    }

    func fetchingApiData(URL url:String,completion: @escaping([ToDo]) -> Void)
    {
        let url = URL(string: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!)
        {
            data,response,error in
            if data != nil && error == nil{
                do{
                    let parsingData = try JSONDecoder().decode([ToDo].self, from: data!)
                    completion(parsingData)
                }
                catch
                {
                    print("Parsing error")
                }
            }
        }
        dataTask.resume()
    }
}
extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! CustomTableViewCell
        let apiData:ToDo
        apiData = data[indexPath.row]
        let string = "https://api.opendota.com"+(apiData.img)
        let url = URL(string: string)
        cell.apiImage.downloaded(from: url!,contentMode: .scaleToFill)
        cell.apiLabel.text = apiData.localized_name
    
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    
}

extension UIImageView
{
    func downloaded(from url: URL,contentMode mode: ContentMode = .scaleToFill)
    {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data,response,error in guard
            let httpURLResponse = response as? HTTPURLResponse,httpURLResponse.statusCode == 200,
            let mimeType = response?.mimeType,mimeType.hasPrefix("image"),
            let data = data,error == nil,
            let image = UIImage(data: data)
            else
            {
                return
            }
            DispatchQueue.main.async(){ [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String,contentMode mode: ContentMode = .scaleAspectFit)
    {
        guard let url = URL(string: link) else {return }
        downloaded(from: url,contentMode: mode)
    }
    
}
