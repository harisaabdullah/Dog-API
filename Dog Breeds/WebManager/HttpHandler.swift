//
//  HttpHandler.swift
//  Dog Breeds
//
//  Created by Haris Abdullah on 5/14/22.
//

import Foundation
import Alamofire

struct requestParameters {
    let url:String
    let method: HTTPMethod
    let parameters:[String: Any]?
}


final class HttpHandler: NSObject{
    
    
    // Can't init is singleton
    private override init() {
        print("====Its Working=====")
    }
    // MARK: Shared Instance
    private static var shared:HttpHandler?
    
    
    class func sharedManager()-> HttpHandler {
        
        if shared == nil {
            shared = HttpHandler()
        }
        return shared!
    
    }
    
    func AlamoFireRequest(rp: requestParameters,completed:@escaping (_ resJson : Any?, _ error : Error?) -> Void) {
    
            AF.request(rp.url, method:rp.method, parameters: rp.parameters).validate().responseJSON { response in
                switch response.result {
                case .success:

                    completed(response.data as AnyObject?, nil)
                case .failure(let error):
                    print ("#########################failure : \(rp.url)###############################")
                    //print("HttpHandler : .none error message : \(String(describing: response.result))")
                    
                    //print("HttpHandler : .none error message : \(String(describing: response.result.value))")
                    print("HttpHandler : .none error : \(error.localizedDescription)")
                    completed(nil, error)
                }
            }
    }
}
