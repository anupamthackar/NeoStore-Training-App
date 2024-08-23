import Foundation

class addToCartViewModel {
    func addToCartData(with request: AddToCartRequest ,completion: @escaping(Result<AddToCartResponse, Error>) -> Void) {
    
        APIManager.shared.request(
            endpoint: EndPointItems.addToCart,
            modeltype: AddToCartResponse.self,
            parameters: request ) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    let totalCarts = "\(data.totalCarts)"
                    UserDefaults.standard.set(totalCarts , forKey: UserDefaultKey.totalCarts)
                    print(UserDefaults.standard.set(totalCarts , forKey: UserDefaultKey.totalCarts))
                    print(data)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
