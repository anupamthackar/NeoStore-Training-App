import Foundation
import Alamofire


class LoginViewModel: NSObject {
    
    var loginResponse: LogInResponse?
    
    func loginUser(with details: LoginRequest,completion: @escaping(Result<LogInResponse, Error>) -> Void) {
        
        APIManager.shared.request(endpoint: EndPointItems.login,
                                  modeltype: LogInResponse.self,
                                  parameters: details,
                                  headers: nil) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
                if let accesstoken = response.data?.accessToken{
                    UserDefaults.standard.set(accesstoken, forKey: UserDefaultKey.accessToken)
                    UserDefaults.standard.set(response.data?.firstName, forKey: UserDefaultKey.firstName)
                    UserDefaults.standard.set(response.data?.lastName, forKey: UserDefaultKey.lastName)
                    UserDefaults.standard.set(response.data?.email, forKey: UserDefaultKey.email)
                    print(accesstoken)
                }
        
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
