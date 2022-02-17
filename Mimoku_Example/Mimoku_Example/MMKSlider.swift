//
//  MMKSlider.swift
//  Mimoku_Example
//
//  Created by 吉乞悠 on 2022/2/15.
//

import UIKit

protocol MMKSliderDelegate: AnyObject {
    func slider(_ slider: MMKSlider, didChange value: Float)
}

class MMKSlider: UIView {
    
    weak var delegate: MMKSliderDelegate?

    var minValue: Float = 0
    var maxValue: Float = 1
    
    var value: Float = 0.5 {
        didSet {
            if oldValue != value {
                updateProgress(with: value)
                delegate?.slider(self, didChange: value)
            }
        }
    }
    
    var trackerLineHWidth: CGFloat = 4
    
    var thumbSize: CGSize = CGSize(width: 24, height: 24)
    
    var minTracker = UIImageView()
    var maxTracker = UIImageView()
    var thumb = UIImageView()
    
    var slider: UISlider!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        minTracker.backgroundColor = .orange
        addSubview(minTracker)
        maxTracker.backgroundColor = .systemGray5
        addSubview(maxTracker)
        thumb.backgroundColor = .white
        thumb.isUserInteractionEnabled = true
        addSubview(thumb)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(g:)))
        thumb.addGestureRecognizer(pan)
    }
    
    @objc func pan(g: UIPanGestureRecognizer) {
        let position = g.location(in: self)
        if position.x < 0 {
            value = minValue
        } else if position.x > frame.width {
            value = maxValue
        } else {
            value = Float(position.x / frame.width)
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        updateLayouts()
    }
    
    private func updateLayouts() {
        if value < minValue || value > maxValue { fatalError() }
        if trackerLineHWidth > frame.height { fatalError() }
        
        let currentValueRatio = (value - minValue) / (maxValue - minValue)
        minTracker.frame = CGRect(x: 0, y: (frame.height - trackerLineHWidth) / 2,
                                  width: CGFloat(currentValueRatio) * frame.width, height: trackerLineHWidth)
        minTracker.layer.cornerRadius = trackerLineHWidth / 2
        minTracker.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        maxTracker.frame = CGRect(x: CGFloat(currentValueRatio) * frame.width, y: (frame.height - trackerLineHWidth) / 2,
                                  width: CGFloat(1 - currentValueRatio) * frame.width, height: trackerLineHWidth)
        maxTracker.layer.cornerRadius = trackerLineHWidth / 2
        maxTracker.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        thumb.frame.size = thumbSize
        thumb.center = CGPoint(x: CGFloat(currentValueRatio) * frame.width, y: frame.height / 2)
        thumb.layer.cornerRadius = 12
        thumb.layer.shadowColor = UIColor.black.cgColor
        thumb.layer.shadowOffset = CGSize(width: 0, height: 1)
        thumb.layer.shadowRadius = 3
        thumb.layer.shadowOpacity = 0.2
    }
    
    private func updateProgress(with newValue: Float) {
        let currentValueRatio = (newValue - minValue) / (maxValue - minValue)
        minTracker.frame = CGRect(x: 0, y: (frame.height - trackerLineHWidth) / 2,
                                  width: CGFloat(currentValueRatio) * frame.width, height: trackerLineHWidth)
        maxTracker.frame = CGRect(x: CGFloat(currentValueRatio) * frame.width, y: (frame.height - trackerLineHWidth) / 2,
                                  width: CGFloat(1 - currentValueRatio) * frame.width, height: trackerLineHWidth)
        thumb.center = CGPoint(x: CGFloat(currentValueRatio) * frame.width, y: frame.height / 2)
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if super.point(inside: point, with: event) {
            return true
        } else if bounds.offsetBy(dx: -thumbSize.width / 2, dy: 0).contains(point) {
            return true
        } else if bounds.offsetBy(dx:  thumbSize.width / 2, dy: 0).contains(point) {
            return true
        } else {
            return false
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
