import UIKit

final class CardCell: UICollectionViewCell {
  
  @IBOutlet weak var mainImage: UIImageView!
  @IBOutlet weak var rewardProgress: UIProgressView!
  @IBOutlet weak var persentLabel: UILabel!
  @IBOutlet weak var rewardLabel: UILabel!
  @IBOutlet weak var dayLabel: UILabel!
  @IBOutlet weak var prodectLabel: UILabel!
  @IBOutlet weak var brandLabel: UILabel!
  @IBOutlet weak var proLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.rewardProgress.progressTintColor = UIColor(red: 92/255.0, green: 201/255.0, blue: 165/255.0, alpha: 1)
    }
}
