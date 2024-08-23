import Foundation

class RatingViewModel {
    var ratingResponse: RatingResponse?
    
    func ratingPostData (
        with request: ratingRequest,
        completion: @escaping (Result<RatingResponse, Error>) -> Void) {
            
            APIManager.shared.request(
                endpoint: EndPointItems.setRating,
                modeltype: RatingResponse.self,
                parameters: request ) { result in
                    switch result {
                    case .success(let response):
                        completion(.success(response))
                        print(response)
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
}
