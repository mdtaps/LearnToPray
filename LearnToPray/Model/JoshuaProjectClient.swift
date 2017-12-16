//
//  JoshuaProjectClient.swift
//  LearnToPray
//
//  Created by Mark Tapia on 12/15/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//

import Foundation

class JoshuaProjectClient {
    
    static var shared = JoshuaProjectClient()
    
    private init() { }
    
    let session = URLSession.shared
    
    func jpGETRequest(_ completionHandler: @escaping (_ dataRequest: Result<Data>) -> Void) {
        
        
    }
    
    //Joshua Project documentation: https://joshuaproject.net/api/v2/documentation
    //https://joshuaproject.net/api/v2/upgotd?api_key=yourkey
    
//    func unreachedPeopleGroupURLRequest() -> URLRequest {
//
//    }
//
//    func unreachedPeopleGroupURL() -> URL {
//
//    }
    
    
}

public enum Result<T> {
    case Success(with: T)
    case Failure
}
