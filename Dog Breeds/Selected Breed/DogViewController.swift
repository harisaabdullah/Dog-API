//
//  DogViewController.swift
//  Dog Breeds
//
//  Created by Haris Abdullah on 5/15/22.
//

import UIKit
import MBProgressHUD

class DogViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelBreedName: UILabel!
    var viewModel = selectedBreedViewModel()
    var viewModelRandomImages = selectedBreedRandomImagesViewModel()
    var breedImageList = [String]()
    var selectedBreed = ""
    var numberOfImages = ""
    
    //MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelBreedName.text = self.selectedBreed.uppercased()
        self.viewModel.delegate = self
        self.viewModelRandomImages.delegate = self
        MBProgressHUD.showAdded(to: self.view, animated: true)
        if self.numberOfImages == "0"{
            self.viewModel.selectedBreed(breedName: selectedBreed)
        }
        else{
            self.viewModelRandomImages.selectedBreedRandomImages(breedName: self.selectedBreed, count: self.numberOfImages)
        }
    
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Private Functions
   
    /// This function is creating an alert that will shown to user when fetching images of specific breed is unsuccessfull
    func alert(){
        let alert = UIAlertController(title: "Alert!", message: "Unable to load images of \(self.selectedBreed). Please try again later.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - Extensions

extension DogViewController: selectedBreedViewModelDelegate{
    
    /// This delegate method gives us the response of selected breed API
    /// - Parameters:
    ///   - message: Contains the message returned from the server incase of failure
    ///   - data: Contains response of selected breed API
    ///   - isSuccessful: Flag for success and failure of selected breed API response
    func didRecieveSelectedBreedAPIResponse(message: String, data: selectedBreed?, isSuccessful: Bool) {

        if isSuccessful{
            self.breedImageList = (data?.message)!
            print("All Images Fetched")
            self.collectionView.reloadData()
            
        }
        else{
            MBProgressHUD.hide(for: self.view, animated: true)
            alert()
        }
    }
}

extension DogViewController: selectedBreedRandomImagesViewModelDelegate{
    
    /// This delegate method gives us the response of selected breed random images API
    /// - Parameters:
    ///   - message: Contains the message returned from the server incase of failure
    ///   - data: Contains response of selected breed random images API
    ///   - isSuccessful: Flag for success and failure of selected breed random images API response
    func didRecieveSelectedBreedRandomImagesAPIResponse(message: String, data: selectedBreed?, isSuccessful: Bool) {
        
        if isSuccessful{
            self.breedImageList = (data?.message)!
            self.collectionView.reloadData()
        }
        else{
            MBProgressHUD.hide(for: self.view, animated: true)
            alert()
        }
    }
}

///Extension for CollectionView in which CollectionViewCells are populated
extension DogViewController: UICollectionViewDelegate, UICollectionViewDataSource{
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.breedImageList.count
    }

    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        ///Creating a reusable collectionviewcell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedBreedCollectionViewCell", for: indexPath) as! SelectedBreedCollectionViewCell
        let imageURL = self.breedImageList[indexPath.row]
        let url = URL(string: imageURL)
        let data = try? Data(contentsOf: url!)
        DispatchQueue.main.async {
            ///Populating the reusable collectionviewcell with breed image
            cell.breedImageView.image = UIImage(data: data!)
        }
        
        ///Stopping the loader when all of the images have been loaded
        if indexPath.row == self.breedImageList.count - 1{
            MBProgressHUD.hide(for: self.view, animated: true)
        }
        return cell
        
    }
}
