
import Foundation
import UIKit

private let detailCellIdentifier = "DetailCellId"
private let descriptionCellIdentifier = "DescriptionCellId"
private let reviewCellIdentifier = "ReviewCellId"

class YogaViewController: UICollectionViewController {
    private let padding: CGFloat = 10
    private var yogaHeaderView: YogaHeaderView?
    
    // MARK: - ViewLife Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        self.setupCollectionViewLayout()
        self.setupCollectionViewCell()
    }
    
    // Set Collection Inset's
    private func setupCollectionViewLayout() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = .init(top: self.padding, left: self.padding, bottom: self.padding, right: self.padding)
        }
    }
    
    // Register HeaderXib
    private func setupCollectionView() {
        self.collectionView.contentInsetAdjustmentBehavior = .never
        self.collectionView.showsVerticalScrollIndicator = false
        let headerNib = UINib.init(nibName: YogaHeaderView.nibName, bundle: Bundle(for: YogaHeaderView.self))
        self.collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: YogaHeaderView.identifier)
    }
    
    private func setupCollectionViewCell() {
        self.collectionView.register(UINib(nibName: "DetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: detailCellIdentifier)
        self.collectionView.register(UINib(nibName: "DescriptionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: descriptionCellIdentifier)
        self.collectionView.register(UINib(nibName: "ReviewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reviewCellIdentifier)
    }
    
    // Manage Blur effect on scrolling
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        guard let unwrapeHeader = self.yogaHeaderView else { return }
        if contentOffsetY > 0 {
            unwrapeHeader.animator.fractionComplete = 0
            return
        }
        unwrapeHeader.animator.fractionComplete = abs(contentOffsetY) / 100
    }
    
    // Change Status bar color dark to light
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func getCellItemHeight(rowId: Int) -> CGFloat {
        if (rowId == 0) {
            return 192
        }
        else if (rowId == 1) {
            return 110
        }
        else {
            return 70
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout -

extension YogaViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = self.getCellItemHeight(rowId: indexPath.row)
        let width = (collectionView.frame.width - (2 * padding))
        return .init(width: width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return .init(width: view.frame.width, height: 340)
    }
}

// MARK: UICollectionViewDataSource

extension YogaViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        self.yogaHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: YogaHeaderView.identifier, for: indexPath) as? YogaHeaderView
        
        return self.yogaHeaderView!
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.row == 0) {
            let detailCell: DetailCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellIdentifier, for: indexPath) as! DetailCollectionViewCell
            return detailCell
        }
        else if (indexPath.row == 1) {
            let descriptionCell: DescriptionCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: descriptionCellIdentifier, for: indexPath) as! DescriptionCollectionViewCell
            return descriptionCell
        }
        else if (indexPath.row == 2) {
            let reviewCell: ReviewCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellIdentifier, for: indexPath) as! ReviewCollectionViewCell
            return reviewCell
        }
        return UICollectionViewCell()
    }
}
