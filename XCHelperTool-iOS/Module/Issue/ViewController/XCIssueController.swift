//
//  XCIssueController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/7/11.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 发布
class XCIssueController: BaseViewController {

    
//    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableHeaderView: UIView!
    
    @IBOutlet weak var contentTextView: CustomTextView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    private let addImage = #imageLiteral(resourceName: "issue_add_photo")
    
    private var images = [UIImage]()

    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (kScreenWidth - 2 * 15 - 20) / 3, height: (kScreenWidth - 2 * 15 - 20) / 3)
        flowLayout.minimumLineSpacing = 15
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        flowLayout.scrollDirection = .vertical
        return flowLayout
    }()
    
    private lazy var toolView: XCIssueToolView = {
        let view = R.nib.xcIssueToolView.firstView(owner: nil)!
        view.frame = CGRect(x: 0, y: kScreenHeight - (85 + kBottomMargin), width: kScreenWidth, height: (85 + kBottomMargin))
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.groupTableViewBackground
        
        images.append(addImage)
        initView()
        initKeyBoardListener()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension XCIssueController {
    private func initView() {
        
        contentTextView.placeholder.text = "分享你的心情，故事......"
        
        tableView.tableFooterView = UIView()
//        contentTextView.delegate = self
        collectionView.collectionViewLayout = flowLayout
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(R.nib.xcIssuePhotoCell)
        collectionView.bounces = false
        collectionView.reloadData()
        view.addSubview(toolView)
    }
    
    private func initKeyBoardListener() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyBoardWillShow(_ notification: Notification) {
        let height = KeyBoardTool.keyBoardHeight(notification)
        let duration = KeyBoardTool.keyBoardDuration(notification)
        UIView.animate(withDuration: duration) {
            self.toolView.frame = CGRect(x: 0, y: kScreenHeight - (height + 85), width: kScreenWidth, height: 85)
        }
    }
    
    @objc private func keyBoardWillHide(_ notification: Notification) {
        let duration = KeyBoardTool.keyBoardDuration(notification)
        UIView.animate(withDuration: duration) {
            self.toolView.frame = CGRect(x: 0, y: kScreenHeight - (85 + kBottomMargin), width: kScreenWidth, height: (85 + kBottomMargin))
        }
    }
}

extension XCIssueController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count > 9 ? images.count - 1 : images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.xcIssuePhotoCell, for: indexPath)!
        cell.iconImageView.image = images[indexPath.row]
        cell.deleteButton.isHidden = images[indexPath.row] == addImage
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deletePhotoAction(_:)), for: .touchUpInside)
        if indexPath.row == images.count - 1 {
            cell.iconImageView.contentMode = .center
        } else {
            cell.iconImageView.contentMode = .scaleAspectFill
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if images.count > 0 {
            if indexPath.row == images.count - 1 {
                imagePicker()
            }
        } else {
            imagePicker()
        }
    }
    
}

extension XCIssueController {
    private func imagePicker() {
        let imagePickerController = TZImagePickerController(maxImagesCount: 9, delegate: self)
        imagePickerController?.didFinishPickingPhotosHandle = { images, anys, isBool  in
            if let images = images {
                self.images.removeLast()
                self.images += images
                self.images.append(self.addImage)
                self.collectionView.reloadData()
            }
        }
        present(imagePickerController!, animated: true, completion: nil)
    }
    
    @objc private func deletePhotoAction(_ sender: UIButton) {
        let alertController = UIAlertController(title: "删除该照片？", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "删除", style: .default, handler: { (action) in
            self.images.remove(at: sender.tag)
            self.collectionView.deselectItem(at: IndexPath(row: sender.tag, section: 0), animated: true)
            self.collectionView.reloadData()
        }))
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (action) in
            
        }))
        present(alertController, animated: true, completion: nil)
    }
}

extension XCIssueController: XCIssueToolViewDelegate {
    func issueToolView(_ toolView: XCIssueToolView, didClickLoactionButton sender: UIButton) {
        
    }
    
    func issueToolView(_ toolView: XCIssueToolView, didClickCameraButton sender: UIButton) {
        
    }
    
    func issueToolView(_ toolView: XCIssueToolView, didClickPhotoButton sender: UIButton) {
        
    }
    
    func issueToolView(_ toolView: XCIssueToolView, didClickEmjonButton sender: UIButton) {
        
    }
    
    func issueToolView(_ toolView: XCIssueToolView, didClickMoreButton sender: UIButton) {
        
    }
    

}

extension XCIssueController: TZImagePickerControllerDelegate {
    
}

extension XCIssueController: UITextViewDelegate {

}

