//
//  GeneralViewController.swift
//  Moto_Service_Book
//
//  Created by Darko Golubovic on 21.12.22..
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class GeneralViewController : UIViewController{
    
    @IBOutlet weak var markeLb: UILabel!
    @IBOutlet weak var modelLb: UILabel!
    @IBOutlet weak var lastServiceLb: UILabel!
    @IBOutlet weak var dateOfBuyLb: UILabel!
    @IBOutlet weak var kmLb: UILabel!
    @IBOutlet weak var yearLb: UILabel!
    
    var moto :[String : Any] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        getMotocycle()
      //  putValue()
        
    }
    
    func getMotocycle(){
        
        
        let db = Firestore.firestore()
        let uId = Auth.auth().currentUser!.uid
        let docRef = db.collection("user").document(uId).collection("Motocycle")
        docRef.getDocuments { (querySnapshot, error) in
          if let error = error {
            print("Error getting documents: \(error)")
          } else {
              let documents = querySnapshot!.documents
              let firstMoto = documents[0]
              let prep = firstMoto.data()
              self.moto = prep
              let motoValue = self.moto.mapValues { String(describing: $0) }
              self.markeLb.text = motoValue["Marke"]
              self.modelLb.text = motoValue["Model"]
              self.yearLb.text  = motoValue["Year"]
              print(motoValue)
            }
        }
    
    }
}
