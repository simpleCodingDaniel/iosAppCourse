//
//  ViewController.swift
//  webApp
//
//  Created by Daniel Ramirez on 6/13/16.
//  Copyright © 2016 Daniel Ramirez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var labelWeather: UILabel!
    
    var wasSuccessful = false
    
    @IBAction func buscarClima(sender: UIButton) {
        
        let urlweb2 = NSURL(string: "Http://www.weather-forecast.com/locations/"+(locationText.text?.stringByReplacingOccurrencesOfString(" ", withString: "-"))!+"/forecasts/latest")
        
        
        if let urlweb = urlweb2{
        
        //Creamos una nueva task y mandamos llamar la URL y la resivimos.
        let task = NSURLSession.sharedSession().dataTaskWithURL(urlweb) { (data, response, error) in
            
            // if the vairbale urlContent exists?
            if let urlContent = data {
                
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                
                
                //<p class="summary">, <span class="phrase">
                
                var webArray = webContent?.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                //checamos si webArray tiene valores guardados
                if webArray?.count > 1{
                    
                    let weatherArray = webArray![1].componentsSeparatedByString("</span>")
                    
                    if weatherArray.count > 1{
                        
                        self.wasSuccessful = true
                        let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "°")
                        
                        dispatch_async(dispatch_get_main_queue(),{ () -> Void in
                            
                            self.labelWeather.text = weatherSummary
                        })
                        
                        
                        
                        print(weatherSummary)
                        
                    }
                }
            }
            if self.wasSuccessful == false{
                //show error
                self.labelWeather.text = "we couldnt find that location try again"
            }
        }
        
        task.resume()
            
        } else {
            
            self.labelWeather.text = "we couldnt find that location try again"

        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}


