//
//  NetworkHelper.swift
//  ClientServer
//
//  Created by colorsMacBook on 07/04/17.
//  Copyright © 2017 colors software. All rights reserved.
//

import UIKit

public protocol NetworkDelegate{
    
    /// Called when request is sent to server successfully
    ///
    /// - Parameters:
    ///   - response: Success response which is coming from server
    ///   - requestType: Type of request
    func successResponse(response:[String:Any], ForRequestType requestType:Int)
    
    /// Called when request is failed
    ///
    /// - Parameters:
    ///   - response: Failure response which is coming from server
    ///   - requestType: Type of request
    func failureResponse(response:[String:Any], ForRequestType requestType:Int)
}
enum RequestType : Int
{
    case LOGIN_REQ
    case SIGNUP_REQ
    case FORGOTPWD_REQ
}
public class NetworkHelper: NSObject {
    
    public static let sharedInstance: NetworkHelper = NetworkHelper()
    
    public var delegate:NetworkDelegate?
    
 //MARK: - APIs
    
    /// Used to perform login operation
    ///
    /// - Parameter input: A Dictionary with username and password
    public func login(input:[String:Any]){
    
        self.postRequestToServer(urlString: Constants.LOGIN_URL, input: input, forType: RequestType.LOGIN_REQ.rawValue)
        
    }
    
    /// Used to create new account
    ///
    /// - Parameter input: A Dictionary with user's inputs
    public func signup(input:[String:Any]){
        self.postRequestToServer(urlString:Constants.SIGNUP_URL, input: input, forType: RequestType.SIGNUP_REQ.rawValue)
    }
    
    /// Used to get forgot password
    ///
    /// - Parameter input: A Dictionary with user's email or username
    public func forgotPassword(input:[String:Any]){
        self.postRequestToServer(urlString:Constants.FORGOTPWD_URL, input: input, forType: RequestType.FORGOTPWD_REQ.rawValue)
  
    }
    
    //MARK: - Post Request
    
    /// Used to send data to server
    ///
    /// - Parameters:
    ///   - urlString: url for sending data to server
    ///   - input: input data which is send to server
    ///   - type: type of request to server
   internal func postRequestToServer(urlString:String, input:[String:Any], forType type: Int){
        
        
        do {
            if(JSONSerialization.isValidJSONObject(input)){
                let requestUrl = URL(string:urlString)! as URL
                let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60.0)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                let inputData = try JSONSerialization.data(withJSONObject: input, options: JSONSerialization.WritingOptions.prettyPrinted) as Data
                request.httpBody = inputData
                
                let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                    
                    if data != nil{
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                            
                            DispatchQueue.main.async(execute: {
                                self.delegate?.successResponse(response:json as! [String : Any], ForRequestType: type)
                                
                            })
                        }
                        catch {
                            
                            
                        }
                    }
                    else{
                        print("no response")
                        
                        let errorMessage = [Constants.ERROR_MESSAGE :"Some thing went wrong, Please try agaain"]
                        self.delegate?.failureResponse(response:errorMessage, ForRequestType: type)
                    }
                })
                task.resume()
            }
            else{
                
                let errorMessage = [Constants.ERROR_MESSAGE:"Invalid input"]
                self.delegate?.failureResponse(response:errorMessage, ForRequestType: type)
            }
        }
        catch{
            print("error")
        }
    }
    //MARK: - Get Request
    
    /// Used to get data from server
    ///
    /// - Parameters:
    ///   - urlString: url for getting data from server
    ///   - input: input data which used to get data from server
    ///   - type: type of request to server
   internal func getRequestToServer(urlString:String, input:[String:Any], forType type: Int){
        print("getRequestToServer")
        
        do {
            if(JSONSerialization.isValidJSONObject(input)){
                let requestUrl = URL(string:urlString)! as URL
                let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60.0)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                let inputData = try JSONSerialization.data(withJSONObject: input, options: JSONSerialization.WritingOptions.prettyPrinted) as Data
                request.httpBody = inputData
                
                let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                    
                    if data != nil{
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                            
                            DispatchQueue.main.async(execute: {
                                self.delegate?.successResponse(response:json as! [String : Any], ForRequestType: type)
                                
                            })
                        }
                        catch {
                            
                            
                        }
                    }
                    else{
                        print("no response")
                        
                        let errorMessage = [Constants.ERROR_MESSAGE :"Some thing went wrong, Please try agaain"]
                        self.delegate?.failureResponse(response:errorMessage, ForRequestType: type)
                    }
                })
                task.resume()
            }
            else{
                
                let errorMessage = [Constants.ERROR_MESSAGE:"Invalid input"]
                self.delegate?.failureResponse(response:errorMessage, ForRequestType: type)
            }
        }
        catch{
            print("error")
        }
    }

    
}

