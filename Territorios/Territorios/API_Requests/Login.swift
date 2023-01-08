//
//  Login.swift
//  Territorios
//
//  Created by Jose Blanco on 12/30/22.
//

import Foundation
import Alamofire
import SwiftUI

func login(log: Login, loginError: @escaping (String, Bool?) -> Void, success: @escaping (Congregation) -> Void) {
    
    
    //Run request function
    postRequest(url: "congregations/login", body: Login(id: log.id, password: log.password), method: .post) { result, error  in
        //check string, code to json, create congre struct
        if let result = result {
            do {
                let decoder = JSONDecoder()
                let jsonData = result.data(using: .utf8)!
                
                let congre = try decoder.decode(Congregation.self, from: jsonData)
                print(congre)
                //TODO
                success(congre)
                
            } catch {
                print("error")
                //COULD NOT CODE JSON
                loginError("""
                (405 Error)
                Please type Congregation ID and Password.
                """, true)
            }
            
        } else {
            
            //TODO Change UI
            print("WASSUP")
            switch (error?.asAFError?.responseCode) {
            case 404:
                //Congregation Number is wrong
                print("Congregation Number is wrong")
                loginError("""
                (404 Error)
                Congregation Number is wrong. Please try again."
                """, true)
                
            case 401:
                //Password is wrong
                print("Password is wrong")
                loginError("""
                (401 Error)
                Congregation Password is wrong. Please try again.
                """, true)
                
            default:
                //Generic Error
                print("Generic Error")
                loginError("""
                (405 Error)
                Fatal Error. Could not log in. Please check your network connection and try again.
                """, true)
            }
            
        }
    }
}
