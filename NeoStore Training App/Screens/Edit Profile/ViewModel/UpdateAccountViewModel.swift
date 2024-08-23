import Foundation

class UpdateAccountViewModel {
    var updateAccountResponse: UpdateAccountResponse?
    func postUpdateAccountData(with request: UpdateAccountRequest, completion: @escaping (Result<UpdateAccountResponse, Error>) -> Void){
        APIManager.shared.request(
            endpoint: EndPointItems.updateAccount,
            modeltype: UpdateAccountResponse.self,
            parameters: request) { result in
                switch result {
                case .success(let data):
                    self.updateAccountResponse = data
                case .failure(let error):
                    print(Texts.DataNotPostError + "\(error) ")
                }
            }
    }
}
