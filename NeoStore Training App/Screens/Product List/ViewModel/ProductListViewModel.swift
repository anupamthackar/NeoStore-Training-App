import Foundation
import Alamofire

class ProductListViewModel {

    var products: ProductResponse?
    
    func fetchProducts(req: ProductRequest, categoryId: Int, completion: @escaping ((String?) -> Void)) {
        APIManager.shared.request(
            endpoint: EndPointItems.getProducts(categoryId),
            modeltype: ProductResponse.self ,
            parameters: req) { response in
            switch response {
            case .success(let response):
                self.products = response
                completion(nil)
            case .failure(let error):
                completion(error.localizedDescription)
            }
        }
    }
}
