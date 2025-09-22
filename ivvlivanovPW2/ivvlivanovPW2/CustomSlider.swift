//
//  CustomSlider.swift
//  ivvlivanovPW2
//
//  Created by Иван Иванов on 21.09.2025.
//
import UIKit

final class CustomSlider: UIView {
    var valueChanged: ((Double) -> Void)?
    private let slider = UISlider()
    private let titleView = UILabel()
    
    enum Constants {
        static let backgroundColor: UIColor = .white
        static let titleFontSize: CGFloat = 16
        static let titleTop: CGFloat = 10
        static let titleLeading: CGFloat = 20
        static let sliderTop: CGFloat = 8
        static let sliderLeading: CGFloat = 20
        static let sliderBottom: CGFloat = -10
    }
    
    init(title: String, min: Double, max: Double) {
        super.init(frame: .zero)
        titleView.text = title
        titleView.font = .systemFont(ofSize: Constants.titleFontSize)
        
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = Constants.backgroundColor
        translatesAutoresizingMaskIntoConstraints = false
        
        [slider, titleView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.titleTop),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.titleLeading),
            
            slider.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: Constants.sliderTop),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.sliderBottom),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sliderLeading)
        ])
    }
    
    @objc private func sliderValueChanged() {
        valueChanged?(Double(slider.value))
    }
}
