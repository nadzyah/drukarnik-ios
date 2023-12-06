//
//  DKKeyboardEmojiCollectionViewCell.swift
//  Drukarnik
//
//  Created by Logout on 25.11.23.
//

import UIKit

class DKKeyboardEmojiCollectionViewCell: UICollectionViewCell {
    
    private var textLayer: CATextLayer?

    static let reuseIdentifier = "cellEmoji"
    override var reuseIdentifier: String? { Self.reuseIdentifier }
    
    static func dequeue(from collectionView: UICollectionView, for indexPath: IndexPath) -> DKKeyboardEmojiCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.reuseIdentifier, for: indexPath) as? DKKeyboardEmojiCollectionViewCell ?? DKKeyboardEmojiCollectionViewCell()
        return cell

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.clearCell()
    }
    
    private func clearCell() {
        self.textLayer?.removeFromSuperlayer()
    }
    
    var emojiLabel: String? {
        get {
            self.textLayer?.string as? String
        }
        set {
            self.clearCell()
                
            let fontSize = DKKeyboardEmojiCollectionView.cellSize / 1.2

            self.layer.rasterizationScale = UIScreen.main.scale
            let textLayer = CATextLayer()
            textLayer.frame = CGRect.zero;
            textLayer.font = CFBridgingRetain( UIFont.systemFont(ofSize: fontSize).fontName);
            textLayer.fontSize = fontSize;
            textLayer.alignmentMode = .center;
            self.layer.addSublayer(textLayer)
            self.textLayer = textLayer
            self.layer.shouldRasterize = true
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            textLayer.string = newValue
            CATransaction.commit()
        }
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        let fontSize = DKKeyboardEmojiCollectionView.cellSize / 1.2
        self.textLayer?.fontSize = fontSize
        self.textLayer?.frame = layer.bounds
        CATransaction.commit()
    }
}