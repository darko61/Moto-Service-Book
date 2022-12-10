//
//  SingUpViewController.swift
//  Moto_Servis_Book
//
//  Created by Darko Golubovic on 7.3.22..
//

import UIKit
import FirebaseAuth
import Firebase

class SingUpViewController : ViewController{
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var singUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func validateFields() -> String?{
        
        if
            password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Please fill all fields!"
        }
        
        let cleanPassword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanPassword) == false{
            return "Please make sure your password is at least 8 characters, contains special characters and numbers."
        }
        return nil
    }
    
    @IBAction func singUpButtonTapped(_ sender: UIButton) {
        let error = validateFields()
        
        if error != nil{
            showError(message: error)
        }
        else{
            let emailTf = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let passTf = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let firstNameTf = firstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastNameTf = lastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: emailTf, password: passTf) { result, err in
                if let e = err{
                    print(e)
                }
                else{
                    
                    let db = Firestore.firestore()
                    db.collection("user").document(result!.user.uid).setData(["firstname" : firstNameTf , "lastname" : lastNameTf , "email" : emailTf , "password" : passTf]){ (error) in
                        
                        if error != nil{
                            self.showError(message: "Cannot create user!")
                        }
                    }
                    self.performSegue(withIdentifier: "HomeVCSU", sender: self)
                }
            }
        }
    }
    func showError(message: String?){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    
    
}
