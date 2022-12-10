//
//  LogInViewController.swift
//  Moto_Servis_Book
//
//  Created by Darko Golubovic on 7.3.22..
//

import UIKit
import Firebase
import FirebaseAuth


class LogInViewController : ViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorLb: UILabel!
    @IBOutlet weak var logIn: UIButton!
    
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
        else{
            return nil
        }
            }
    @IBAction func isLogInTapped(_ sender: UIButton) {
        
        let validate = validateFields()
        
        if validate != nil{
            showError(message: validate)
            
        }
        else{
            let emailTf = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let passTf = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: emailTf, password: passTf) { result, err in
                if let e = err{
                    print(e)
                }
                else{
                    
                    self.performSegue(withIdentifier: "HomeVCSU", sender: self)
                }
            }
        }
    }
    func showError(message: String?){
        errorLb.text = "Pokusajte ponovo"
        errorLb.alpha = 1
    }
    
}
