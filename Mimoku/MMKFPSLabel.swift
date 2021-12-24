//
//  MMKFPSLabel.swift
//
//  Created by Mimosa.
//

import UIKit

class MMKFPSLabel: UILabel {
    
    static let defaultRect = CGRect(x: 10, y: 10 + WindowSafeArea.minY, width: 58, height: 18)
    
    enum Style { case light, dark }
    
    var style: MMKFPSLabel.Style = .light {
        didSet {
            updateStyle()
        }
    }
    
    private var link: CADisplayLink!
    private var count: Int = 0
    private var lastTime: TimeInterval = 0
    
    override init(frame: CGRect) {
        super.init(frame: MMKFPSLabel.defaultRect)
        
        layer.cornerRadius = 5
        layer.masksToBounds = true
        textAlignment = .center
        isUserInteractionEnabled = false
        font = UIFont.systemFont(ofSize: 12, weight: .regular)
        text = "60 FPS"
        
        updateStyle()
        
        link = CADisplayLink(target: self, selector: #selector(tick(link:)))
        link.add(to: RunLoop.main, forMode: .common)
    }
    
    @objc private func tick(link: CADisplayLink) {
        if lastTime == 0 { lastTime = link.timestamp; return }
        
        count += 1
        let delta = link.timestamp - lastTime
        if delta < 1 { return }
        lastTime = link.timestamp
        
        let fps = Int(round(Double(count) / delta))
        count = 0
        
        text = "\(fps) FPS"
    }
    
    private func updateStyle() {
        if style == .dark {
            backgroundColor = UIColor(withHex: 0x000000).alpha(0.3)
            textColor = UIColor(withHex: 0xDDDDDD)
        } else {
            backgroundColor = UIColor(withHex: 0xffffff).alpha(0.3)
            textColor = UIColor(withHex: 0x222222)
        }
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}
