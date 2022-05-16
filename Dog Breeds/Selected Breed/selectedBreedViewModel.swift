//
//  selectedBreedViewModel.swift
//  Dog Breeds
//
//  Created by Haris Abdullah on 5/14/22.
//

import Foundation
import UIKit

protocol selectedBreedViewModelDelegate {
    
    /**
     * Use this delegate method to pass values to the respective view controller where selected breed API is to be called.
     *
     * - Parameters:
     *   - message: Contains the message returned from the server
     *   - data: Contains data returned in reponse of selected Breed API
     *   - isSuccessful: Flag for success and failure of selected breed API response
     */
    func didRecieveSelectedBreedAPIResponse(message: String, data: selectedBreed?, isSuccessful: Bool)
}
class selectedBreedViewModel{
    
    var delegate: selectedBreedViewModelDelegate?
    var apiManager = APIManager.shared()
    
    func selectedBreed(breedName: String){
        apiManager.processGetSelectedBreed(breedName: breedName, completion: {[weak self] (isSuccessful, errorMessage, results) in
            
            if let mSelf = self {
                
                if isSuccessful {
                        
                        mSelf.delegate?.didRecieveSelectedBreedAPIResponse(message: "",  data: results, isSuccessful: isSuccessful)
                }
                else {
                    
                    mSelf.delegate?.didRecieveSelectedBreedAPIResponse(message: errorMessage ?? "We are unable to process your request. Please try again.", data: nil, isSuccessful: false)
                }
            }
        })
    }
}
