//
//  APIService.swift
//  Home Care
//
//  Created by Mohamed Aglan on 5/23/21.
//

import Foundation
import Alamofire

class ApiService {

    static func getData(studentText: String, professorText: String, complition : @escaping (Result<Similarity,AFError>) -> Void) {
        AF.request(APIRouter.fetchData(studentText: studentText, professorText: professorText)).responseDecodable {  (response : DataResponse<Similarity, AFError>) in
            complition(response.result)
        }
        
 
        
        
        
        
//
//        guard let url = URL(string: "https://text-sim-api.herokuapp.com") else {
//                return
//            }
//
//            let data : Data = "query=\(studentText)&secondquery=\(professorText)".data(using: .utf8)!
//            var request : URLRequest = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type");
//            request.httpBody = data
//
//
//            let config = URLSessionConfiguration.default
//            let session = URLSession(configuration: config)
//            // vs let session = URLSession.shared
//              // make the request
//            let task = session.dataTask(with: request, completionHandler: {
//                (data, response, error) in
//
//                 if let error = error
//                {
//                    print(error)
//                }
//                else if let data = data
//                 {
//                    print("here in data")
//                    print(data)
//                }
//
//                DispatchQueue.main.async { // Correct
//
//                    guard let responseData = data else {
//                        print("Error: did not receive data")
//                        return
//                    }
//
//                    let decoder = JSONDecoder()
//                    print(String(data: responseData, encoding: .utf8))
//                    do {
//                      //  let todo = try decoder.decode(T.self, from: responseData)
//                      //  NSAssertionHandler(.success(todo))
//                    } catch {
//                        print("error trying to convert data to JSON")
//                        //print(error)
//                      //  NSAssertionHandler(.failure(error))
//                    }
//                }
//            })
//            task.resume()
//

        
    }
    
    static func getKeyWords(studentText: String, complition : @escaping (Result<KeyWords,AFError>) -> Void) {
        AF.request(APIRouter.keyWords(studentData: studentText)).responseDecodable {  (response : DataResponse<KeyWords, AFError>) in
            complition(response.result)
        }
    }
    
    
    
    
    
    

   

}
