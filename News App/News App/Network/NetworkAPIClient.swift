//
// NetworkService.swift
//  News App
//
//  Created by Jigar Shethia on 29/03/24.

import Foundation
import UIKit

protocol NetworkService {
    @discardableResult
    func dataRequest<T: Decodable>(_ endPoint: APIEndPoint, objectType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) -> URLSessionDataTask
}

final class NetworkAPIClient: NetworkService {

    private let session: URLSession

    static var defaultSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        return URLSession(configuration: configuration)
    }()

    init(session: URLSession = NetworkAPIClient.defaultSession) {
        self.session = session
    }

    //MARK: DataRequest
    @discardableResult
    func dataRequest<T: Decodable>(_ endPoint: APIEndPoint, objectType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) -> URLSessionDataTask {
        
        var request: URLRequest
        do {
            request = try endPoint.asURLRequest()
        } catch {
            completion(.failure(error as! NetworkError))
            return URLSessionDataTask()
        }
    
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error as NSError?, error.domain == NSURLErrorDomain {
                completion(Result.failure(NetworkError.apiError(error)))
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(Result.failure(NetworkError.emptyData))
                return
            }
            guard response.statusCode == 200 else {
                completion(Result.failure(NetworkError.invalidStatusCode(response.statusCode)))
                return
            }
            
            self.printJSON(data: data)
            
            do {
                let jsonObject = try JSONDecoder().decode(objectType, from: data)
                completion(Result.success(jsonObject))
            } catch {
                completion(Result.failure(NetworkError.decodingError(error as! DecodingError)))
            }
        }
        dataTask.resume()
        return dataTask
    }
  
}


extension NetworkAPIClient {
    func printJSON(data: Data) {
        let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        let string = String.init(data: jsonData, encoding: .utf8)
        print(string ?? "NIL")
    }
}
