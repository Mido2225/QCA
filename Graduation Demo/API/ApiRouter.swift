//
//  ApiRouter.swift
//  Home Care
//
//  Created by Mohamed Aglan on 6/3/21.
//

import Foundation
import Alamofire

enum APIRouter : URLRequestConvertible {
    
    case fetchData(studentText: String, professorText: String)
    case keyWords(studentData: String)
    
    // MARK: - HTTPMethod

    private var Methods : HTTPMethod {
        switch self {
        case .fetchData:
            return .post
            
        case .keyWords:
            return .post
        }
    }
    private var Paths : String {
        switch self {
        case .fetchData:
            return "https://text-sim-api.herokuapp.com"
        case .keyWords:
            return "https://keyword-ext.herokuapp.com/api/keywords"
        }
    }
    
    private var headers : HTTPHeaders {
        switch self {
        case .fetchData:
            return ["Content-Type":"application/x-www-form-urlencoded"
            ]
        case .keyWords:
            return ["Content-Type":"application/x-www-form-urlencoded"]
        }
    }
    private var parameters :Parameters? {
        switch self {
        case .fetchData(let studentText,let professorText):
            return ["query":studentText,"secondquery":professorText]
            
        case .keyWords(let student):
            return ["query_string":student]
        }
    }
    
    
    
    
    func asURLRequest() throws -> URLRequest {
        switch self {
        case .fetchData,.keyWords:
            let url = "\(Constants.ProductionServer.baseURL)\(Paths)"
            let safeUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            var urlRequest = URLRequest(url: URL(string: safeUrl!)!)
            urlRequest.httpMethod = Methods.rawValue
            urlRequest.headers = headers
            if Methods.rawValue != "GET" || Methods.rawValue == "PUT"{
                if let parameters = parameters {
                    do {
                        var dataString:Data = Data()
                        if url.contains("/api/keywords"){
                            dataString = "query_string=\(parameters["query_string"] ?? "")".data(using: .utf8)!
                        }else{
                            dataString = "query=\(parameters["query"] ?? "")&secondquery=\(parameters["secondquery"] ?? "")".data(using: .utf8)!
                        }
                        
                        urlRequest.httpBody = dataString
                    }catch {
                        throw AFError.parameterEncodingFailed(reason:.jsonEncodingFailed(error: error))
                    }
                }
            }
            return urlRequest
        }
    }
    
}

