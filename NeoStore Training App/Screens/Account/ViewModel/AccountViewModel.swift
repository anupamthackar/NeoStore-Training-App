import Foundation


class AccountViewModel {
    
    var accountResponse: AccountResponse?
    
    func fetchAccount(completion: @escaping ((Result<AccountResponse, Error>) -> Void)) {
        
        APIManager.shared.request(
            endpoint: EndPointItems.getAccount,
            modeltype: AccountResponse.self,
            parameters: EmptyModel()) { response in
                
                switch response {
                case .success(let response):
                    self.accountResponse = response
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
