//
//  DBProvider.swift
//  EmergencyUBERForRaider
//
//  Created by Alejandro Marañés on 28/5/17.
//  Copyright © 2017 Alejandro Marañés. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DBProvider{
    private static let _instance = DBProvider();
    
    static var Instance: DBProvider{
        return _instance;
    }
    
    var dbRef: DatabaseReference{
        return Database.database().reference();
    }
    
    var ridersRef: DatabaseReference {
        return dbRef.child(Constants.RIDERS);
    }
    
    // request ref
    var requestRef: DatabaseReference{
        return dbRef.child(Constants.UBER_REQUEST);
    }
    
    //requestAccepted
    var requestAcceptedRef: DatabaseReference {
        return dbRef.child(Constants.UBER_ACCEPTED);
    }
    
    func saveUser(withID: String, email: String, password: String){
        let data: Dictionary<String, Any> = [Constants.EMAIL: email, Constants.PASSWORD: password, Constants.isRider: true];
        
        ridersRef.child(withID).child(Constants.DATA).setValue(data);
    }
    
} // class
