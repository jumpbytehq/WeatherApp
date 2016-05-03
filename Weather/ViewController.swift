//
//  ViewController.swift
//  Weather
//
//  Created by Tanisha Jain on 30/04/16.
//  Copyright © 2016 Tanisha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var today: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var todayCondition: UIImageView!
  
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var upperView: UIView!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    @IBAction func refresh(sender: AnyObject) {
        
        activity.startAnimating()
        
        activity.hidden = false
        
        button.hidden = true
        
        reloadTable()
    }
    
    var tempArray = ["","","","","","",""]
    
    var dayArray = ["","","","","","",""]
    
    var conditionArray = ["","","","","","",""]
    
    
    func reloadTable(){
        
        let url = NSURL(string: "http://www.accuweather.com/en/in/surat/202441/current-weather/202441")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
            
            if error == nil{
                
                let urlContent = NSString(data: data!, encoding: NSUTF8StringEncoding) as NSString!
                
                let urlContentArray = urlContent.componentsSeparatedByString("<a href=\"#\">")
                
                for i in 1..<urlContentArray.count{
                    
                    let xyz = urlContentArray[i].componentsSeparatedByString("<strong class=\"temp\">")
                    
                    let a = urlContentArray[i].componentsSeparatedByString("</a>")
                    
                    self.dayArray[i-1] = a[0]
                    
                    let abc = xyz[1].componentsSeparatedByString("<span>")
                    
                    self.tempArray[i-1] = abc[0]
                    
                    let cond = urlContentArray[i].componentsSeparatedByString("<span class=\"cond\">")
                    
                    let c = cond[1].componentsSeparatedByString("</span>")
                    
                    if c[0].rangeOfString("cloudy") != nil && c[0].rangeOfString("shower") != nil{
                        self.conditionArray[i-1] = "rain"
                    }
                    else if c[0].rangeOfString("storm") != nil{
                        self.conditionArray[i-1] = "storm"
                    }
                    else if c[0].rangeOfString("cloudy") != nil || c[0].rangeOfString("warm with cloud") != nil{
                        self.conditionArray[i-1] = "cloud"
                    }
                    else if c[0].rangeOfString("times of cloud and sun") != nil || c[0].rangeOfString("clouds") != nil || c[0].rangeOfString("Partly sunny") != nil || c[0].rangeOfString("warm") != nil{
                        self.conditionArray[i-1] = "partlyCloudy"
                    }
                    else{
                        self.conditionArray[i-1] = "sun"
                    }
                    
                }
            }
            else{
                print(error)
            }
            dispatch_async(dispatch_get_main_queue()){
                
                self.tableView.reloadData()
                
                self.today.text = "\(self.tempArray[0])\u{00B0}"
                
                self.todayCondition.image = UIImage(named: self.conditionArray[0])
                
            }
        })
        task.resume()
        
        let url2 = NSURL(string: "http://www.accuweather.com/en/in/surat/202441/daily-weather-forecast/202441?day=6")
        
        let task2 = NSURLSession.sharedSession().dataTaskWithURL(url2!, completionHandler: { (data, response, error) -> Void in
            
            if error == nil{
                
                let urlContent = NSString(data: data!, encoding: NSUTF8StringEncoding) as NSString!
                
                let urlContentArray = urlContent.componentsSeparatedByString("<a href=\"#\">")
                
                for i in 1...2{
                    
                    let xyz = urlContentArray[i].componentsSeparatedByString("<strong class=\"temp\">")
                    
                    let a = urlContentArray[i].componentsSeparatedByString("</a>")
                    
                    self.dayArray[i+4] = a[0]
                    
                    let abc = xyz[1].componentsSeparatedByString("<span>")
                    
                    self.tempArray[i+4] = abc[0]
                    
                    let cond = urlContentArray[i].componentsSeparatedByString("<span class=\"cond\">")
                    
                    let c = cond[1].componentsSeparatedByString("</span>")
                    
                    if c[0].rangeOfString("cloudy") != nil && c[0].rangeOfString("shower") != nil{
                        self.conditionArray[i+4] = "rain"
                    }
                    else if c[0].rangeOfString("storm") != nil{
                        self.conditionArray[i+4] = "storm"
                    }
                    else if c[0].rangeOfString("cloudy") != nil || c[0].rangeOfString("warm with cloud") != nil{
                        self.conditionArray[i+4] = "cloud"
                    }
                    else if c[0].rangeOfString("times of cloud and sun") != nil || c[0].rangeOfString("clouds") != nil || c[0].rangeOfString("partly sunny") != nil{
                        self.conditionArray[i+4] = "partlyCloudy"
                    }
                    else{
                        self.conditionArray[i+4] = "sun"
                    }

                    
                }
            }
            else{
                print(error)
            }
            dispatch_async(dispatch_get_main_queue()){
                
                self.tableView.reloadData()
                
                self.activity.stopAnimating()
                
                self.activity.hidden = true
                
                self.button.hidden = false
                
            }
        })
        task2.resume()

        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        upperView.backgroundColor = UIColor(red: 0/255.0, green: 200.0/255.0, blue: 240.0/255.0, alpha: 1)
        
        reloadTable()
        
        let refresh = UIImage(named: "refresh")
        
        button.setImage(refresh, forState: .Normal)
        
        button.tintColor = UIColor.whiteColor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! weatherTableViewCell
        var day = ""
        switch dayArray[indexPath.row+1] {
        case "Mon":
            day = "Monday"
        case "Tue":
            day = "Tuesday"
        case "Wed":
            day = "Wednesday"
        case "Thu":
            day = "Thursday"
        case "Fri":
            day = "Friday"
        case "Sat":
            day = "Saturday"
        case "Sun":
            day = "Sunday"
        default:
            day = "Today"
        }
        
        cell.condition.image = UIImage(named: conditionArray[indexPath.row+1])
        cell.condition.tintColor = UIColor.whiteColor()
        
        cell.day.text = day
        cell.temp.text = "\(tempArray[indexPath.row+1])\u{00B0}"
        if indexPath.row == 5{
            cell.backgroundColor = UIColor(red: 0/255.0, green: 30/255.0, blue: 50/255.0, alpha: 1)
        }
        else if indexPath.row == 4{
            cell.backgroundColor = UIColor(red: 0/255.0, green: 40/255.0, blue: 80/255.0, alpha: 1)
        }
        else if indexPath.row == 3{
            cell.backgroundColor = UIColor(red: 0/255.0, green: 60/255.0, blue: 120/255.0, alpha: 1)
        }
        else if indexPath.row == 2{
            cell.backgroundColor = UIColor(red: 0/255.0, green: 70/255.0, blue: 140/255.0, alpha: 1)
        }
        else if indexPath.row == 1{
            cell.backgroundColor = UIColor(red: 0/255.0, green: 104/255.0, blue: 160/255.0, alpha: 1)
        }
        else if indexPath.row == 0{
            cell.backgroundColor = UIColor(red: 0/255.0, green: 120/255.0, blue: 180/255.0, alpha: 1)
        }

        return cell
    }

}

