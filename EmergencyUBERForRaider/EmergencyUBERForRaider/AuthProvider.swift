//
//  AuthProvider.swift
//  EmergencyUBERForRaider
//
//  Created by Alejandro Marañés on 27/5/17.
//  Copyright © 2017 Alejandro Marañés. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias LoginHandler = (_ msg: String?) -> Void;

struct LoginErrorCode{
    static let INVALID_EMAIL = "This email is incorrect please register a new mail";
    static let WRONG_PASSWORD = "This password is incorrect, please enter the password correctly";
    static let PROBLEM_CONNECTING = "There was a problem with the connection try again later";
    static let USER_NOT_FOUND = "This user can not be found please register a new user";
    static let EMAIL_ALREDY_IN_USE = "This email is already in use please register a new mail";
    static let WEAK_PASSWORD = "The password must be at least 8 characters long, please enter the 8 minimum characters of your password";
    static let USER_DISABLED = "This user has been banned from this place please register a new user in order to use the application";

}

class AuthProvider {
    private static let _instance = AuthProvider();
    
    static var Instance: AuthProvider {
        return _instance;
    }
    
    func login(withEmail: String, password: String, loginHandler: LoginHandler?) {
        
        Auth.auth().signIn(withEmail: withEmail, password: password, completion:{
            (user, error) in
            
            if error != nil {
                self.handlerError(err: error! as NSError, loginHandler: loginHandler);
            }else{
                loginHandler?(nil);
            
            }
        });
        
    }
    
    func signUP(withEmail: String, password: String, loginHandler: LoginHandler? ) {
        
        Auth.auth().createUser(withEmail: withEmail,
            password: password, completion:  { (user, error) in
                
                if error != nil {
                    self.handlerError(err: error! as NSError, loginHandler: loginHandler);
                    
                } else {
                    
                    if user?.uid != nil {
                        
                        DBProvider.Instance.saveUser(withID: user!.uid, email: withEmail, password: password);
                        
                        
                        
                        
                        self.login(withEmail: withEmail, password: password, loginHandler: loginHandler);
                        
                        
                    }
                }
        
        });
    }
    
    func logOut() -> Bool{
        if Auth.auth().currentUser != nil{
            do{
                try Auth.auth().signOut();
                return true;
            } catch {
                return false;
            }
        }
        return true;
    }
    
    
    
    
    
    private func handlerError(err: NSError, loginHandler: LoginHandler?){
        
        if let errCode = AuthErrorCode(rawValue: err.code){
            
            switch errCode{
                
            case.wrongPassword:
                loginHandler?(LoginErrorCode.WRONG_PASSWORD);
                break;
                
            case.weakPassword:
                loginHandler?(LoginErrorCode.WEAK_PASSWORD);
                break;
            
            case.userNotFound:
                loginHandler?(LoginErrorCode.USER_NOT_FOUND);
                break;
                

            case.userDisabled:
                loginHandler?(LoginErrorCode.USER_DISABLED);
                break;
                

            case.invalidEmail:
                loginHandler?(LoginErrorCode.INVALID_EMAIL);
                break;
                

            case.emailAlreadyInUse:
                loginHandler?(LoginErrorCode.EMAIL_ALREDY_IN_USE);
                break;
                
            default:
                loginHandler?(LoginErrorCode.PROBLEM_CONNECTING);
                break;
                
                }
                

                

                
                
            }
            
        }
        
    }
