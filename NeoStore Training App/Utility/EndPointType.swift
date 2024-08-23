import Foundation
import Alamofire

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

protocol EndPointType {
    var path: String { get }
    var baseURL: String { get }
    var url: URL? { get }
    var method: HTTPMethod { get }
    
}

enum EndPointItems {
    case register
    case login
    case forgetPassword
    case getProducts(Int)
    case getProductDetails
    case setRating
    case addToCart
    case getCart
    case editCart
    case deleteCart
    case order
    case orderList
    case orderDetail
    case getAccount
    case updateAccount
    case changePassword
}

extension EndPointItems: EndPointType {
    var path: String {
        switch self {
        case .login:
            return "users/login"
        case .register:
            return "users/register"
        case .forgetPassword:
            return "users/forgot"
        case let .getProducts(categoryId):
            return "products/getList?product_category_id=\(categoryId)"
        case .getProductDetails:
            return "products/getDetail"
        case .setRating:
            return "products/setRating"
        case .addToCart:
            return "addToCart"
        case .editCart:
            return "editCart"
        case .deleteCart:
            return "deleteCart"
        case .getCart:
            return "cart"
        case .order:
            return "order"
        case .orderList:
            return "orderList"
        case .orderDetail:
            return "orderDetail"
        case .getAccount:
            return "users/getUserData"
        case .updateAccount:
            return "users/update"
        case .changePassword:
            return "users/change"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .register, .login, .forgetPassword, .setRating, .addToCart, .editCart, .deleteCart, .order, .updateAccount, .changePassword:
            return .post
        case .getProducts, .getProductDetails, .getCart, .orderList, .orderDetail, .getAccount:
            return .get
        }
    }
    
    var baseURL: String {
        return "http://staging.php-dev.in:8844/trainingapp/api/"
    }
    
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }
}



