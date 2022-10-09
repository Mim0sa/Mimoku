//
//  MMKToast.swift
//  Mimoku_Example
//
//  Created by Mimosa on 2022/3/4.
//

import UIKit

class MMKToast {
    
    static func show(_ type: ToastType = .info, title: String? = nil, message: String? = nil) {
        let toastView = MMKToastView(type: type, title: title, message: message)
        toastView.center = CGPoint(x: 300, y: 300)
    }

}

extension MMKToast {
    
    enum ToastType {
        case success, error, info, warning
    }
    
    enum ToastMode {
        case dark
        case custom
    }
    
    static func accentColor(_ type: ToastType, _ mode: ToastMode) -> UIColor {
        switch mode {
        case .dark:
            switch type {
            case .success:
                return UIColor()
            case .error:
                return UIColor()
            case .info:
                return UIColor()
            case .warning:
                return UIColor()
            }
        case .custom:
            fatalError("No config yet.")
        }
    }
    
    static func modeColor(_ mode: ToastMode) -> UIColor {
        switch mode {
        case .dark:
            return UIColor()
        case .custom:
            fatalError("No config yet.")
        }
    }
    
}

class MMKToastView: UIView {
    
    var type: MMKToast.ToastType = .info
    var mode: MMKToast.ToastMode = .dark
    
    var title: String?
    var message: String?
    
    init(type: MMKToast.ToastType = .info, title: String? = nil, message: String? = nil) {
        let width = UIScreen.main.bounds.width - 30*2; let height = width / 3
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        self.type = type
        
        backgroundColor = MMKToast.modeColor(mode)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
