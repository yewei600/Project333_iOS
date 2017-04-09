//
//  WeatherClient.swift
//  Project333
//
//  Created by Eric Wei on 2017-03-30.
//  Copyright © 2017 EricWei. All rights reserved.
//

import Foundation

class WeatherClient {
    
    var methodParameters: [String:AnyObject] = [
        WeatherParameterKeys.cityName: WeatherParameterValues.cityName as AnyObject,
        WeatherParameterKeys.APPID: WeatherParameterValues.APPID as AnyObject
    ]
    
    //MARK: Get
    func getWeatherResponse(completionHandler: @escaping (_ temperature: Double, _ locationName: String, _ error: NSError?) -> Void) {
        print("inside  getWeatherResponse()")
        var parsedResult: Any! = nil
        
        let request = URLRequest(url: weatherURLFromParameters(methodParameters))
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            func sendError(_ error: String) {
                //let userInfo = [NSLocalizedDescriptionKey : error]
                //completionHandlerForPOST(false, NSError(domain: "getBannerItems", code: 1, userInfo: userInfo))
                print(error)
                return
            }
            guard (error == nil) else {
                sendError("There was an error with your request: \(error)")
                return
            }
            
            guard let data = data else{
                sendError("No data was returned by the request!")
                return
            }
            
            var parsedJSON = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
            
            let main = parsedJSON["main"] as! [String:Double]
            let temperature = main["temp"] as! Double
            let locationName = parsedJSON["name"] as! String
            
            completionHandler(temperature,locationName,nil)
        }
        task.resume()
        
    }
    
    func weatherURLFromParameters(_ parameters: [String: Any]) -> URL {
        var components = URLComponents()
        components.scheme = Weather.APIScheme
        components.host = Weather.APIHost
        components.path = Weather.APIPath
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        return components.url!
    }
    
    class func sharedInstance() -> WeatherClient {
        struct Singleton {
            static var sharedInstance = WeatherClient()
        }
        return Singleton.sharedInstance
    }
}
