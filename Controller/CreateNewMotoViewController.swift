//
//  CreateNewMoto.swift
//  Moto_Service_Book
//
//  Created by Darko Golubovic on 6.12.22..
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class CellClass: UITableViewCell{
    
}

class CreateNewMotoViewController: ViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    

    @IBOutlet weak var markeB: UIButton!
    
    let transparentView = UIView()
        let tableView = UITableView()
        
        let user = Auth.auth().currentUser
        var selectedBtn = UIButton()
        
        var dataSource = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
    }
    
    
    @IBAction func makreBtnIsClicked(_ sender: Any) {
        dataSource = ["Ducati", "Honda" , "Yamaha" , "KTM", "Suzuki"]
        selectedBtn = markeB
        addTransparentView(frames: markeB.frame)

    }
    func addTransparentView(frames : CGRect){
          
          let window = UIApplication.shared.connectedScenes.map({ $0 as? UIWindowScene }).compactMap({ $0 }).first?.windows.first
          transparentView.frame = window?.frame ?? self.view.frame
          self.view.addSubview(transparentView)
          
          tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
          self.view.addSubview(tableView)
          tableView.layer.cornerRadius = 5
          
          transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
          
          let tapgesture = UITapGestureRecognizer(target: self,
                                                  action: #selector(removeTransparentView))
          transparentView.addGestureRecognizer(tapgesture)
          transparentView.alpha = 0
          
          UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
              self.transparentView.alpha = 0.5
              self.tableView.frame = CGRect(x: 75, y: 157 + frames.height + 5, width: frames.width, height: CGFloat((self.dataSource.count - 1) * 60))
          }, completion: nil)
      }
      
      @objc func removeTransparentView(){
          let frames = selectedBtn.frame
          UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
              self.transparentView.alpha = 0
              self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)

          }, completion: nil)
      }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
           cell.textLabel?.text = dataSource[indexPath.row]
           return cell
       }
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 50
       }
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           selectedBtn.setTitle(dataSource[indexPath.row], for: .normal)
           removeTransparentView()
       }



}
