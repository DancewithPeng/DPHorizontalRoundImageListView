//
//  DPHorizontalRoundImageListView.swift
//  DPHorizontalRoundImageListView
//
//  Created by DP on 2020/6/15.
//  Copyright © 2020 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit
import SDWebImage

/// HorizontalRoundImageListView相关回调
@objc
public protocol HorizontalRoundImageListViewDelegate: AnyObject {
    
    /// 点击Item对应的View
    func horizontalRoundImageListView(_ listView: HorizontalRoundImageListView, didTapItemViewAtIndex index:Int)
}

/// HorizontalRoundImageListViewDelegate默认实现
public extension HorizontalRoundImageListViewDelegate {
    func horizontalRoundImageListView(_ listView: HorizontalRoundImageListView, didTapItemViewAtIndex index:Int) {}
}

/// 水平圆角图片列表
open class HorizontalRoundImageListView: UIView {
    
    // MARK: - Propeties
    
    /// 数据项
    public var items: [Item] {
        didSet {
            reloadItemViews()
        }
    }
    
    /// 数据项
    @objc
    public var imageItems: [HorizontalRoundImageListViewItem] {
        set {
            items = newValue.filter({ (imageItem) -> Bool in
                switch imageItem.type {
                case .image:
                    return imageItem.image != nil
                case .webImage:
                    return imageItem.webImageURL != nil
                }
            }).map { (imageItem) -> Item in
                switch imageItem.type {
                case .image:
                    return .image(imageItem.image!)
                case .webImage:
                    return .webImage(imageItem.webImageURL!)
                }
            }
        }
        get {
            return items.map { (item) -> HorizontalRoundImageListViewItem in
                switch item {
                case let .image(image):
                    return HorizontalRoundImageListViewItem(image: image)
                case let .webImage(url):
                    return HorizontalRoundImageListViewItem(webImageURL: url)
                }
            }
        }
    }
    
    /// 子项的View
    private lazy var itemViews = [UIImageView]()
    
    /// 子项的尺寸
    @objc
    public var itemSize: CGFloat = 60 {
        didSet {
            for itemView in itemViews {
                itemView.layer.cornerRadius = itemSize / 2.0
            }
            setNeedsLayout()
        }
    }
    
    /// 子项的间距，可以为负数
    @objc
    public var spacing: CGFloat = 10 {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// 内容内嵌的距离
    @objc
    public var contentInset = UIEdgeInsets.zero {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// 网络图片子项加载的占位图
    @objc
    public var webImageItemLoadingPlaceholder: UIImage?
    
    /// 子项的内容模式
    @objc
    public var itemContentMode: UIView.ContentMode = .scaleAspectFill {
        didSet {
            for itemView in itemViews {
                itemView.contentMode = itemContentMode
            }
        }
    }
    
    /// 子项的边框宽度
    @objc
    public var itemBorderWidth: CGFloat  = 0 {
        didSet {
            for itemView in itemViews {
                itemView.layer.borderWidth = itemBorderWidth
            }
        }
    }
    
    /// 子项的边框颜色
    @objc
    public var itemBorderColor: UIColor = .white {
        didSet {
            for itemView in itemViews {
                itemView.layer.borderColor = itemBorderColor.cgColor
            }
        }
    }
    
    @objc
    public weak var delegate: HorizontalRoundImageListViewDelegate?
    
    // MARK: - Life cycle methods
    
    @objc
    public init(frame: CGRect, imageItems: [HorizontalRoundImageListViewItem]) {
        self.items = imageItems.filter({ (imageItem) -> Bool in
            switch imageItem.type {
            case .image:
                return imageItem.image != nil
            case .webImage:
                return imageItem.webImageURL != nil
            }
        }).map { (imageItem) -> Item in
            switch imageItem.type {
            case .image:
                return .image(imageItem.image!)
            case .webImage:
                return .webImage(imageItem.webImageURL!)
            }
        }
        super.init(frame: frame)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(listViewDidTap(_:))))
        reloadItemViews()
    }
         
    public init(frame: CGRect, items: [Item]) {
        self.items = items;
        super.init(frame: frame)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(listViewDidTap(_:))))
        reloadItemViews()
    }
    
    required public init?(coder: NSCoder) {
        if let items = coder.decodeObject(forKey: "items") as? [Item] {
            self.items = items
        } else {
            self.items = []
        }
        
        super.init(coder: coder)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(listViewDidTap(_:))))
        reloadItemViews()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        for index in 0..<itemViews.count {
            let itemView = itemViews[index]
            itemView.frame = CGRect(x: contentInset.left+(itemSize+spacing)*CGFloat(index), y: contentInset.top, width: itemSize, height: itemSize)
        }
    }
    
    open override var intrinsicContentSize: CGSize {
        let contentWidthInset = contentInset.left + contentInset.right
        let totalItemSize = itemSize * CGFloat(itemViews.count)
        let totalSpacing = itemViews.count > 2 ? (spacing * CGFloat(itemViews.count-1)) : 0
        let height = contentInset.top + contentInset.bottom + itemSize
        return CGSize(width:contentWidthInset+totalItemSize+totalSpacing, height: height)
    }
}

// MARK: - Event handing methods
extension HorizontalRoundImageListView {
    
    /// 列表被点击
    @objc
    func listViewDidTap(_ tapGesture: UITapGestureRecognizer) {
        let touchPoint = tapGesture.location(in: self)
        for index in (0..<itemViews.count).reversed() {
            let itemView = itemViews[index]
            if itemView.frame.contains(touchPoint) {
                delegate?.horizontalRoundImageListView(self, didTapItemViewAtIndex: index)
                break
            }
        }
    }
}

// MARK: - Load item views
private extension HorizontalRoundImageListView {
    
    /// 重新加载子项的View
    func reloadItemViews() {
        for itemView in itemViews {
            itemView.removeFromSuperview()
        }
        
        for item in items {
            let imageView = UIImageView()
            imageView.contentMode        = itemContentMode
            imageView.clipsToBounds      = true
            imageView.layer.cornerRadius = itemSize / 2.0
            imageView.layer.borderWidth  = itemBorderWidth;
            imageView.layer.borderColor  = itemBorderColor.cgColor;
            
            switch item {
            case let .image(image):
                imageView.image = image
            case let .webImage(url):
                if let placeholder = webImageItemLoadingPlaceholder {
                    imageView.sd_setImage(with: url, placeholderImage: placeholder, options: [], completed: nil)
                } else {
                    imageView.sd_setImage(with: url, completed: nil)
                }
            }
            
            addSubview(imageView)
            itemViews.append(imageView)
        }
        
        setNeedsLayout()
    }
}

// MARK: - Types
extension HorizontalRoundImageListView {
    
    /// 数据项
    public enum Item {
        /// 图片
        case image(UIImage)
        /// 网络图片
        case webImage(URL)
    }
}

/// Item类型
@objc
public enum HorizontalRoundImageListViewItemType: Int {
    case image
    case webImage
}

/// 数据项
@objc
open class HorizontalRoundImageListViewItem: NSObject {
    
    /// Item类型
    private var internalType: HorizontalRoundImageListViewItemType
    
    @objc
    public var type: HorizontalRoundImageListViewItemType {
        return internalType
    }
    
    @objc
    public var image: UIImage?
    
    @objc
    public var webImageURL: URL?
    
    @objc
    public init(image: UIImage) {
        internalType = .image
        self.image = image
    }
    
    @objc
    public init(webImageURL: URL) {
        internalType = .webImage
        self.webImageURL = webImageURL
    }
}
