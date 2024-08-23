import Foundation


class AddressListViewModel {
    
    var addressResponce: AddressResponse?
    
    func AddressPost(with request: AddressRequest, completion: @escaping (Result<AddressResponse, Error>) -> Void) {
        APIManager.shared.request(
            endpoint: EndPointItems.order,
            modeltype: AddressResponse.self,
            parameters: request) { result in
                switch result {
                case .success(let response):
                    self.addressResponce = response
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
