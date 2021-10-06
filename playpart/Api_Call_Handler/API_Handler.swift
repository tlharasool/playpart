//
//  API_Handler.swift
//  playpart
//
//  Created by Atif Habib on 13/09/2021.
//

import Foundation
import SwiftUI
import SwiftKeychainWrapper

enum AppKey : String{
    case accessToken = "accessTokenKey"
    var value : String {return rawValue}
}

struct APIURL{
    //"https://localhost:3000/api/v1/"
    // "https://app.playpart.xyz/api/v1/"
    
    static let baseURL  = "https://app.playpart.xyz/api/v1/"
    static let register = "auth/sign_up"
    static let Login = "auth/login"
    
}

class API_Handler{
    
    private init(){}
    static let shared = API_Handler()
    let loader = LoadingView()
    
    func registerUser(parameters : [String : Any], success: @escaping(String) -> (), failure : @escaping (String) ->()){
        
        let registerURL = APIURL.baseURL + APIURL.register
        if let url = URL(string: registerURL ){
            
            var request = URLRequest(url: url)
            //let loading = LoadingView()
            request.timeoutInterval = 60
            let userData = parameters
            request.httpMethod = "post"
            do {
                let userRequest = try JSONSerialization.data(withJSONObject: userData, options: .prettyPrinted)
                request.httpBody = userRequest
                request.addValue("application/json", forHTTPHeaderField: "content-type")
                
            } catch let error {
                debugPrint(error.localizedDescription)
            }
            
            URLSession.shared.dataTask(with: request) {(data, HTTPURLResponse,error) in
                
                if  error != nil{
                    let msg = error?.localizedDescription ?? ""
                    failure(msg)
                    //print(ServerResponseModel)
                    //loading.stopLoader(loader: loading.loader())
                    return
                }
                do{
                    if let json = try JSONSerialization.jsonObject(with: data!, options: [])
                        as? [String : Any]{
                        print("The JSON is here")
                        print(json)
                        let user = UserModel(json)
                        let  parseJson = json
                        let accessToken = user.meta.token as? String
                        let userId = parseJson["id"] as? String
                        print("Access Token => \(accessToken)")
                        print("User Id => \(userId)")
                        
                        //let saveAccessToken: Bool = KeychainWrapper.standard.set(accessToken!, forKey: "sccessToken")
                        //let saveUSerID: Bool = KeychainWrapper.standard.set(userId!, forKey: "userId")
                        //print("Access Token => \(saveAccessToken)")
                        //print("User Id => \(saveUSerID)")
                       // if (accessToken?.isEmpty)!{
                         //   print("Request doesnot successfully perform")
                        //}
                        
                        let serverModel = ServerResponseModel(json)
                        
                        if serverModel.message.isEmpty{
                            let userModel = UserModel(json)
                            print(userModel.meta.token)
                            
                            print(userModel.user.email)
                            success(userModel.user.email)
                            
                        }
                        else{
                            print(serverModel.message)
                            print(serverModel.sucess)
                            failure(serverModel.message)
                            //loading.stopLoader(loader: loading.loader())
                        }
                        
                    }
                    
                }catch{
                    print("error")
                    
                }
                
            }.resume()
            
        }
    }
}

extension API_Handler{
    
    func LogInUser(parameters : [String: String?], failure :  @escaping (String) ->(), success : @escaping (String)->()){
        
        let registerURL = APIURL.baseURL + APIURL.Login
        if let url = URL(string: registerURL ){
            
            var request = URLRequest(url: url)
            let userData = parameters
            request.httpMethod = "post"
            
            do {
                let userRequest = try JSONSerialization.data(withJSONObject: userData, options: .prettyPrinted)
                request.httpBody = userRequest
                request.addValue("application/json", forHTTPHeaderField: "content-type")
            } catch let error {
                debugPrint(error.localizedDescription)
                print("alert occur")
            }
            URLSession.shared.dataTask(with: request) {(data, HTTPURLResponse,error)in
                if  error != nil{
                    let msg = error?.localizedDescription ?? ""
                    failure(msg)
                    return
                }
                do{
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any] {
                        request.timeoutInterval = 60
                        print("The JSON is here")
                        print(json)
          
                        let serverModel = ServerResponseModel(json)
                        let user = UserModel(json)
                        let accessToken = user.meta.token
                        CustomUserDefaults.shared.set(true, key: .isLogin)
                        print("Access Token => \(accessToken)")
                        let saveAccessToken: Bool = KeychainWrapper.standard.set(accessToken, forKey: AppKey.accessToken.value)

                        print("Access Token => \(saveAccessToken)")
                        
                        if serverModel.message.isEmpty
                        {
                            
                            success(serverModel.message)
                            
                            
                            
                            print("succesfully logged in :)")
                        }
                        else
                        {
                            failure(serverModel.message)
                        }
                        
                
                        
                    }
                }catch{
                    print("erroMsg")}
            }.resume()
        }
    }
    
}
/*if let parseJson = json{
 let accessToken = parseJson["token"] as? String
 let userId = parseJson["id"] as? String
 
 let saveAccessToken: Bool = KeychainWrapper.standard.set(accessToken!, forKey: "sccessToken")
 let saveUSerID: Bool = KeychainWrapper.standard.set(userId!, forKey: "userId")
 print("Access Token => \(saveAccessToken)")
 print("User Id => \(saveUSerID)")
 
 
 
 if (accessToken?.isEmpty)!{
 print("Request doesnot successfully perform")
 }*/


class CustomUserDefaults {
    // define all keys needed
    enum DefaultsKey: String, CaseIterable {
        case name
        case email
        case isUserLogin
        case userLevel
        case isLogin
    }
    static let shared = CustomUserDefaults()
    private let defaults = UserDefaults.standard

    init() {}
    // to set value using pre-defined key
    func set(_ value: Any?, key: DefaultsKey) {
        defaults.setValue(value, forKey: key.rawValue)
    }
    // get value using pre-defined key
    func get(key: DefaultsKey) -> Any? {
        return defaults.value(forKey: key.rawValue)
    }
    // check value if exist or nil
    func hasValue(key: DefaultsKey) -> Bool {
        return defaults.value(forKey: key.rawValue) != nil
    }
    // remove all stored values
    func removeAll() {
        for key in DefaultsKey.allCases {
            defaults.removeObject(forKey: key.rawValue)
        }
    }
}

extension UserDefaults {
  func setCodable<T: Codable>(_ value: T, forKey key: String) {
    guard let data = try? JSONEncoder().encode(value) else {
      fatalError("Cannot create a json representation of \(value)")
    }
    self.set(data, forKey: key)
  }

  func codable<T: Codable>(forKey key: String) -> T? {
    guard let data = self.data(forKey: key) else {
      return nil
    }
    return try? JSONDecoder().decode(T.self, from: data)
  }
}
