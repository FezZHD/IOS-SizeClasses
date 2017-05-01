//
//  WebObject.swift
//  map
//
//  Created by Evgeni' Roslik on 19/04/2017.
//  Copyright © 2017 Evgeni' Roslik. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class WeatherService{

    init(){
        
    }
    
    
    var cityDictionary:[String: Int] = ["NY": 5106292, "Washington": 5549222, "Madison": 5229526, "Atlanta": 4180439];
    
    
    public func getWeatherArrayInfo(complitionHandler: (([WeatherStats])->Void)){
        let token = getToken();
        print(token);
        let semaphore = DispatchSemaphore(value: 0);
        var returnArray = [WeatherStats]();
        for(city, cityId) in cityDictionary{
            let link = "http://api.openweathermap.org/data/2.5/weather?id=\(cityId)&appid=\(token)";
            Alamofire.request(link, method: .get).responseString(completionHandler: {response in
                if (response.result.isSuccess){
                    returnArray.append(self.parseResult(jsonString: response.result.value!));
                }
                semaphore.signal();
            });
            semaphore.wait();
        }
        complitionHandler(returnArray);
    }
    
    
    
    private func getToken() -> String{
        let path = Bundle.main.path(forResource: "Info", ofType: "plist");
        let dictionary = NSDictionary(contentsOfFile: path!);
        return dictionary?.object(forKey: "ApiToken") as! String;
    }
    
    
    private func parseResult(jsonString:String) -> WeatherStats{
        let json:NSData = (jsonString as NSString).data(using:String.Encoding.utf8.rawValue)! as NSData
        let parsedJson = JSON(json);
        return WeatherStats(city: parsedJson["name"].string!,
                            status: parsedJson["weather"].arrayValue[0]["main"].string!,
                            temp: parsedJson["main"]["temp"].double!,
                            lon: parsedJson["coord"]["lon"].double!,
                            lat: parsedJson["coord"]["lat"].double!);
    }
}
