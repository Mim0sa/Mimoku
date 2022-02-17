//
//  ViewController.swift
//  Mimoku_Example
//
//  Created by Mimosa on 2020/12/29.
//

import UIKit

class ViewController: UIViewController, MMKSliderDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let slider = MMKSlider()
        slider.delegate = self
        slider.frame.size = CGSize(width: 200, height: 30)
        slider.center = view.center
//        view.addSubview(slider)
        
        let sw = MMKSwitch()
        sw.frame.size = CGSize(width: 130, height: 65)
        sw.center = view.center
        view.addSubview(sw)
    }
    
    func slider(_ slider: MMKSlider, didChange value: Float) {
        print(value)
    }

}

