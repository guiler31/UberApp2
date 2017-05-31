//
//  SignInVC.swift
//  EmergencyUBERForRaider
//
//  Created by Alejandro Marañés on 27/5/17.
//  Copyright © 2017 Alejandro Marañés. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {
    
    private let RIDER_SEGUE = "RiderVC";
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: AnyObject) {
        
        
        
            if emailTextField.text != "" && passwordTextField.text !=
            ""{
                AuthProvider.Instance.login(withEmail: emailTextField.text!, password: passwordTextField.text!, loginHandler: { (message) in
                    
                    if message != nil{
                        self.alertTheUser(title: "Problem With Authetication", message: message!);
                    } else {
                        
                        UberHandler.Instance.rider = self.emailTextField.text!;
                        
                        self.emailTextField.text = "";
                        self.passwordTextField.text = "";
                        
                       self.performSegue(withIdentifier: self.RIDER_SEGUE, sender: nil);
                    }
                
                });
                
            } else {
                alertTheUser(title: "Email and Password are Required", message: "Please enter the email and the Password in the text fields");
        }
    }
    
    @IBAction func signUp(_ sender: AnyObject) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            AuthProvider.Instance.signUP(withEmail: emailTextField.text!, password: passwordTextField.text!, loginHandler: {
                (message) in
                
                if message != nil{
                    self.alertTheUser(title: "Problem With Creating a New User", message: message!);
                } else {
                    UberHandler.Instance.rider = self.emailTextField.text!;
                    
                    self.emailTextField.text = "";
                    self.passwordTextField.text = "";
                    
                    self.performSegue(withIdentifier: self.RIDER_SEGUE, sender: nil);
                }
                
            });
            
        } else {
            self.alertTheUser(title: "Email and Password are Required", message: "Please enter the email and the Password in the text fields");
            
        }
    }
    
    private func alertTheUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil);
        alert.addAction(ok);
        present(alert, animated: true, completion: nil);
            
        
    }
    

    
} // class







































































