import UIKit

class UpdateAccountViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let viewModel = UpdateAccountViewModel()
    
    @IBOutlet weak var editProfileBtn: UIButton!
    @IBOutlet weak var updateAccountImage: UIImageView!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageSetUpdateAccountTextField()
        updateAccountImage.layer.cornerRadius = updateAccountImage.layer.frame.width / 2
        navigationItem.backButtonTitle = Texts.EmptyString
        
        // Load the saved profile image if available
        if let savedImageData = UserDefaults.standard.data(forKey: UserDefaultKey.profileImage),
           let savedImage = UIImage(data: savedImageData) {
            updateAccountImage.image = savedImage
        }
    }
    
    func postUpdateAccount() {
        guard let firstName = firstNameTextField.text, !firstName.isEmpty,
              let lastName = lastNameTextField.text, !lastName.isEmpty,
              let emailId = emailIdTextField.text, !emailId.isEmpty,
              let mobileNumber = mobileNumberTextField.text, !mobileNumber.isEmpty else {
            showAlert(message: AlertMessage.FillAllDetails)
            return
        }
        
        // Convert profile image to base64 string if available
        var profilePicBase64: String?
        if let profileImage = updateAccountImage.image,
           let imageData = profileImage.jpegData(compressionQuality: 0.8) {
            profilePicBase64 = imageData.base64EncodedString()
        }
        
        let updateAccountRequest = UpdateAccountRequest(
            first_name: firstName,
            last_name: lastName,
            email: emailId,
            dob: Texts.EmptyString,
            profile_pic: profilePicBase64 ?? Texts.EmptyString,
            phone_no: mobileNumber
        )
        
        viewModel.postUpdateAccountData(with: updateAccountRequest) { response in
            switch response {
            case .success(let message):
                self.showAlert(message: AlertMessage.UpdateSuccessfully + "\(message)")
            case .failure(let error):
                self.showAlert(message: AlertMessage.UpdateFailed + error.localizedDescription)
            }
        }
    }
    
    func ImageSetUpdateAccountTextField() {
        firstNameTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: Images.usernameIcon), placeholderName: PlaceholderText.FirstName)
        lastNameTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: Images.usernameIcon), placeholderName: PlaceholderText.LirstName)
        emailIdTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: Images.emailIcon), placeholderName: PlaceholderText.Email)
        mobileNumberTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: Images.cellphoneIcon), placeholderName: PlaceholderText.PhoneNumber)
        
        //MARK: Done Keyboard
        firstNameTextField.addDoneButtonOnKeyboard()
        lastNameTextField.addDoneButtonOnKeyboard()
        emailIdTextField.addDoneButtonOnKeyboard()
        mobileNumberTextField.addDoneButtonOnKeyboard()
    }
    
    @IBAction func accountUpdateSubmitActionBtn(_ sender: Any) {
        postUpdateAccount()
        let accountVC = AccountViewController()
        accountVC.account()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editProfileButtonTapped(_ sender: Any) {
        selectProfileImage()
    }
    
    // Function to present UIImagePickerController
    func selectProfileImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let selectedImage = info[.originalImage] as? UIImage {
            updateAccountImage.image = selectedImage
            
            // Save the image to UserDefaults
            if let imageData = selectedImage.jpegData(compressionQuality: 0.8) {
                UserDefaults.standard.set(imageData, forKey: UserDefaultKey.profileImage)
                
                // Post notification to update profile image in other views
                NotificationCenter.default.post(name: .profileImageUpdated, object: nil)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension Notification.Name {
    static let profileImageUpdated = Notification.Name("profileImageUpdated")
}
