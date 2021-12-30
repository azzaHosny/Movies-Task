//
//  APICaller.swift
//  NetworkFramework
//
//  Created by azah on 12/30/21.
//

import Foundation
import RxSwift
import Alamofire

enum NetworkError: Error {
    case noInternet
    case failedRequest
}


public class APICaller<T> where T : Decodable {

   static func makeRequest(url: String, method: HTTPMethod, paramters: [String: Any], header: HTTPHeaders, encoding: ParameterEncoding = URLEncoding.default) -> Observable<T> {
        return Observable<T>.create{ observer in
            if !Connectivity.isConnectedToInternet() {
                observer.on(.error(NetworkError.noInternet))
            }
            let request = AF.request(url, method: method,
                                     parameters: paramters,
                                     encoding: encoding,
                                     headers: header,
                                     interceptor: nil, requestModifier: nil)
                
         
            request.response { httpResponse in
               if httpResponse.response?.statusCode == 200 {
                request.responseJSON(completionHandler: { response in
                    
                    do {
                        if let data = response.data {
                            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                            observer.on(.next(decodedResponse))
                        }
                        observer.on(.completed)
                    } catch let error as NSError {
                        observer.on(.error(error))
                    }
                })
               } else {
                    observer.onError(NetworkError.failedRequest)
               }
            }
            return AnonymousDisposable {
                request.cancel()
            }
        }
    }
}

class AnonymousDisposable : Disposable {
    private let disposeLogic :()->Void
    
    init(_ disposeLogic :@escaping ()->Void) {
        self.disposeLogic = disposeLogic
    }
    func dispose() {
        disposeLogic()
    }
}
