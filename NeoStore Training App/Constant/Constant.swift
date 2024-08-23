import Foundation
import MapKit
import CoreLocation
//MARK: - UserDefault forKey
struct UserDefaultKey {
    static let accessToken = "accessToken"
    static let profileImage = "profileImage"
    static let firstName = "firstName"
    static let lastName = "lastName"
    static let email = "email"
    static let totalCarts = "totalCarts"
    static let password = "password"
    static let savedAddresses = "savedAddresses"

}

//MARK: - UINib name
struct NibName {
    static let ImageSliderCollectionViewCell = "ImageSliderCollectionViewCell"
    static let SideMenuTableViewCell = "SideMenuTableViewCell"
    static let ProductListingTableViewCell = "ProductListingTableViewCell"
    static let MyCartTableViewCell = "MyCartTableViewCell"
    static let AddressListTableViewCell = "AddressListTableViewCell"
    static let OrderListTableViewCell = "OrderListTableViewCell"
    static let OrderDetailTableViewCell = "OrderDetailTableViewCell"
    static let StoreLocationTableViewCell = "StoreLocationTableViewCell"
    
}

//MARK: - Identifier
struct Identifier {
    static let ImageSliderCell = "ImageSliderCell"
    static let SideMenuCell = "SideMenuCell"
    static let ProductListViewController = "ProductListViewController"
    static let MyCartViewController = "MyCartViewController"
    static let AccountViewController = "AccountViewController"
    static let StoreLocationViewController = "StoreLocationViewController"
    static let OrderListViewController = "OrderListViewController"
    static let HomeViewController = "HomeViewController"
    static let ForgetPasswordViewController = "ForgetPasswordViewController"
    static let RegisterViewController = "RegisterViewController"
    static let LoginViewController = "LoginViewController"
    static let ProductListingTableViewCell = "ProductListingTableViewCell"
    static let RatingPopUpViewController = "RatingPopUpViewController"
    static let EnterQuantityViewController = "EnterQuantityViewController"
    static let ProductDetailsViewController = "ProductDetailsViewController"
    static let MyCartTableViewCell = "MyCartTableViewCell"
    static let AddressListViewController = "AddressListViewController"
    static let AddressListTableViewCell = "AddressListTableViewCell"
    static let AddAddressViewController = "AddAddressViewController"
    static let OrderListTableViewCell = "OrderListTableViewCell"
    static let OrderDetailsViewController = "OrderDetailsViewController"
    static let OrderDetailTableViewCell = "OrderDetailTableViewCell"
    static let UpdateAccountViewController = "UpdateAccountViewController"
    static let ResetPasswordViewController = "ResetPasswordViewController"
    static let StoreLocationTableViewCell = "StoreLocationTableViewCell"
    static let StoreLocationPin = "StoreLocationPin"
    
}

//MARK: - Title
struct Title {
    static let NeoStore = "NeoStore"
    static let Tables = "Tables"
    static let Chairs = "Chairs"
    static let Cupboards = "Cupboards"
    static let Sofas = "Sofas"
    static let AddressList = "Address List"
    static let OpenInMaps = "Open in Maps"
    static let CalculateDistance = "Calculate Distance"
    static let Distance = "Distance"
    static let ok = "OK"
    static let Cancel = "Cancel"
    
}

//MARK: - Array
struct Arrays{
    static let arrSideMenuLabel = ["MyCart","Tables","Sofas","Chairs","Cupboard","My Account","Store Location","My Order","Logout"]
    static let arrSideMenuImg = ["shoppingcart_icon","tables_icon","sofa_icon","chair_icon","cupboard_icon","username_icon","storelocator_icon","myorders_icon","logout_icon"]
    static let ProductImages = ["slider_img1", "slider_img2", "slider_img3", "slider_img4"]
    static let storeLocations =  [
        StoreLocation(name: "Neosoft Dadar", address: "Office No. 32, Palai Plaza, 1st Floor, Near Dadar Railway Station, Mumbai, Maharashtra 400028, India", coordinate: CLLocationCoordinate2D(latitude: 19.0183, longitude: 72.8443)),
        StoreLocation(name: "Neosoft Parel", address: "Office No. 201, 2nd Floor, Elphinstone House, Parel, Mumbai, Maharashtra 400012, India", coordinate: CLLocationCoordinate2D(latitude: 19.0051, longitude: 72.8418)),
        StoreLocation(name: "Neosoft Rabale", address: "Office No. 401, 4th Floor, Technocity IT Park, Rabale, Navi Mumbai, Maharashtra 400701, India", coordinate: CLLocationCoordinate2D(latitude: 19.1551, longitude: 73.0083)),
        StoreLocation(name: "Neosoft Pune", address: "Office No. 201, 2nd Floor, Pride Purple Accord, Baner Road, Pune, Maharashtra 411045, India", coordinate: CLLocationCoordinate2D(latitude: 18.5527, longitude: 73.8055)),
        StoreLocation(name: "Neosoft Hyderabad", address: "Office No. 401, 4th Floor, Cyber Heights, Hi-Tech City, Hyderabad, Telangana 500081, India", coordinate: CLLocationCoordinate2D(latitude: 17.4483, longitude: 78.3915)),
        StoreLocation(name: "Neosoft USA", address: "1234 Elm St, Dallas, TX 75201, USA", coordinate: CLLocationCoordinate2D(latitude: 32.7767, longitude: -96.7970)),
        StoreLocation(name: "Neosoft UAE", address: "789 Oak St, Dubai, UAE", coordinate: CLLocationCoordinate2D(latitude: 25.2048, longitude: 55.2708)),
        StoreLocation(name: "Neosoft UK", address: "15 King's Rd, London SW19 8PL, United Kingdom", coordinate: CLLocationCoordinate2D(latitude: 51.5074, longitude: -0.1278)),
        StoreLocation(name: "Neosoft Australia", address: "456 Maple St, Sydney NSW 2000, Australia", coordinate: CLLocationCoordinate2D(latitude: -33.8688, longitude: 151.2093))
    ]
}

//MARK: - ShowAlert Message
struct AlertMessage {
    static let LoginSuccessful = "Login Successful"
    static let LoginFailed = "Login Failed: "
    static let AllFieldsAreRequired = "All Fields are required"
    static let RegistrationSuccessful = "Registration successful: "
    static let RegistrationFailed = "Registration failed: "
    static let ProductAddedToCart = "Product Added To Cart: "
    static let ProductfailedAddedToCartPleaseTryAgain = "Product failed Added To Cart, Please Try! Again: "
    static let RatingSuccessful = "Rating successful: "
    static let RatingFailed = "Rating failed: "
    static let NoAddressSelected = "No address selected"
    static let AccountFailed = "Account failed: "
    static let FillAllDetails = "Fill All Details"
    static let UpdateSuccessfully = "Update Successfully: "
    static let UpdateFailed = "Update Failed: "
    
    
}

//MARK: - Images
struct Images {
    static let usernameIcon = "username_icon"
    static let passwordIcon = "password_icon"
    static let checkmarkSquareFill = "checkmark.square.fill"
    static let square = "square"
    static let circleFill = "circle.fill"
    static let circle = "circle"
    static let emailIcon = "email_icon"
    static let cpasswordIcon = "cpassword_icon"
    static let cellphoneIcon =  "cellphone_icon"
    static let houseFill =  "house.fill"
    static let cartFill =  "cart.fill"
    static let starCheck =  "star_check"
    static let starUnchek =  "star_unchek"
    static let plus =  "plus"
    static let circleInsetFilled =  "circle.inset.filled"
    
    
}

//MARK: - Placeholder Text
struct PlaceholderText {
    static let UserName = "User Name"
    static let Password = "Password"
    static let FirstName = "First Name"
    static let LirstName = "Lirst Name"
    static let Email = "Email"
    static let ConfirmPassword = "Confirm Password"
    static let PhoneNumber = "Phone Number"
    static let OldPassword = "Old Password"
    static let NewPassword = "New Password"
    
}

//MARK: - Text
struct Texts {
    static let EmptyString = ""
    static let CategoryTables = "Category- Tables"
    static let CategoryChairs = "Category- Chairs"
    static let CategorySofas = "Category- Sofas"
    static let CategoryCupboard = "Category- Cupboard"
    static let ProductData = "Product Data: "
    static let FutureFurnitureCenter = "Future Furniture Center"
    static let Error = "Error: "
    static let FailedToFetchCartItems = "Failed to fetch cart items: "
    static let Total = "Total: "
    static let FailedToEditCartItem = "Failed to edit cart item: "
    static let FailedToDeleteCartItem = "Failed to delete cart item: "
    static let OrderDate = "Order Date: "
    static let OrderID = "Order ID: "
    static let Qty = "Qty : "
    static let Tables = "(Tables)"
    static let Sofas = "(Sofas)"
    static let Chairs = "(Chairs)"
    static let Cupboards = "(Cupboards)"
    static let DataNotPostError = "Data not post error: "
    
}
