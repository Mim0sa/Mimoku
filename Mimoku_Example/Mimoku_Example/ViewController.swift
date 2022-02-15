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
        view.addSubview(slider)
    }
    
    func slider(_ slider: MMKSlider, didChange value: Float) {
        print(value)
    }

}

