//
//  ViewController.swift
//  Mimoku_Example
//
//  Created by Mimosa on 2020/12/29.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createGrid()
    }
    
    func createGrid() {
        print(Date().timeIntervalSince1970)
        let edge = view.frame.width / 30
        for i in 0...29 {
            for j in 0...Int(view.frame.height / edge) + 1 {
                let v = UIView()
                v.backgroundColor = UIColor.randomLSColor()
                v.frame = CGRect(x: CGFloat(i) * edge,
                                 y: CGFloat(j) * edge,
                                 width: edge, height: edge)
                view.addSubview(v)
            }
        }
        print(Date().timeIntervalSince1970)
    }


}

