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
class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    let Image = [UIImage(named: "kalen-emsley-98265-unsplash"),UIImage(named: "kalen-emsley-98265-unsplash.jpg"),UIImage(named: "kalen-emsley-98265-unsplash.jpg")]
    
    
   
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

