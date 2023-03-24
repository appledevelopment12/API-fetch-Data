//
//  ViewController.swift
//  1.API fetch data
//
//  Created by Rajeev on 22/03/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var myTableView: UITableView!
    
    var countryData = [CountryList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    func fetchData()
    {
        let url = URL(string: "http://haritibhakti.com/countrylist.json")
        let dataTask = URLSession.shared.dataTask(with: url!,completionHandler: {(data,responce,error) in
            guard let data = data, error == nil else
            {
                print("Error occured while Accessing data with URL")
                
                return
            }
            var clist = [CountryList]()
            do
            {
                clist = try JSONDecoder().decode([CountryList].self,from: data)
            }
            catch{
                print("Error occured while decoding json into swift structure \(error)")
            }
            self.countryData = clist
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        })
        dataTask.resume()
    }


}
extension ViewController:UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text =  "\(indexPath.row+1). \(self.countryData[indexPath.row].countryname)"
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryData.count
    }
}


