//
//  ViewController.swift
//  webApiAutoScroll
//
//  Created by Rajeev on 06/07/23.
//

import UIKit

class ViewController: UIViewController {

    
    var winnerList = [SportsData]()
    var timer:Timer?
    var currentIndex = 0
    
    
    @IBOutlet var mypageController:UIPageControl!
    @IBOutlet var mycollectionVeiw:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

    
       func fetchData()
    {
        let url = URL(string: "http://haritibhakti.com/commonwealth/goldwinner.json")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data ,error  == nil else
            {
                print("Error Occured ")
                return
            }
            do
            {
                self.winnerList = try JSONDecoder().decode([SportsData].self,from: data)
            }
            catch
            {
                print("hii error")
            }
            DispatchQueue.main.async {
                self.mycollectionVeiw.reloadData()
                self.mypageController.numberOfPages = self.winnerList.count
            }
        }.resume()
    }

}
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return winnerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mycollectionVeiw.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! myCollectionViewCell
        let urlImage = URL(string: winnerList[indexPath.row].imagename)
        cell.img.downloadImage(from: urlImage!)
        return cell
    }
    
    
}
extension  UIImageView
{
    func downloadImage(from url:URL)
    {
        contentMode = .scaleToFill
        let dataTask = URLSession.shared.dataTask(with:url,completionHandler: { (data,response,error) in
            guard let  httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType,mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data:data)
                    else
            {
                print("error while downloading image from link ")
                return
            }
            DispatchQueue.main.async
            {
                self.image = image
            }

        })
        dataTask.resume()

    }
}
