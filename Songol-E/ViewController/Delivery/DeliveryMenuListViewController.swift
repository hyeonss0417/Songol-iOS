
import UIKit
import Firebase
import FirebaseDatabase
import XLPagerTabStrip


class DeliveryMenuListViewController: UIViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.isHidden = true
        }
    }
    private let dialog = LoadingDialog()
    private var category: String?
    private var deliveryInfoToSend: DeliveryFoodModel?
    private var deliveryFoodArrays:[DeliveryFoodModel] = []
    
    func setCategory(category:String){
        self.category = category
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dialog.displaySpinner(on: self.view)
        readDeliveryList(category: category!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for row in tableView?.indexPathsForSelectedRows ?? [] {
            tableView?.deselectRow(at: row, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "deliveryDetail" {
            if let destinationVC = segue.destination as? DeliveryChildDetailViewController {
                destinationVC.setDeliveryInfo(deliveryInfo: deliveryInfoToSend!)
            }
        }
    }
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: category!)
    }
    
    func readDeliveryList(category:String){
        FBReference.shared.db.child("Delivery").child(category).observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children{
                let value = (child as! DataSnapshot).value as? NSDictionary
                
                let deliveryFoodModel = DeliveryFoodModel(foodName: value?["foodName"] as? String ?? "", avg_speedScore: value?["avg_speedScore"] as? String ?? "",avg_tasteScore: value?["avg_tasteScore"] as? String ?? "",imgLogo_url: value?["imgLogo_url"] as? String ?? "",imgMenu_url: value?["imgMenu_url"] as? String ?? "",number: value?["number"] as? String ?? "",s_time: value?["s_time"] as? String ?? "")
                
                self.deliveryFoodArrays.append(deliveryFoodModel)
            }
            
            DispatchQueue.main.async {
                self.dialog.removeSpinner()
                self.tableView.isHidden = false
                UIView.animate(withDuration: 0.3, animations: {
                    self.tableView.reloadSections(IndexSet(0...0), with: .automatic)
                })
            }
            
        }){ (error) in
            print(error.localizedDescription)
        }
    }
}

extension DeliveryMenuListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveryFoodArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DeliveryTableCell", for: indexPath) as? DeliveryTableViewCell else {
            return UITableViewCell()
        }
        
        cell.labelTitle.text = deliveryFoodArrays[indexPath.row].foodName
        cell.labelNumber.text = deliveryFoodArrays[indexPath.row].number
        cell.imageLogo.image = UIImage()
        cell.imageLogo.loadImageAsyc(fromURL: deliveryFoodArrays[indexPath.row].imgLogo_url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        deliveryInfoToSend = deliveryFoodArrays[indexPath.row]
//        performSegue(withIdentifier: "deliveryDetail", sender: nil)
        guard let target = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ImageZoomViewController.className) as? ImageZoomViewController else {
            return
        }
        
        target.setImageUrl(url: deliveryFoodArrays[indexPath.row].imgMenu_url)
        self.present(target, animated: true, completion: nil)
    }
}
