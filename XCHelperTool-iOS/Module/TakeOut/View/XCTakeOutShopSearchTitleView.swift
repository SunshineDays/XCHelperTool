//
//  XCTakeOutShopSearchTitleView.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/24.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

protocol XCTakeOutShopSearchTitleViewDelegate: class {
    func takeOuteSearchTitleView(_ view: XCTakeOutShopSearchTitleView, backButtonClick sender: UIButton)
    func takeOuteSearchTitleView(_ view: XCTakeOutShopSearchTitleView, searchButtonClick sender: UIButton)
    func takeOuteSearchTitleView(_ view: XCTakeOutShopSearchTitleView, loveButtonClick sender: UIButton)
    func takeOuteSearchTitleView(_ view: XCTakeOutShopSearchTitleView, moreButtonClick sender: UIButton)
    func takeOuteSearchTitleView(_ view: XCTakeOutShopSearchTitleView, searchBarTextDidBeginEditing searchBar: UISearchBar)
}

enum SearchBarSearchImageType {
    case white
    case gray
    case clear
    var image: UIImage? {
        switch self {
        case .white: return R.image.takeout_search_white()
        case .gray: return R.image.takeout_search_gray()
        case .clear: return UIColor.clear.convertToImage()
        }
    }
}

enum LoveButtonImageType  {
    case white
    case gray
    case yellow
    var image: UIImage? {
        switch self {
        case .white: return R.image.takeout_love_white()
        case .gray: return R.image.takeout_love_gray()
        case .yellow: return R.image.takeout_love_yellow()
        }
    }
}

enum SearchTitleViewImageColorType {
    case white
    case gray
    var backButtonImage: UIImage? {
        switch self {
        case .white: return R.image.takeout_back_white()
        case .gray: return R.image.takeout_back_gray()
        }
    }
    var moreButtonImage: UIImage? {
        switch self {
        case .white: return R.image.takeout_more_white()
        case .gray: return R.image.takeout_more_gray()
        }
    }
}

/// 外卖搜索框
class XCTakeOutShopSearchTitleView: UIView {
    
    @IBOutlet weak var backButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchBarLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var searchButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchButtonTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var loveButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    private var searchBarOriginFrame = CGRect()
    
    public weak var delegate: XCTakeOutShopSearchTitleViewDelegate?
    
    public var tableHeaderHeight: CGFloat = 120
    
    public var searchBarChangedX = CGFloat() {
        didSet {
            if searchBarChangedX <= 0 {
                setBackAndMoreButtonImage(.white)
                isShowSearchBar(false)
                searchButtonTrailingConstraint.constant = 15
                searchButton.isHidden = false
                setLoveButtonImage(.white)
                self.backgroundColor = UIColor.clear
            } else {
                var leading = searchBarOriginFrame.width - searchBarChangedX * (searchBarOriginFrame.width / tableHeaderHeight)
                if leading <= 0 {
                    leading = 0
                }
                self.backgroundColor = UIColor(hex: 0xFFFFFF, alpha: 1 - leading / searchBarOriginFrame.width)
                searchBarLeadingConstraint.constant = leading

                if leading > 20 {
                    isShowPlaceholder(false)
                } else {
                    isShowPlaceholder(true)
                }
                
                if searchBarChangedX > 5 {
                    isShowSearchBar(true)
                } else {
                    isShowSearchBar(false)
                }

                if leading > searchBarOriginFrame.width / 2 {
                    setSearchBarSerarchImage(.clear)
                } else if leading > 20 && leading < searchBarOriginFrame.width / 2 {
                    setSearchBarSerarchImage(.white)
                }
                else {
                    setSearchBarSerarchImage(.gray)
                }
                
                if leading > searchBarOriginFrame.width / 2 {
                    setBackAndMoreButtonImage(.white)
                    setLoveButtonImage(.white)
                } else {
                    setBackAndMoreButtonImage(.gray)
                    setLoveButtonImage(.gray)
                }
                
                searchButtonTrailingConstraint.constant = 10 + searchBarOriginFrame.width - 15 - leading
                if searchButtonTrailingConstraint.constant < 15 {
                    searchButtonTrailingConstraint.constant = 15
                }
                
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kNavigationHeight)
        backButtonTopConstraint.constant = kStatusBarHeight
        searchBar.delegate = self
        searchBar.backgroundColor(UIColor(hex: 0xF2F2F2))
        searchBar.layer.cornerRadius = searchBar.frame.height / 2
        searchBarOriginFrame = searchBar.frame
        isShowSearchBar(false)
        setSearchBarSerarchImage(.gray)
        setLoveButtonImage(.white)
    }
}

extension XCTakeOutShopSearchTitleView {
    
    @IBAction func goBackAction(_ sender: UIButton) {
        delegate?.takeOuteSearchTitleView(self, backButtonClick: sender)
    }
    
    @IBAction func searchAction(_ sender: UIButton) {
        delegate?.takeOuteSearchTitleView(self, searchButtonClick: sender)
    }
    
    @IBAction func loveAction(_ sender: UIButton) {
        delegate?.takeOuteSearchTitleView(self, loveButtonClick: sender)
    }
    
    @IBAction func moreAction(_ sender: UIButton) {
        delegate?.takeOuteSearchTitleView(self, moreButtonClick: sender)
    }
    
    private func setBackAndMoreButtonImage(_ type: SearchTitleViewImageColorType = .white) {
        backButton.setImage(type.backButtonImage, for: .normal)
        moreButton.setImage(type.moreButtonImage, for: .normal)
    }
    
    private func isShowSearchBar(_ isShow: Bool = false) {
        searchBar.isHidden = !isShow
        searchBar.isUserInteractionEnabled = isShow
        searchButton.isUserInteractionEnabled = !isShow
    }
    
    private func setSearchBarSerarchImage(_ type: SearchBarSearchImageType = .gray) {
        searchBar.setImage(type.image, for: .search, state: .normal)
        searchButton.isHidden = type != .clear
    }
    
    private func setLoveButtonImage(_ type: LoveButtonImageType = .white) {
        loveButton.setImage(type.image, for: .normal)
    }
    
    private func isShowPlaceholder(_ isShow: Bool = false) {
        if isShow {
            searchBar.placeholder("请输入商品名", color: UIColor.gray, font: 12)
        } else {
            searchBar.placeholder = nil
        }
    }
}

extension XCTakeOutShopSearchTitleView: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        delegate?.takeOuteSearchTitleView(self, searchBarTextDidBeginEditing: searchBar)
    }
}
