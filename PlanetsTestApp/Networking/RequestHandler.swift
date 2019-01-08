//
//  RequestHandler.swift
//  PlanetsTestApp
//
//  Created by Sudhakar Tharigoppula on 07/01/19.
//  Copyright © 2019 Sudhakar Tharigoppula. All rights reserved.
//

import UIKit

class RequestHandler: NSObject {
    
    static let sharedInstance = RequestHandler()
    let reachability = Reachability()
    private override init() {
      do {
        try reachability?.startNotifier()
      } catch {
        print("could not start reachability notifier")
      }
    }
  
    func isReachable()->Bool {
      if reachability?.connection == .wifi || reachability?.connection == .cellular {
        return true
      }
      return false
    }
  
    //GET
    public func requestDataFromUrl(urlName:String, httpMethodType:String, body:[String:Any], completionHandler:@escaping (([String:Any]?, Error?)->())){
        
        if let requestURL = URL(string: urlName ) {
            var urlRequest =  URLRequest(url: requestURL)
            urlRequest.httpMethod = httpMethodType
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            //setting up the request body
            if body.count > 0 {
                let jsonData = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                urlRequest.httpBody = jsonData
            }
            
            // set up the session
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            // make the request
            let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                
                guard let data = data else {
                    completionHandler(nil, error)
                    return
                }
                let httpResponse: HTTPURLResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                
                switch statusCode {
                case 200:
                    if let dictionary = try? JSONSerialization.jsonObject(with: data, options:.allowFragments) as? [String:Any], dictionary != nil {
                        completionHandler(dictionary, error)
                    } else {
                        print("JSONSerialization failed")
                    }
                    
                    break
                case 500:
                    print("Status Code - \(httpResponse.statusCode) \(String(describing: error))")
                    let err = NSError(domain:"Server Error", code:httpResponse.statusCode, userInfo:nil)
                    completionHandler(nil, err)
                    break
                    
                default:
                    print("Status Code - \(httpResponse.statusCode) \(String(describing: error))")
                    let err = NSError(domain:"Server Error", code:httpResponse.statusCode, userInfo:nil)
                    completionHandler(nil, err)
                    break
                }
            })
            
            task.resume()
        }
    }

}
