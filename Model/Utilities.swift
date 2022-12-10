//
//  Utilities.swift
//  Moto_Servis_Book
//
//  Created by Darko Golubovic on 7.3.22..
//

import Foundation
import UIKit
import FirebaseAuth

let marke = ["Ducati", "Honda" , "Yamaha" , "KTM", "Suzuki"]


class  Utilities{
    
    static func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func singOut(){
        do {
          try Auth.auth().signOut()
        } catch {
          print("Sign out error")
        }
    }
    
    
    
    
}

