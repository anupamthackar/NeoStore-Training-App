import Foundation

class ResetPasswordViewModel {
    
    var resetPasswordResponse: ResetPasswordResponse?
    
    func postResetPassword(with request: ResetPasswordRequest, completion: @escaping (Result<ResetPasswordResponse, Error>) -> Void){
        
        APIManager.shared.request(
            endpoint: EndPointItems.changePassword,
            modeltype: ResetPasswordResponse.self,
            parameters: request) { response in
                switch response {
                case .success(let success):
                    self.resetPasswordResponse = success
                case .failure(let failure):
                    print(Texts.Error + "\(failure)")
                }
            }
    }
}
