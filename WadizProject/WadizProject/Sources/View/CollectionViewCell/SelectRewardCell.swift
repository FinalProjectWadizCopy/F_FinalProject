import UIKit

final class SelectRewardCell: UICollectionViewCell {
    var quantity = 0
    @IBOutlet weak var selectRewardBtn: UIButton!
    @IBOutlet weak var fundingPay: UILabel!
    @IBOutlet weak var productType: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productResource: UILabel!
    @IBOutlet weak var rewardDeliveryPay: UILabel!
    @IBOutlet weak var rewardDays: UILabel!
    @IBOutlet weak var productQuantity: UITextField!
    @IBAction func button(_ sender: UIButton) {
        sender.setImage(UIImage(named: "noneChecked"), for: .normal)
    }
    
    @IBAction func addButton(_ sender: UIButton) {
        quantity = quantity + 1
        productQuantity.text = "\(quantity)"
    }
    @IBAction func subButton(_ sender: UIButton) {
        quantity = quantity - 1
        if quantity < 0{
            quantity = 0
        }
        productQuantity.text = "\(quantity)"
    }
    override func awakeFromNib() {        
        
    }
}
