//
//  ViewController.swift
//  ivvlivanovPW1
//
//  Created by Иван Иванов on 11.09.2025.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var view1: UIView!
   
    @IBOutlet weak var view2: UIView!
    
    
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var button: UIButton!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colors = uniqueHexColors(count: 3).map { UIColor(hex: $0) }
        button.layer.cornerRadius = 10
        view1.layer.cornerRadius = randomCornerRadius()
        view2.layer.cornerRadius = randomCornerRadius()
        view3.layer.cornerRadius = randomCornerRadius()
        
        view1.backgroundColor = colors[0]
        view2.backgroundColor = colors[1]
        view3.backgroundColor = colors[2]
    }

    @IBAction func buttonWasPressed(_ sender: Any) {
        button.isEnabled = false
        
        let colors = uniqueHexColors(count: 3).map { UIColor(hex: $0) }
        
        UIView.animate(withDuration: Constants.animationDuration, animations: {
            self.view1.backgroundColor = colors[0]
            self.view1.layer.cornerRadius = randomCornerRadius()
        })
        UIView.animate(withDuration: Constants.animationDuration, animations: {
            self.view2.backgroundColor = colors[1]
            self.view2.layer.cornerRadius = randomCornerRadius()
        })
        UIView.animate(withDuration: Constants.animationDuration, animations: {
            self.view3.backgroundColor = colors[2]
            self.view3.layer.cornerRadius = randomCornerRadius()
        }, completion: { [weak self] _ in
            self?.button.isEnabled = true
        })
    }
}

// MARK: - Random
private func randomHexColor() -> Int {
    Int.random(in: 0x000000...0xFFFFFF)
}

private func uniqueHexColors(count: Int) -> [Int] {
    var set = Set<Int>()
    while set.count < count { set.insert(randomHexColor()) }
    return Array(set)
}

private func randomCornerRadius() -> CGFloat {
    .random(in: 0...Constants.maxCornerRadius)
}

// MARK: - UIColor + HEX
extension UIColor {
    convenience init(hex: Int) {
        let r = CGFloat((hex >> 16) & 0xFF) / 255.0
        let g = CGFloat((hex >> 8) & 0xFF) / 255.0
        let b = CGFloat(hex & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}

// MARK: - Constants
private enum Constants {
    static let animationDuration: TimeInterval = 3.49
    static let maxCornerRadius: CGFloat = 25
}
