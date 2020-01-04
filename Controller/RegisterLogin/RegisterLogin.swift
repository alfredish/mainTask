//
//  ViewController.swift
//  MainTask
//
//  Created by кирилл корнющенков on 02.01.2020.
//  Copyright © 2020 кирилл корнющенков. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RegisterLogin: UIViewController{

    var singup:Bool = true{
        willSet{
            if newValue{
                loginField.isHidden = false
                enterButton.setTitle("Зарегистрироваться", for: .normal)
            }else{
                loginField.isHidden = true
                enterButton.setTitle("Войти", for: .normal)
            }
        }
    }
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func segment(_ sender: UISegmentedControl) {
        singup = !singup
    }
    
    //Кнопка входа
    @IBAction func GoButton(_ sender: UIButton) {
        let password = passwordField.text!
        let email = emailField.text!
        let login = loginField.text!
        if (singup){
            if(!password.isEmpty && !email.isEmpty && !login.isEmpty){
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if error == nil{
                        if let result = result{
                            //print(result.user.uid)
                            let ref = Database.database().reference().child("users")
                            ref.child(result.user.uid).updateChildValues(["login":login,"email":email])
                        }
                    }
                }
            }else{
                errorAlert()
            }
        }else{
            if(!email.isEmpty && !password.isEmpty){
                Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                    if error == nil{
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }else{
                errorAlert()
            }
        }
    }
    
    
    
    //MARK: alert, если какое-то из полей ввода пустое
    func errorAlert(){
    }
    
}

