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
        
        //TODO: Figure out if URLRequest or URL are needed.
        //Probably based on if URL header is needed
        
//        let urlRequest = URLRequest(url: url)
        
        let urlTask = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completionHandler(.Failure(with: error.localizedDescription))
                return

            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.Failure(with: "Invalid response from server"))
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
    

    //https://joshuaproject.net/api/v2/upgotd?api_key=yourkey
    
    //TODO: Find out if headers are needed
//    func unreachedPeopleGroupURLRequest() -> URLRequest? {
//        guard let url = unreachedPeopleGroupURL() else {
//
//            return nil
//        }
//
//        var mutableUrlRequest = NSMutableURLRequest(url: url)
//    }

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
                                       value: JoshuaProjectAPIConstants.URLQueryKey.ROL3Profile))
        queryItems.append(URLQueryItem(name: JoshuaProjectAPIConstants.URLQueryKey.LRofTheDayMonth,
                                       value: String(monthOfTodayAsInt())))
        queryItems.append(URLQueryItem(name: JoshuaProjectAPIConstants.URLQueryKey.LRofTheDayDay,
                                       value: String(dayOfTodayAsInt())))
        
        return queryItems
    }
}


