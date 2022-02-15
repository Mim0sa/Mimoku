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
            updateProgress(with: value)
            delegate?.slider(self, didChange: value)
        }
    }
    
    var trackerLineHWidth: CGFloat = 4
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateLayouts()
    }
    
    private func updateLayouts() {
        if value < minValue || value > maxValue { fatalError() }
        if trackerLineHWidth > frame.height { fatalError() }
        
        let currentValueRatio = (value - minValue) / (maxValue - minValue)
        minTracker.frame = CGRect(x: 0, y: (frame.height - trackerLineHWidth) / 2,
                                  width: CGFloat(currentValueRatio) * frame.width, height: trackerLineHWidth)
        maxTracker.frame = CGRect(x: CGFloat(currentValueRatio) * frame.width, y: (frame.height - trackerLineHWidth) / 2,
                                  width: CGFloat(1 - currentValueRatio) * frame.width, height: trackerLineHWidth)
        thumb.frame.size = CGSize(width: 24, height: 24)
        thumb.center = CGPoint(x: CGFloat(currentValueRatio) * frame.width, y: frame.height / 2)
        thumb.layer.cornerRadius = 12
        thumb.layer.shadowColor = UIColor.black.cgColor
        thumb.layer.shadowOffset = CGSize(width: 0, height: 1)
        thumb.layer.shadowRadius = 3
        thumb.layer.shadowOpacity = 0.2
    }
    
    private func updateProgress(with newValue: Float) {
        minTracker.frame = CGRect(x: 0, y: (frame.height - trackerLineHWidth) / 2,
                                  width: CGFloat(newValue) * frame.width, height: trackerLineHWidth)
        maxTracker.frame = CGRect(x: CGFloat(newValue) * frame.width, y: (frame.height - trackerLineHWidth) / 2,
                                  width: CGFloat(1 - newValue) * frame.width, height: trackerLineHWidth)
        thumb.center = CGPoint(x: CGFloat(newValue) * frame.width, y: frame.height / 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
