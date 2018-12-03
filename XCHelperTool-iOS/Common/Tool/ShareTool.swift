//
//  XCOpenShareTool.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/5/31.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 分享
class ShareTool: NSObject {
   /// 分享
    public class func share(with model: ShareModel, from controller: UIViewController) {
        let view = XCShareView()
        let message = shareMessage(model: model)
        view.initWith(model: model) { (share) in
            switch share {
            case .weChatFriend:
                OpenShare.share(toWeixinSession: message, success: { (success) in
                    
                }) { (failure, error) in
                    
                }
            case .weChatCircle:
                OpenShare.share(toWeixinTimeline: message, success: { (success) in
                    
                }) { (failure, error) in
                    
                }
            case .qqFriend:
                OpenShare.share(toQQFriends: message, success: { (success) in
                    
                }) { (failure, error) in
                    
                }
            case .qqQzone:
                OpenShare.share(toQQZone: message, success: { (success) in
                    
                }) { (failure, error) in
                    
                }
            case .sinaWeibo:
                OpenShare.share(toWeibo: message, success: { (success) in
                    
                }) { (failure, error) in
                    
                }
            case .code:
                let vc = XCShareCodeController()
                vc.initWith(model: model)
                controller.present(vc, animated: true, completion: nil)
            case .safari:
                UIApplication.shared.open(URL(string: model.url)!, options: [UIApplication.OpenExternalURLOptionsKey(rawValue: ""): ""], completionHandler: nil)
            case .pastedboard:
                let pastedboard = UIPasteboard.general
                pastedboard.string = model.url
                MBProgressHUD.show(info: "已复制到剪切板")
            case .more:
                self.shareToActivityVC(model: model, controller: controller)
            }
        }
        UIApplication.shared.keyWindow?.addSubview(view)
    }
    
    /// 初始化数据
    private class func shareMessage(model: ShareModel) -> OSMessage {
        let message = OSMessage()
        message.title = model.title
        message.desc = model.desc
        message.image = model.logo.pngData()
        message.link = model.url
        return message
    }
    
    /// 系统分享
    private class func shareToActivityVC(model: ShareModel, controller: UIViewController) {
        let activityItems = [model.title, model.logo, URL(string: model.url)!] as [Any]
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        controller.present(activityVC, animated: true, completion: nil)
    }
    
}

/// 分享弹窗
class XCShareView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        self.backgroundColor = UIColor(hex: 0x000000, alpha: 0.4)
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func initWith(model: ShareModel, shareBlock: @escaping XCShareToAppBlock) {
        initData()
        shareToAppBlock = shareBlock
        initView()
        collectionView.reloadData()
        initAnimate()
    }
    
    typealias XCShareToAppBlock = (_ share: ShareApp) -> Void
    
    private var shareToAppBlock: XCShareToAppBlock?
    
    private var apps = [ShareApp]()
    
    /// 一行显示的个数
    private let rowNumber: CGFloat = 5
    
    private lazy var dismisButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: frame.height - shareView.frame.height))
        button.addTarget(self, action: #selector(dismissShareView), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareView: UIView = {
       let view = UIView(frame: CGRect(x: 0, y: kScreenHeight, width: kScreenWidth, height: kScreenWidth / rowNumber * 2 + 90))
        return view
    }()
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: kScreenWidth / rowNumber, height: kScreenWidth / rowNumber)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.scrollDirection = .vertical
        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenWidth / rowNumber * 2 + 40), collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(XCShareCell.classForCoder(), forCellWithReuseIdentifier: "XCShareCell")
        return collectionView
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: shareView.frame.height - 49, width: shareView.frame.width, height: 49))
        button.backgroundColor = UIColor.white
        button.setTitle("取消", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(dismissShareView), for: .touchUpInside)
        return button
    }()
    
    private lazy var whiteView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.cancelButton.frame.maxY, width: kScreenWidth, height: kBottomMargin))
        view.backgroundColor = UIColor.white
        return view
    }()
}

extension XCShareView {
    private func initData() {
        if OpenShare.isWeixinInstalled() {
            apps.append(.weChatFriend)
            apps.append(.weChatCircle)
        }
        if OpenShare.isQQInstalled() {
            apps.append(.qqFriend)
            apps.append(.qqQzone)
        }
        if OpenShare.isWeiboInstalled() {
            apps.append(.sinaWeibo)
        }
        apps.append(.code)
        apps.append(.safari)
        apps.append(.pastedboard)
        apps.append(.more)
    }
    
    private func initView() {
        addSubview(shareView)
        shareView.addSubview(collectionView)
        shareView.addSubview(cancelButton)
        shareView.addSubview(whiteView)
        addSubview(dismisButton)
    }
    
    private func initAnimate() {
        UIView.animate(withDuration: 0.3) {
            self.shareView.frame = CGRect(x: 0, y: self.frame.maxY - self.shareView.frame.height - kBottomMargin, width: self.frame.width, height: self.shareView.frame.height + kBottomMargin)
        }
    }
}

extension XCShareView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: XCShareCell = collectionView.dequeueReusableCell(withReuseIdentifier: "XCShareCell", for: indexPath) as! XCShareCell
        cell.configView(app: apps[indexPath.row])
        cell.backgroundButton.tag = indexPath.row
        cell.backgroundButton.addTarget(self, action: #selector(shareAction(_:)), for: .touchUpInside)
        return cell
    }
}

extension XCShareView {
    @objc private func dismissShareView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
    @objc private func shareAction(_ sender: UIButton) {
        shareToAppBlock!(apps[sender.tag])
        dismissShareView()
    }
}


/// 分享 UICollectionViewCell
class XCShareCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(backgroundButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configView(app: ShareApp) {
        titleLabel.text = app.rawValue
        iconImageView.image = app.shareImage
    }
    
    public lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: contentView.frame.width - 20, height: contentView.frame.width - 20))
        imageView.contentMode = .center
        return imageView
    }()
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: -10, y: iconImageView.frame.maxY, width: contentView.frame.width + 20, height: 15))
        label.textColor = UIColor(hex: 0x555555)
        label.font = UIFont.systemFont(ofSize: 11)
        label.textAlignment = .center
        return label
    }()
    
    public lazy var backgroundButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height))
        return button
    }()
    
}

/// 分享二维码
class XCShareCodeController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.theme
        view.addSubview(titleView)
        view.addSubview(codeImageView)
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(dismissAction))
        swipe.direction = .down
        view.addGestureRecognizer(swipe)
    }

    public func initWith(model: ShareModel) {
        self.model = model
    }
    
    private var model: ShareModel!
    
    private let codeImageWidth = kScreenWidth * 2 / 3
    
    private lazy var titleView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kNavigationHeight))
        view.backgroundColor = UIColor.theme
        let titleLabel = UILabel(frame: CGRect(x: kScreenWidth / 2 - 80, y: kStatusBarHeight, width: 160, height: 44))
        titleLabel.text = model.title
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 19, weight: UIFont.Weight(rawValue: 1))
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        let finishButton = UIButton(frame: CGRect(x: kScreenWidth - 60, y: kStatusBarHeight, width: 60, height: 44))
        finishButton.setTitle("完成", for: .normal)
        finishButton.setTitleColor(UIColor.white, for: .normal)
        finishButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        finishButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        view.addSubview(finishButton)
        return view
    }()
    
    private lazy var codeImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: (kScreenWidth - codeImageWidth) / 2, y: (kScreenHeight - codeImageWidth) / 2 - 30, width: codeImageWidth, height: codeImageWidth))
        imageView.image = model.url.qrCodeWithLogoImage(logoImage: model.logo)
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(saveImage)))
        let hintLabel = UILabel(frame: CGRect(x: 0, y: imageView.frame.maxY + 13, width: kScreenWidth, height: 20))
        hintLabel.text = "长按图片保存二维码"
        hintLabel.textColor = UIColor.white
        hintLabel.textAlignment = .center
        hintLabel.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(hintLabel)
        return imageView
    }()
    
}

extension XCShareCodeController {
    @objc private func dismissAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    ///  保存图片
    @objc func saveImage() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "保存二维码", style: .default, handler: { (action) in
            UIImageWriteToSavedPhotosAlbum(self.codeImageView.image!, self, #selector(self.image(image:didFinishSavingWithError:contextInfo:)), nil)
        }))
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func image(image: UIImage, didFinishSavingWithError: NSError?, contextInfo: AnyObject) {
        if didFinishSavingWithError == nil {
            MBProgressHUD.show(info: "已保存到相册")
        }  else {
            MBProgressHUD.show(info: "二维码保存失败")
        }
    }
}

/// 分享类型
enum ShareApp: String {
    case weChatFriend = "微信好友"
    case weChatCircle = "微信朋友圈"
    case qqFriend = "QQ好友"
    case qqQzone = "QQ空间"
    case sinaWeibo = "新浪微博"
    case code = "生成二维码"
    case safari = "Safari浏览器"
    case pastedboard = "复制链接"
    case more = "更多"
    
    var shareImage: UIImage {
        switch self {
        case .weChatFriend: return #imageLiteral(resourceName: "share_wexin2")
        case .weChatCircle: return #imageLiteral(resourceName: "share_circle")
        case .qqFriend: return #imageLiteral(resourceName: "share_qq2")
        case .qqQzone: return #imageLiteral(resourceName: "share_zone")
        case .sinaWeibo: return #imageLiteral(resourceName: "share_sina")
        case .code: return #imageLiteral(resourceName: "share_code")
        case .safari: return #imageLiteral(resourceName: "share_safari")
        case .pastedboard: return #imageLiteral(resourceName: "share_copy")
        case .more: return #imageLiteral(resourceName: "share_more")
        }
    }
}

/// 分享模型
class ShareModel: NSObject {
    var title = "SunshineDays"
    var desc = "GitHub个人主页"
    var url = "https://github.com/SunshineDays"
    var logo = #imageLiteral(resourceName: "share_logo")
}


