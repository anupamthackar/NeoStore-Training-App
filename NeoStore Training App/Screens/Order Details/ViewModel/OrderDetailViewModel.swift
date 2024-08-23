import Foundation

class OrderDetailViewModel {
    
    var orderDetailsResponse: OrderDetailsResponse?
    
    func fetchOrderDetail(
        request: OrderdetailRequest,
        
        completion: @escaping((String?) -> Void)) {
            
            APIManager.shared.request(
                endpoint: EndPointItems.orderDetail,
                modeltype: OrderDetailsResponse.self,
                parameters: request) { response in
                    switch response {
                    case .success(let response):
                        self.orderDetailsResponse = response
                        completion(nil)
                    case .failure(let error):
                        completion(error.localizedDescription)
                    }
                }
        }
}
