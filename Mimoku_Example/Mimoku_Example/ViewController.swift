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
        
        
        
    }
    
    func filter() {
        let edge = (UIScreen.main.bounds.height - 400) / 5
        
        for i in 0...4 {
            let imageView = UIImageView(image: #imageLiteral(resourceName: "demo"))
            imageView.frame.size = CGSize(width: edge, height: edge)
            imageView.contentMode = .scaleAspectFill
            imageView.center = CGPoint(x: 50, y: 200 + edge / 2 + CGFloat(i) * edge)
            view.addSubview(imageView)
            let effect = UIImage.buildInFilterEffect[i]
            imageView.image = #imageLiteral(resourceName: "demo").withBuildInFilter(filterName: effect.0, parameter: effect.1)
        }
        
        for i in 5...9 {
            let imageView = UIImageView(image: #imageLiteral(resourceName: "demo"))
            imageView.frame.size = CGSize(width: edge, height: edge)
            imageView.contentMode = .scaleAspectFill
            imageView.center = CGPoint(x: 150, y: 200 + edge / 2 + CGFloat(i - 5) * edge)
            view.addSubview(imageView)
            let effect = UIImage.buildInFilterEffect[i]
            imageView.image = #imageLiteral(resourceName: "demo").withBuildInFilter(filterName: effect.0, parameter: effect.1)
        }
        
        for i in 10...14 {
            let imageView = UIImageView(image: #imageLiteral(resourceName: "demo"))
            imageView.frame.size = CGSize(width: edge, height: edge)
            imageView.contentMode = .scaleAspectFill
            imageView.center = CGPoint(x: 250, y: 200 + edge / 2 + CGFloat(i - 10) * edge)
            view.addSubview(imageView)
            let effect = UIImage.buildInFilterEffect[i]
            imageView.image = #imageLiteral(resourceName: "demo").withBuildInFilter(filterName: effect.0, parameter: effect.1)
        }
        
        for i in 15...19 {
            let imageView = UIImageView(image: #imageLiteral(resourceName: "demo"))
            imageView.frame.size = CGSize(width: edge, height: edge)
            imageView.contentMode = .scaleAspectFill
            imageView.center = CGPoint(x: 350, y: 200 + edge / 2 + CGFloat(i - 15) * edge)
            view.addSubview(imageView)
            let effect = UIImage.buildInFilterEffect[i]
            imageView.image = #imageLiteral(resourceName: "demo").withBuildInFilter(filterName: effect.0, parameter: effect.1)
        }
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

