//
//  AssetCollectionViewCell.swift
//  AWKImagePickerController
//
//  Created by Rens Verhoeven on 29-03-16.
//  Copyright © 2017 Awkward BV. All rights reserved.
//

import UIKit
import Photos

final internal class AssetCollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return "asset-cell"
    }
    
    internal var imageSize: CGSize = CGSize(width: 100, height: 100) {
        didSet {
            guard self.imageSize != oldValue else {
                return
            }
            self.shouldUpdateImage = true
        }
    }
    
    internal var imageManager: PHImageManager?
    
    internal var asset: PHAsset? {
        didSet {
            self.metadataView.asset = self.asset
            guard self.asset != oldValue || self.imageView.image == nil else {
                return
            }
            self.accessibilityLabel = asset?.accessibilityLabel
            self.shouldUpdateImage = true
        }
    }
    
    private var currentRequest: PHImageRequestID?
    
    fileprivate var shouldUpdateImage = false
    
    lazy private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy private var metadataView: AssetMetadataView = {
        let view = AssetMetadataView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

	lazy var iconView: SelectionIconView = {
		let iconView = SelectionIconView()
		return iconView
	}()

    lazy private var selectedOverlay: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 1.0
        view.backgroundColor = UIColor.clear
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(iconView)
        view.bottomAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 5).isActive = true
        view.leadingAnchor.constraint(equalTo: iconView.leadingAnchor, constant: -5).isActive = true
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.metadataView)
        self.contentView.addSubview(self.selectedOverlay)
        
        self.accessibilityIdentifier = "tatsi.cell.asset"
        self.accessibilityTraits = UIAccessibilityTraitImage
        self.isAccessibilityElement = true
        
        self.setupConstraints()

		setSelected(selected: false, animated: false)
    }
    
    private func setupConstraints() {
        let constraints = [
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.imageView.trailingAnchor),
            
            self.selectedOverlay.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.selectedOverlay.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.selectedOverlay.bottomAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.selectedOverlay.trailingAnchor),
            
            self.metadataView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.metadataView.bottomAnchor),
            self.contentView.rightAnchor.constraint(equalTo: self.metadataView.rightAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    internal func reloadContents() {
        guard self.shouldUpdateImage else {
            return
        }
        self.shouldUpdateImage = false
        self.startLoadingImage()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageView.image = nil
		self.setSelected(selected: false, animated: false)

        if let currentRequest = self.currentRequest {
            let imageManager = self.imageManager ?? PHImageManager.default()
            imageManager.cancelImageRequest(currentRequest)
        }

    }
    
    fileprivate func startLoadingImage() {
        self.imageView.image = nil
        guard let asset = self.asset else {
            return
        }
        let imageManager = self.imageManager ?? PHImageManager.default()
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.resizeMode = PHImageRequestOptionsResizeMode.fast
        requestOptions.isSynchronous = false
        
        self.imageView.contentMode = UIViewContentMode.center
        self.imageView.image = nil
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            autoreleasepool {
                let scale = UIScreen.main.scale > 2 ? 2 : UIScreen.main.scale
                guard let targetSize = self?.imageSize.scaled(with: scale), self?.asset?.localIdentifier == asset.localIdentifier else {
                    return
                }
                self?.currentRequest = imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: PHImageContentMode.aspectFill, options: requestOptions) { (image, _) in
                    DispatchQueue.main.async {
                        autoreleasepool {
                            guard let image = image, self?.asset?.localIdentifier == asset.localIdentifier else {
                                return
                            }
                            self?.imageView.contentMode = UIViewContentMode.scaleAspectFill
                            self?.imageView.image = image
                        }
                    }
                }
            }
        }
    }

	func setSelected(selected: Bool, animated: Bool) {

		switch (selected, animated) {
		case (true, true):
			UIView.animate(withDuration: 0.25, animations: {
				self.iconView.transform = CGAffineTransform.identity
			}, completion: { (_) in

			})

		case (true, false):
			iconView.transform = CGAffineTransform.identity
		case (false, true):

			UIView.animate(withDuration: 0.25, animations: {
				self.iconView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
			}, completion: { (_) in
				self.iconView.transform = CGAffineTransform(scaleX: 0, y: 0)
			})

		case (false, false):
			iconView.transform = CGAffineTransform(scaleX: 0, y: 0)
		}
	}
}
