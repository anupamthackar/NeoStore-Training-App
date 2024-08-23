import UIKit

class OrderListViewController: UIViewController {
    
    @IBOutlet weak var orderListTableView: UITableView!
    
    private let viewModel = OrderListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderTableConfig()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    func orderTableConfig(){
        orderListTableView.dataSource = self
        orderListTableView.delegate = self
        orderListTableView.register(UINib(nibName: NibName.OrderListTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.OrderListTableViewCell)
    }
    
    func fetchData(){
        viewModel.fetchOrderList { [weak self] result in
            switch result {
            case .success(let response):
                print(response)
                DispatchQueue.main.async{
                    self?.orderListTableView.reloadData()
                }
            case .failure(let error):
                print(Texts.FailedToFetchCartItems + error.localizedDescription)
            }
        }
    }
}

extension OrderListViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.orderListResponse?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderListTableView.dequeueReusableCell(withIdentifier: Identifier.OrderListTableViewCell) as? OrderListTableViewCell
        
        guard let data = viewModel.orderListResponse?.data else { return UITableViewCell() }
        
        cell?.orderCostLabel.text = "₹\(data[indexPath.row].cost)"
        cell?.orderDateLabel.text = Texts.OrderDate + "\(data[indexPath.row].created)"
        cell?.orderIdLabel.text = Texts.OrderID + "\(data[indexPath.row].id)"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cost = viewModel.orderListResponse?.data[indexPath.row].cost else { return }
        let orderDetailsVC = self.storyboard?.instantiateViewController(identifier: Identifier.OrderDetailsViewController) as? OrderDetailsViewController
        orderDetailsVC?.navigationItem.title = Texts.OrderID + "\(viewModel.orderListResponse?.data[indexPath.row].id ?? 0)"
        orderDetailsVC?.orderID = viewModel.orderListResponse?.data[indexPath.row].id ?? 0
        orderDetailsVC?.cost = "₹\(cost)"
        self.navigationController?.pushViewController(orderDetailsVC!, animated: true)
    }
}
