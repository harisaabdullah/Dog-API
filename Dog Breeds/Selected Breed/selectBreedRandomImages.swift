//
//  selectBreedRandomImages.swift
//  Dog Breeds
//
//  Created by Haris Abdullah on 5/16/22.
//

import Foundation

import Foundation

protocol selectedBreedRandomImagesViewModelDelegate {
    
    /**
     * Use this delegate method to pass values to the respective view controller where selected breed API is to be called.
     *
     * - Parameters:
     *   - message: Contains the message returned from the server
     *   - data: Contains data returned in reponse of selected Breed API
     *   - isSuccessful: Flag for success and failure of selected breed API response
     */
    func didRecieveSelectedBreedRandomImagesAPIResponse(message: String, data: selectedBreed?, isSuccessful: Bool)
}
class selectedBreedRandomImagesViewModel{
    
    var delegate: selectedBreedRandomImagesViewModelDelegate?
    var apiManager = APIManager.shared()
    
    func selectedBreedRandomImages(breedName: String, count: String){
        apiManager.processGetSelectedBreedRandomImages(breedName: breedName, count: count, completion: {[weak self] (isSuccessful, errorMessage, results) in
            
            if let mSelf = self {
                
                if isSuccessful {
                        
                        mSelf.delegate?.didRecieveSelectedBreedRandomImagesAPIResponse(message: "",  data: results, isSuccessful: isSuccessful)
                }
                else {
                    
                    mSelf.delegate?.didRecieveSelectedBreedRandomImagesAPIResponse(message: errorMessage ?? "We are unable to process your request. Please try again.", data: nil, isSuccessful: false)
                }
            }
        })
    }
}
