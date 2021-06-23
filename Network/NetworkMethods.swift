//
//  NetworkMethods.swift
//  Pods-VichmsAPI_Example
//
//  Created by user195857 on 6/21/21.
//

import Foundation

class NetworkMethods: NetworkGeneric {
    var baseURL: String
    var session: URLSession
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func getMethod<T: Decodable>(endpoint:String, type:T.Type, complete: @escaping (Result<T, ApiError>) -> Void) {
        let url = URL(string: "\(baseURL)\(endpoint)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        self.fetch(type: T.self, with: request, completion: complete)
    }
    
    func deleteMethod<T: Decodable>(endpoint:String, type:T.Type, complete: @escaping (Result<T, ApiError>) -> Void) {
        let url = URL(string: "\(baseURL)\(endpoint)")
        var request = URLRequest(url: url!)
        request.httpMethod = "DELETE"
        
        self.fetch(type: T.self, with: request, completion: complete)
    }
    
    func postMethod<T: Decodable>(endpoint:String, body: [String: Any]?, complete: @escaping (Result<T, ApiError>) -> Void) {
        let url = URL(string: "\(baseURL)\(endpoint)")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = requestBodyFrom(params: body)
        
        self.fetch(type: T.self, with: request, completion: complete)
    }
    
    func putMethod<T: Decodable>(endpoint:String, body: [String: Any]?, complete: @escaping (Result<T, ApiError>) -> Void) {
        let url = URL(string: "\(baseURL)\(endpoint)")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = requestBodyFrom(params: body)
        
        self.fetch(type: T.self, with: request, completion: complete)
    }
    
    private func requestBodyFrom(params: [String: Any]?) -> Data? {
        guard let params = params else { return nil }
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return nil
        }
        return httpBody
    }}
