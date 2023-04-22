//
//  ViewController.swift
//  liveCovindInformation
//
//  Created by Rajeev on 12/04/23.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var ui: UILabel!
    @IBOutlet var tfc: UILabel!
    @IBOutlet var td: UILabel!
    @IBOutlet var nc: UILabel!
    
    
    var t:String = ""
    
    var liveData = CovidCases(TotalConfirmed: 0, TotalDeaths: 0, TotalRecovered: 0, NewConfirmed: 0, NewRecovered: 0, NewDeaths: 0)
    var covidStatus = CovidCases(TotalConfirmed: 0, TotalDeaths: 0, TotalRecovered: 0, NewConfirmed: 0, NewRecovered: 0, NewDeaths: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        displayStatus()
        
    }
    func displayStatus()
    {
        URLSession.shared.dataTask(with: URL(string: "https://api.covid19api.com/summary")!,completionHandler: {
            data,response,error in
            guard let liveData = data, error == nil else
            {
                return
            }
            var currentStatus:CovidResults?
            
                do
                {
                    currentStatus = try JSONDecoder().decode(CovidResults.self, from: liveData)
                }
            
            catch
            {
                print("\(error)")
            }
            guard let finalStatus = currentStatus
                    else
            {
                return
            }
            let covid = finalStatus.Global
            
            DispatchQueue.main.async {
             self.tfc.text = String(covid.TotalConfirmed)
             self.td.text = String(covid.TotalDeaths)
             self.nc.text = String(covid.NewDeaths)
            }
        }).resume()
        
    }


}
/*
struct CovidCases:Codable
{
    let  TotalConfirmed:Int
    let  TotalDeaths:Int
    let  TotalRecovered:Int
    let  NewConfirmed:Int
    let  NewRecovered:Int
    let  NewDeaths:Int
}*/
private enum CodingKeys:String,CodingKey
{
case TotalConfirmed,TotalDeaths,TotalRecovered,NewConfirmed,NewRecovered,NewDeaths
}
struct CovidResults:Codable
{
    let Global:CovidCases
}
