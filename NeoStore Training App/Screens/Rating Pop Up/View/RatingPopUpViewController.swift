import UIKit

class RatingPopUpViewController: UIViewController {
    
    var productNameRate: String?
    var productImageRate: String?
    var productId: Int?
    
    let ratingPopUpViewModel = RatingViewModel()
    
    @IBOutlet weak var backPopView: UIView!
    @IBOutlet weak var rateProductName: UILabel!
    @IBOutlet weak var rateProductImage: UIImageView!
    @IBOutlet weak var RatingView: UIView!
    
    // Create a variable in which we will store the current rating Int
    private var selectedRate: Int = 3
    
    // Adding a Selection feedback effect to clicking on a star
    private let feedbackGenerator = UISelectionFeedbackGenerator()
    
    //MARK:  User Interface
    
    private let container: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 70
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private lazy var starContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        //Adding TapGestureRecognizer to our stack of star to handle clicking on a star
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didSelectRate))
        stackView.addGestureRecognizer(tapGesture)
        
        return stackView
    }()
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createStars()
        setUpRate()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleAction))
        view.addGestureRecognizer(tapGesture)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backPopView.layer.cornerRadius = 10
    }
    
    //MARK: User action
    
    @IBAction func RateActionBtn(_ sender: Any) {
        postDataRating()
    }
    
    func postDataRating(){
        
        let ratingRequestData = ratingRequest(productId: productId!,
                                              rating: selectedRate)
        
        ratingPopUpViewModel.ratingPostData(with: ratingRequestData) { [weak self] result in
            switch result {
            case .success(let message):
                self?.showAlert(message: AlertMessage.RatingSuccessful + "\(message)", completion: {
                    self?.navigationController?.popViewController(animated: true)
                })
            case .failure(let error):
                self?.showAlert(message: AlertMessage.RatingFailed + error.localizedDescription)
            }
        }
    }
    
    @objc func didSelectRate(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: starContainer)
        let starWidth = starContainer.bounds.width / CGFloat(Constants.starsCount)
        let rate = Int(location.x / starWidth) + 1
        
        //If current star doesn't match selectedRate then we change our rating
        if rate != self.selectedRate {
            feedbackGenerator.selectionChanged()
            self.selectedRate = rate
        }
        
        //Loop through starsConntainer arrangedSubViews and
        //Loop for all subview of type UIImageView and change
        //Thier isHighlighted state (icon depend on it)
        
        starContainer.arrangedSubviews.forEach { subviews in
            guard let starImageView = subviews as? UIImageView else {
                return
            }
            starImageView.isHighlighted = starImageView.tag <= rate
            
        }
    }
    
    //MARK: Private Methods
    
    private func createStars() {
        for index in 1...Constants.starsCount {
            let star = makeStarIcon()
            star.tag = index
            starContainer.addArrangedSubview(star)
        }
    }
    
    private func makeStarIcon() -> UIImageView {
        let imageView = UIImageView(
            image: UIImage(named: Images.starUnchek),
            highlightedImage: UIImage(named: Images.starCheck))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    private func setUpRate() {
        RatingView.backgroundColor = .white
        
        RatingView.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.leftAnchor.constraint(equalTo: RatingView.leftAnchor, constant:
                                            Constants.containerHorizontalinsets).isActive = true
        container.rightAnchor.constraint(equalTo: RatingView.rightAnchor, constant:
                                            -Constants.containerHorizontalinsets).isActive = true
        container.centerYAnchor.constraint(equalTo: RatingView.centerYAnchor).isActive = true
        
        //StarsContainer
        starContainer.translatesAutoresizingMaskIntoConstraints = false
        starContainer.heightAnchor.constraint(equalToConstant: Constants.starContainerHeight).isActive = true
        
        //arrangedSubviews
        container.addArrangedSubview(starContainer)
        
        rateProductName.text = self.productNameRate
        self.rateProductImage.loadImage(from: productImageRate ?? Texts.EmptyString)
        
    }
    
    private struct Constants {
        static let starsCount: Int = 5
        static let containerHorizontalinsets: CGFloat = 20
        static let starContainerHeight: CGFloat = 40
    }
    
    @objc func handleAction() {
        dismiss(animated: true)
    }
}
