//
//  breedListViewModel.swift
//  Dog Breeds
//
//  Created by Haris Abdullah on 5/14/22.
//

import Foundation
import UIKit

protocol breedListViewModelDelegate {
    
    /**
     * Use this delegate method to pass values to the respective view controller where breed listl API is to be called.
     *
     * - Parameters:
     *   - message: Contains the message returned from the server
     *   - data: Contains data returned in reponse of breed List API
     *   - isSuccessful: Flag for success and failure of breed list API response
     */
    func didRecieveBreedListAPIResponse(message: String,  data: breedList?, isSuccessful: Bool)
}
class breedListViewModel{
    var delegate : breedListViewModelDelegate?
    var apiManager = APIManager.shared()
    
    func dogList(){
        apiManager.processGetDogList(completion: {[weak self] (isSuccessful, errorMessage, results) in

            if let mSelf = self {

                if isSuccessful {

                        mSelf.delegate?.didRecieveBreedListAPIResponse(message: "",  data: results, isSuccessful: isSuccessful)
                }
                else {

                    mSelf.delegate?.didRecieveBreedListAPIResponse(message: errorMessage ?? "We are unable to process your request. Please try again.", data: nil, isSuccessful: false)
                }
            }
        })
    }
}
