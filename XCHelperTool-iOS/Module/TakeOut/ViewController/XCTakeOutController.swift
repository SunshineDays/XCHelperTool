//
//  XCTakeOutController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/28.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

class XCTakeOutController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private lazy var sectionTitleView: JXCategoryTitleView = {
        let view = JXCategoryTitleView(frame: CGRect(x: 0, y: kNavigationHeight, width: kScreenWidth, height: 50))
        view.backgroundColor = UIColor(hex: 0xF2F2F2)
        view.titles = ["超级大IP", "热门HOT", "周边衍生", "影视综", "游戏集锦", "搞笑百事"]
        view.delegate = self
        return view
    }()
    
    private lazy var sectionTitleCopyView: JXCategoryTitleView = {
        let view = JXCategoryTitleView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 50))
        view.backgroundColor = UIColor(hex: 0xF2F2F2)
        view.titles = ["超级大IP", "热门HOT", "周边衍生", "影视综", "游戏集锦", "搞笑百事"]
        view.delegate = self
        return view
    }()
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (kScreenWidth - 20 * 5) / 4, height: 50)
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        flowLayout.minimumLineSpacing = 20
        flowLayout.scrollDirection = .vertical
        /// sectionHeader悬浮
//        flowLayout.sectionHeadersPinToVisibleBounds = true
        return flowLayout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(sectionTitleView)
        initCollectionView()
        collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension XCTakeOutController {
    private func initCollectionView() {
        collectionView.collectionViewLayout = flowLayout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(R.nib.xcTakeOuteCell)
        collectionView.register(XCTakeOutSearchTitleView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "categoryHeader")
        collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "sectionHeader")
    }
}

extension XCTakeOutController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.xcTakeOuteCell, for: indexPath)!
        cell.backgroundColor = UIColor.blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let categoryView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "sectionHeader", for: indexPath)
            for subview in categoryView.subviews {
                subview.removeFromSuperview()
            }
            if indexPath.section == 0 {
                categoryView.addSubview(sectionTitleCopyView)
            } else {
                let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 50))
                view.backgroundColor = UIColor.yellow
                let button = UIButton(frame: CGRect(x: 30, y: 10, width: 30, height: 30))
                button.backgroundColor = UIColor.red
                button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                view.addSubview(button)
                categoryView.addSubview(view)
            }
            return categoryView
        } else {
            return UICollectionReusableView()
        }
    }
    
    @objc private func buttonAction() {
        MBProgressHUD.show(info: "41234124  ")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            sectionTitleView.isHidden = false
        } else {
            sectionTitleView.isHidden = true
        }

        let indexPaths =  collectionView.indexPathsForVisibleSupplementaryElements(ofKind: UICollectionView.elementKindSectionHeader)
        if let max = indexPaths.min(by: { $0.section < $1.section }) {
            sectionTitleView.selectItem(with: UInt(max.section))
            sectionTitleCopyView.selectItem(with: UInt(max.section))
        }
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollViewDidEndScroll(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScroll(scrollView)
    }
    
    private func scrollViewDidEndScroll(_ scrollView: UIScrollView) {

    }
    
}

extension XCTakeOutController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: section == 0 ? 50 : 50)
    }
}

extension XCTakeOutController: JXCategoryViewDelegate {
    func categoryView(_ categoryView: JXCategoryBaseView!, didClickSelectedItemAt index: Int) {
        collectionView.scrollToItem(at: IndexPath(row: 0, section: index), at: .top, animated: true)
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
//            self.collectionView.scrollRectToVisible(CGRect(x: 0, y: self.collectionView.contentOffset.y - 70, width: self.collectionView.frame.width, height: self.collectionView.frame.height), animated: true)
//
//        }
    }
}
