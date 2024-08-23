import UIKit

class OrderDetailsViewController: UIViewController {
    
    @IBOutlet weak var orderTotalCostLabel: UILabel!
    @IBOutlet weak var orderDetailTableView: UITableView!
    var orderID: Int = 0
    var cost: String?
    private let viewModel = OrderDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.orderTotalCostLabel.text = cost
        orderDetailTableConfig()
        orderDetailFetchData()
    }
    
    func orderDetailTableConfig(){
        navigationItem.backButtonTitle = Texts.EmptyString
        orderDetailTableView.dataSource = self
        orderDetailTableView.delegate = self
        orderDetailTableView.register(UINib(nibName: NibName.OrderDetailTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.OrderDetailTableViewCell)
    }
    
    func orderDetailFetchData(){
        let req = OrderdetailRequest(orderId: orderID)
        viewModel.fetchOrderDetail(request: req) { error in
            if let error = error {
                print("Error: \(error)")
            } else {
                _ = self.viewModel.orderDetailsResponse?.data
                DispatchQueue.main.async{
                    self.orderDetailTableView.reloadData()
                }
            }
        }
    }
}

extension OrderDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.orderDetailsResponse?.data.orderDetails.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderDetailTableView.dequeueReusableCell(withIdentifier: Identifier.OrderDetailTableViewCell) as? OrderDetailTableViewCell
        
        guard let data = viewModel.orderDetailsResponse?.data.orderDetails else { return UITableViewCell() }
        cell?.orderProductImage.loadImage(from: data[indexPath.row].prodImage)
        cell?.orderProductName.text = "\(data[indexPath.row].prodName)"
        cell?.orderProductCost.text = "₹\(data[indexPath.row].total)"
        cell?.orderProductQuantity.text = Texts.Qty + "\(data[indexPath.row].quantity)"
        
        switch data[indexPath.row].productID {
        case 1:
            cell?.orderProductCategory.text = Texts.Tables
        case 2:
            cell?.orderProductCategory.text = Texts.Sofas
        case 3:
            cell?.orderProductCategory.text = Texts.Chairs
        case 4:
            cell?.orderProductCategory.text = Texts.Cupboards
        default:
            cell?.orderProductCategory.text = Texts.EmptyString
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
