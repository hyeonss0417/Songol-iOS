
import UIKit

class DeliveryChildDetailViewController: UIViewController {

    var deliveryInfo : DeliveryFoodModel?
    
    @IBOutlet weak var btnOrder: UIButton!
    
    @IBOutlet weak var imageMenu: UIImageView!
    
    @IBOutlet weak var labelSTime: UILabel!
    
    @IBOutlet weak var labelAverage: UILabel!

    private var avgTaste:Double?
    private var avgSpeed: Double?
    
    @IBAction func OrderBtnOnClicked(_ sender: Any) {
    }
    
    @IBAction func CommentsBtnOnClicked(_ sender: Any) {
        
    }
    
    func setDeliveryInfo(deliveryInfo : DeliveryFoodModel){
        self.deliveryInfo = deliveryInfo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
    }
    
    func initView(){
        
        self.title = deliveryInfo?.foodName
        
        URLImageDownloading().downloadImage(from: URL(string: (deliveryInfo?.imgMenu_url)!)!, imageView: imageMenu)
        
        imageMenu.isUserInteractionEnabled = true
        
        imageMenu.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("buttonTapped")))
        
        labelSTime.text = deliveryInfo?.s_time
        
        print("---", deliveryInfo?.avg_tasteScore)
        
        avgTaste = Double(deliveryInfo?.avg_tasteScore as! String)
        avgSpeed = Double(deliveryInfo?.avg_speedScore as! String)
        // null value
        
        btnOrder.setTitle(deliveryInfo?.number, for: .normal)

    }
    
    @objc func buttonTapped() {
          performSegue(withIdentifier: "imageZoom", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageZoom" {
            if let destinationVC = segue.destination as? ImageZoomViewController {
                destinationVC.setImageUrl(url: (deliveryInfo?.imgMenu_url)!)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
