//
//  ViewController.swift
//  prj
//
//  Created by user on 6/16/18.
//  Copyright © 2018 App Dev. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit
import FirebaseStorage
import SwiftyJSON
class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    let Image = [UIImage(named: "kalen-emsley-98265-unsplash"),UIImage(named: "kalen-emsley-98265-unsplash.jpg"),UIImage(named: "kalen-emsley-98265-unsplash.jpg")]
    
//    fileprivate func fetchFacebookUser() {
//
//        let graphRequestConnection = GraphRequestConnection()
//        let graphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "id, email, name, picture.type(large)"], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: .defaultVersion)
//        graphRequestConnection.add(graphRequest, completion: { (httpResponse, result) in
//            switch result {
//            case .success(response: let response):
//
//                guard let responseDict = response.dictionaryValue else { Service.dismissHud(self.hud, text: "Error", detailText: "Failed to fetch user.", delay: 3); return }
//
//                let json = JSON(responseDict)
//                self.name = json["name"].string
//                self.email = json["email"].string
//                guard let profilePictureUrl = json["picture"]["data"]["url"].string else { Service.dismissHud(self.hud, text: "Error", detailText: "Failed to fetch user.", delay: 3); return }
//                guard let url = URL(string: profilePictureUrl) else { Service.dismissHud(self.hud, text: "Error", detailText: "Failed to fetch user.", delay: 3); return }
//
//                URLSession.shared.dataTask(with: url) { (data, response, err) in
//                    if err != nil {
//                        guard let err = err else { Service.dismissHud(self.hud, text: "Error", detailText: "Failed to fetch user.", delay: 3); return }
//                        Service.dismissHud(self.hud, text: "Fetch error", detailText: err.localizedDescription, delay: 3)
//                        return
//                    }
//                    guard let data = data else { Service.dismissHud(self.hud, text: "Error", detailText: "Failed to fetch user.", delay: 3); return }
//                    self.profileImage = UIImage(data: data)
//                    self.saveUserIntoFirebaseDatabase()
//
//                    }.resume()
//
//                break
//            case .failed(let err):
//                Service.dismissHud(self.hud, text: "Error", detailText: "Failed to get Facebook user with error: \(err)", delay: 3)
//                break
//            }
//        })
//        graphRequestConnection.start()
//
//
//    }
   
    @IBAction func loginWithFB(_ sender: UIButton){
        //Firstly login with FB SDK
        let fbloginManager = FBSDKLoginManager()
        fbloginManager.logIn(withReadPermissions: ["public_profile","email"], from:self) {
            (loginResult, error) in
            if error == nil {
                // Proceed to firebase
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                Auth.auth().signIn(with: credential) { (user, error ) in
                    if error == nil {
                        print("Login Success")
                    }
                    else {
                        print(error?.localizedDescription)
                    }
                }
                
            }
        }
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
   cell.Image.image = Image[indexPath.row]
        return cell
    }



}

