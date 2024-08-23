import Foundation


class OrderListViewModel {
    
    var orderListResponse: OrderListResponse?
    
    func fetchOrderList(completion: @escaping ((Result<OrderListResponse, Error>) -> Void)) {
        
        APIManager.shared.request(
            endpoint: EndPointItems.orderList,
            modeltype: OrderListResponse.self,
            parameters: EmptyModel()) { response in
                switch response {
                case .success(let response):
                    self.orderListResponse = response
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
