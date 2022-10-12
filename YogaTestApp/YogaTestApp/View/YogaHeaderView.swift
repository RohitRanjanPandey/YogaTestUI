
import UIKit

class YogaHeaderView: UICollectionReusableView {

    @IBOutlet var bannerImageView: UIImageView!
    @IBOutlet var ratingView: UIView!
    
    var animator: UIViewPropertyAnimator = UIViewPropertyAnimator.init(duration: 0.1, curve: .linear)

    override func awakeFromNib() {
        super.awakeFromNib()
        self.animateView()
    }
    
    func animateView() {
        let bannerInitialFrame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: 50)
        let bannerFinalFrame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: bannerImageView.frame.size.height)
        
        let ratingInitialFrame = CGRect(x: ratingView.center.x, y: ratingView.frame.origin.y, width: 10, height: ratingView.frame.size.height)
        let ratingFinalFrame = CGRect(x: ratingView.frame.origin.x, y: ratingView.frame.origin.y, width: ratingView.frame.size.width, height: ratingView.frame.size.height)
        
        self.bannerImageView.frame = bannerInitialFrame
        self.ratingView.frame = ratingInitialFrame
        UIView.animate(withDuration: 0.5) { [weak self] in
            self!.bannerImageView.frame = bannerFinalFrame
            self!.ratingView.frame = ratingFinalFrame
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.ratingView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 2.0, opacity: 0.35)
    }
}
