//
//  APIManager.swift
//  Dog Breeds
//
//  Created by Haris Abdullah on 5/14/22.
//

import Foundation

import Alamofire

final class APIManager{
    
    var httpHandler =  HttpHandler.sharedManager()
    
    private func initConfiguration() {
        httpHandler =  HttpHandler.sharedManager()
    }
    
    // MARK: Shared Instance
    private static var instance: APIManager!
    
    public static func shared() -> APIManager {
        if instance == nil {
            instance = APIManager()
        }
        instance.initConfiguration()
        return instance
        
    }
    
    //MARK:- APIS
    
    //Dog List API to complete list of breeds available on the server
    func processGetDogList(completion : @escaping (_ isSuccessful: Bool, _ errorMessage : String?, _ arrResults : breedList?) -> Void){
        
        httpHandler =  HttpHandler.sharedManager()
    
        let url = "https://dog.ceo/api/breeds/list/all"
        let reqParams: requestParameters = requestParameters(url: url, method: .get, parameters: nil)
        httpHandler.AlamoFireRequest(rp: reqParams) { (resJson, error) in
    
            if resJson != nil {
                do {
                    let response = try JSONDecoder().decode(breedList.self, from: resJson as! Data)
                    completion(true,nil,response)
                } catch {
                    print(error)
                    completion(false,error.localizedDescription, nil)
                }
            }
            else{
                completion(false, error?.localizedDescription, nil)
            }
        }
    }
    
    //Selected Breed API to fetch all of it's images available on server
    func processGetSelectedBreed(breedName: String, completion : @escaping (_ isSuccessful: Bool, _ errorMessage : String?, _ arrResults : selectedBreed?) -> Void){
        
        httpHandler =  HttpHandler.sharedManager()
        
        let url = "https://dog.ceo/api/breed/\(breedName)/images"
        let reqParams: requestParameters = requestParameters(url: url, method: .get, parameters: nil)
    
        httpHandler.AlamoFireRequest(rp: reqParams) { (resJson, error) in
            
            if resJson != nil {
                do {
                    let response = try JSONDecoder().decode(selectedBreed.self, from: resJson as! Data)
                    completion(true,nil,response)
                } catch {
                    print(error)
                    completion(false,error.localizedDescription, nil)
                }
            }
            else{
                completion(false, error?.localizedDescription, nil)
            }
        }
        
    }
    
    //Selected Breed Random API to fetch limited random images from the server
    func processGetSelectedBreedRandomImages(breedName: String, count: String, completion : @escaping (_ isSuccessful: Bool, _ errorMessage : String?, _ arrResults : selectedBreed?) -> Void){
        
        httpHandler =  HttpHandler.sharedManager()
        
        let url = "https://dog.ceo/api/breed/\(breedName)/images/random/\(count)"
        let reqParams: requestParameters = requestParameters(url: url, method: .get, parameters: nil)
    
        httpHandler.AlamoFireRequest(rp: reqParams) { (resJson, error) in
            
            if resJson != nil {
                do {
                    let response = try JSONDecoder().decode(selectedBreed.self, from: resJson as! Data)
                    completion(true,nil,response)
                } catch {
                    print(error)
                    completion(false,error.localizedDescription, nil)
                }
            }
            else{
                completion(false, error?.localizedDescription, nil)
            }
        }
        
    }
}





