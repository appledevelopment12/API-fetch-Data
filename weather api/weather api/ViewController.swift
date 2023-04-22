//
//  ViewController.swift
//  weather api
//
//  Created by Rajeev on 12/04/23.
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet var un: UILabel!
    @IBOutlet var myimgg: UIImageView!
    @IBOutlet var rg: UILabel!
    @IBOutlet var cn: UILabel!
    @IBOutlet var tn: UILabel!
    @IBOutlet var wn: UILabel!
    @IBOutlet var hn: UILabel!
    @IBOutlet var btnbf: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    
    }
    func fetchData()
    {
        let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=65a7aea3e395474187a20653220504&q=india&aqi=no")
        let dataTask = URLSession.shared.dataTask(with: url!,completionHandler:{ (data,response,error) in
            guard let data =  data, error == nil else
            {
                print("Error occured while accessing data with url")
                return
            }
            var fullWeatherData:WeatherData?
            do
            {
                fullWeatherData = try JSONDecoder().decode(WeatherData.self, from: data)
            }
            catch
            {
                print("error  \(error)")
            }
            DispatchQueue.main.async {
                self.un.text = "Updated : \(fullWeatherData!.current.last_updated)"
                self.rg.text = "Region : \(fullWeatherData!.location.region)"
                self.cn.text = "country: \(fullWeatherData!.location.country)"
                self.tn.text = "Temperature: \(fullWeatherData!.current.temp_c)"
                self.hn.text = "Humidity: \(fullWeatherData!.current.humidity)"
                self.wn.text = "Wind : \(fullWeatherData!.current.wind_kph)"
            }
        })
        dataTask.resume()
    }
        func btn(_ sender: UIButton)
    {
        
        
    }
    
    
    
    @IBAction func refreshData(_ sender: Any)
    {
        fetchData()
    }
   
   
    
}

