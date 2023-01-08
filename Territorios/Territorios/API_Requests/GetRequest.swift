//
//  GetRequest.swift
//  Territorios
//
//  Created by Jose Blanco on 12/25/22.
//

import Foundation
import Alamofire
import SwiftUI

func postRequest<T: Encodable>(url: String, body: T, method: HTTPMethod, result: @escaping (String?, Error?) -> Void) {
    //Send request to server
    AF.request("https://servicemaps.apps-smartsolutions.online/api/\(url)", method: method, parameters: body, encoder: JSONParameterEncoder.default)
        .validate()
        .responseString { response in
            switch response.result {
                //Receive code, check if good or bad
            case .success:
                print("Validated")
                result(response.value, nil)
                
            case let .failure(error):
                print(error)
                result(nil, error)
            }
        }
}

func getRequest(url: String, result: @escaping (String?, Error?) -> Void) {
    AF.request("https://servicemaps.apps-smartsolutions.online/api/\(url)")
        .validate()
        .responseString { response in
            switch response.result {
                //Receive code, check if good or bad
            case .success:
                print("Validated")
                print(response.value!.description)
                result(response.value, nil)
                
            case let .failure(error):
                print(error)
                result(nil, error)
            }
        }
}





