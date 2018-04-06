//
//  JoshuaProjectClient.swift
//  LearnToPray
//
//  Created by Mark Tapia on 12/15/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//

import Foundation

public enum Result<T> {
    case Success(with: T)
    case Failure(with: String)
}

class JoshuaProjectClient {
    
    static var shared = JoshuaProjectClient()
    
    private init() { }
    
    let session = URLSession.shared
    
    //Joshua Project documentation: https://joshuaproject.net/api/v2/documentation
    func jpGETRequest(_ completionHandler: @escaping (_ dataRequest: Result<Data>) -> Void) {
        
        guard let url = unreachedPeopleGroupURL() else {
            completionHandler(.Failure(with: "Invalid URL"))
            return
            
        }
                
        let urlTask = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completionHandler(.Failure(with: error.localizedDescription))
                return

            }
            
            guard let response = response as? HTTPURLResponse else {
                completionHandler(.Failure(with: "No response from server"))
                return
                
            }
            
            if response.statusCode != 200 {
                completionHandler(.Failure(with: "Invalid response from server: \(response.statusCode)"))
                return
                
            }
            
            guard let data = data else {
                completionHandler(.Failure(with: "No data returned with request"))
                return
                
            }
            
            completionHandler(.Success(with: data))
            
        }
        
        urlTask.resume()
        
    }

    func unreachedPeopleGroupURL() -> URL? {
        var components = URLComponents()
        components.scheme = JoshuaProjectAPIConstants.URLComponents.Scheme
        components.host = JoshuaProjectAPIConstants.URLComponents.Host
        components.path = JoshuaProjectAPIConstants.URLComponents.Path
        
        components.queryItems = getQueryItems()
        
        return components.url
        
    }
    
}

extension JoshuaProjectClient {
    
    fileprivate func getQueryItems() -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        
        queryItems.append(URLQueryItem(name: JoshuaProjectAPIConstants.URLQueryKey.APIKey,
                                       value: JoshuaProjectAPIConstants.URLQueryValue.APIKey))
        queryItems.append(URLQueryItem(name: JoshuaProjectAPIConstants.URLQueryKey.ROL3Profile,
                                       value: JoshuaProjectAPIConstants.URLQueryValue.ROL3Profile))
        queryItems.append(URLQueryItem(name: JoshuaProjectAPIConstants.URLQueryKey.LRofTheDayMonth,
                                       value: String(monthOfTodayAsInt())))
        queryItems.append(URLQueryItem(name: JoshuaProjectAPIConstants.URLQueryKey.LRofTheDayDay,
                                       value: String(dayOfTodayAsInt())))
        
        return queryItems
        
    }
    
}


