import Foundation

import Alamofire

class APIManager {
    // singleton instance
    static let shared = APIManager()
    private init(){}
    
    //MARK: Generic Request Method
    func request<T: Codable, U: Codable> (
        endpoint: EndPointType,
        modeltype: T.Type,    //ResponseModel
        parameters: U? = nil, //RequestModel
        headers: HTTPHeaders? = nil,
        completion: @escaping (Result<T, Error>) -> Void){
            
            let encoder =  URLEncodedFormParameterEncoder.default
            
            let headers: HTTPHeaders = ["access_token": UserDefaults.standard.string(forKey: "accessToken") ?? Texts.EmptyString]
            AF.request(endpoint.url!,
                       method: endpoint.method,
                       parameters: parameters,
                       encoder: encoder,
                       headers:  headers ).response {response in
                
                switch response.result {
                case .success(let data):
                    //MARK: edited
                    do {
                        guard let data else {return}
                        let jsonData = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(jsonData))
                    } catch(let error) {
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
                }
            }
        }
}
