//
//  MMKSwitch.swift
//  Mimoku_Example
//
//  Created by Mimosa on 2022/2/17.
//

import UIKit

class MMKSwitch: UIControl {
    
    var normalColor: UIColor = .white
    
    var highlightColor: UIColor = .systemGreen
    var highlightImage: UIImage? = nil
    
    var thumbColor: UIColor = .white
    var thumbImage: UIImage? = nil
    
    var isOn: Bool = false {
        didSet {
            if oldValue != isOn {
                set(isOn, animated: true)
            }
        }
    }
    
    private let thumbSizeRatio: CGFloat = 0.82
    private let contentSizeRatio: CGFloat = 0.96
    
    var thumb = UIImageView()
    var highlightView = UIImageView()
    var contentView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if frame.height > frame.width { fatalError() }
        
        addSubview(contentView)
        contentView.addSubview(highlightView)
        highlightView.isUserInteractionEnabled = true
        contentView.addSubview(thumb)
        thumb.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap(g:)))
        addGestureRecognizer(tap)
    }
    
    @objc func tap(g: UITapGestureRecognizer) {
        isOn.toggle()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        clipsToBounds = true
        layer.cornerRadius = frame.height / 2
        
        backgroundColor = UIColor(withHex: 0xaaaaaa)
        
        contentView.clipsToBounds = true
        contentView.frame = bounds.insetBy(dx: (1 - contentSizeRatio) / 2 * frame.width, dy: (1 - contentSizeRatio) / 2 * frame.width)
        contentView.layer.cornerRadius = contentView.frame.height / 2
        
        highlightView.frame = contentView.bounds
        highlightView.backgroundColor = isOn ? highlightColor : normalColor
        if isOn { if highlightImage != nil { highlightView.image = highlightImage } }
        thumb.frame.size = CGSize(width: contentView.frame.height * thumbSizeRatio, height: contentView.frame.height * thumbSizeRatio)
        thumb.center = anchor(isOn)
        thumb.layer.cornerRadius = thumb.frame.size.width / 2
        thumb.backgroundColor = thumbColor
        if thumbImage != nil { thumb.image = thumbImage }
        
        thumb.layer.shadowColor = UIColor.black.cgColor
        thumb.layer.shadowOffset = CGSize(width: 0, height: 1)
        thumb.layer.shadowRadius = 3
        thumb.layer.shadowOpacity = 0.5
    }
    
    func set(_ isOn: Bool, animated: Bool) {
        UIView.animate(withDuration: animated ? 0.25 : 0) { [self] in
            highlightView.backgroundColor = isOn ? highlightColor : normalColor
            if isOn { if highlightImage != nil { highlightView.image = highlightImage } }
            thumb.center = anchor(isOn)
        } completion: { isFinished in
            
        }
    }
    
    private func anchor(_ isOn: Bool) -> CGPoint {
        return isOn ? CGPoint(x: contentView.frame.width - (contentView.frame.height / 2) , y: contentView.frame.height / 2)
        : CGPoint(x: contentView.frame.height / 2 , y: contentView.frame.height / 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
