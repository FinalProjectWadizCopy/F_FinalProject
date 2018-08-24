import UIKit

protocol CardCellDelegate: class {
    func didLikeCancel()
}

final class CardCell: UICollectionViewCell {
    
    weak var delegate: CardCellDelegate?
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var rewardProgress: UIProgressView!
    @IBOutlet weak var persentLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var prodectLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var proLable: UILabel!
    @IBOutlet weak var likeImg: UIImageView!
    
    
    @IBAction func likeCancelButton(_ sender: UIButton) {
        delegate?.didLikeCancel()
    }
    
    @IBOutlet weak var OutletlikeCanCelButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.rewardProgress.progressTintColor = UIColor(red: 92/255.0, green: 201/255.0, blue: 165/255.0, alpha: 1)
        OutletlikeCanCelButton.layer.borderColor = UIColor.black.cgColor
        OutletlikeCanCelButton.layer.borderWidth = 1
    }
}
