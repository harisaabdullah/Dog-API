//
//  DogListViewController.swift
//  Dog Breeds
//
//  Created by Haris Abdullah on 5/15/22.
//

import UIKit

class DogListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = breedListViewModel()
    var viewModelS = selectedBreedViewModel()
    var dogListObject : breedList?
    var dogList = [String]()
    var breedImageList = [String]()
    var numberOfImages = ""
    
    // MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        self.viewModel.dogList()
        
        // Do any additional setup after loading the view.
    }

    //MARK: - Private Antions
    
    /// This function is creating an alert that will shown to user when fetching breed list is unsuccessfull
    func alert(){
        let alert = UIAlertController(title: "Alert!", message: "Unable to fetch breed list. Please try again later.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    /// This function is creating an alert that will shown to user when he taps on a specific breed and get their input in a textfield for total number of images they would like to see.
    /// - Parameters:
    ///   - selectedBreed: Contains name of the breed user has selected to see it's images
    func alertForNumberOfImages(selectedBreed: String){
        let alert = UIAlertController(title: "Alert!", message: "How many pictures of \(selectedBreed) would you like to see?", preferredStyle: .alert)
        alert.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned alert] _ in
            self.numberOfImages = alert.textFields![0].text ?? "20"
            
            ///Navigation to the new ViewController where user can see the images of there requested breed.
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: "DogViewController") as! DogViewController
            viewController.selectedBreed = selectedBreed
            viewController.numberOfImages = self.numberOfImages
            self.present(viewController, animated:true, completion:nil)
            

        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            ///Navigation to the new ViewController where user can see all the images of there requested breed.
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: "DogViewController") as! DogViewController
            viewController.selectedBreed = selectedBreed
            viewController.numberOfImages = "0"
            self.present(viewController, animated:true, completion:nil)
        }))
        
        alert.addAction(submitAction)
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

// MARK: Extensions
extension DogListViewController: breedListViewModelDelegate{
   
    /// This delegate method gives us the response of breedList API
    /// - Parameters:
    ///   - message: Contains the message returned from the server incase of failure
    ///   - data: Contains response of breedList API
    ///   - isSuccessful: Flag for success and failure of breedList API response
    func didRecieveBreedListAPIResponse(message: String, data: breedList?, isSuccessful: Bool) {
        if isSuccessful{
            self.dogList = (data?.message.keys.map({$0}))!
            ///Sorting the breed list alphabetically
            self.dogList = self.dogList.sorted()
            self.tableView.reloadData()
        }
        else{
            alert()
        }
    }
    
}

///Extension of TableView in which tabelViewCells are populated
extension DogListViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dogList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        ///Creating a reusable tableviewcell
        let cell = tableView.dequeueReusableCell(withIdentifier: "BreedListTableViewCell") as! BreedListTableViewCell
        ///Populating the reusable tableviewcell with breed name
        cell.breedNameLabel.text = self.dogList[indexPath.row].uppercased()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alertForNumberOfImages(selectedBreed: self.dogList[indexPath.row].lowercased())
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

