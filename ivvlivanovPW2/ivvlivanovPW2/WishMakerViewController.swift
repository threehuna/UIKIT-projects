//
//  ViewController.swift
//  ivvlivanovPW2
//
//  Created by Иван Иванов on 20.09.2025.
//

import UIKit


class WishMakerViewController: UIViewController {
    
    private var titleView: UILabel!
    private var redValue: CGFloat = 0
    private var greenValue: CGFloat = 0
    private var blueValue: CGFloat = 0
    private var isSlidersShown: Bool = true
    private weak var slidersStack: UIStackView?
    private weak var toggleButton: UIButton?
    
    private let defaults = UserDefaults.standard //HW3
    
    private let addWishButton: UIButton = UIButton(type: .system) //HW3
    
    enum Constants {
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        
        static let titleText: String = "Wish Maker"
        
        static let red: String = "Red"
        static let green: String = "Green"
        static let blue: String = "Blue"
        static let stackTitle: String = "StackColor"
        
        static let titleFontSize: CGFloat = 32
        
        static let titleLeading: CGFloat = 20
        static let titleTop: CGFloat = 30
        
        static let descriptionText: String = "Adjust the color of the screen"
        
        static let descriptionFontSize: CGFloat = 20
        
        static let buttonTitleWhenSlidersShown: String = "Hide sliders"
        static let buttonTitleWhenSlidersHidden: String = "Show sliders"
        static let buttonRadius: CGFloat = 12
        static let buttonLeading: CGFloat = 40
        static let buttonTop: CGFloat = 200 //HW3
        static let buttonWidth: CGFloat = 150
        static let buttonHeight: CGFloat = 40
        
        static let buttonBGLEading: CGFloat = 210
        static let buttonBGTitle: String = "Change bg randomly"
        
        static let buttonPickerTitle: String = "Pick a color"
        static let buttonPickerTop: CGFloat = 255 //HW3
        static let buttonPickerLeading: CGFloat = 130
        
        static let stackRadius: CGFloat = 20
        static let stackBottom: CGFloat = 120 //HW3
        static let stackLeading: CGFloat = 20
        static let stackSpacing: CGFloat = 12
        static let stackMarginTop: CGFloat = 12
        static let stackMarginLeft: CGFloat = 16
        static let stackMarginBottom: CGFloat = 12
        static let stackMarginRight: CGFloat = 16
        static let stackTrailing: CGFloat = 20
        
        static let buttonBottom: CGFloat = 50 //HW3
        static let buttonSide: CGFloat = 20 //HW3
        static let buttonText: String = "Add Your Wish" //HW3
        
        
        static let hexWhite: Int = 0xFFFFFF
        
        static let descrtiptionLeading: CGFloat = 20
        static let descriptionTop: CGFloat = 70
        
        static let initialBackground: UIColor = .systemPink
        static let stackDefaultBackground: UIColor = .white
        
        static let backgroundDefaults = "BGDefault" //HW3
        static let stackColorDefaults: String = "StackDefault" //HW3
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
   private func configureUI() {
       if let hex = UserDefaults.standard.value(forKey: Constants.backgroundDefaults) as? Int {
           view.backgroundColor = UIColor(hex: hex)
       }
       else{
           view.backgroundColor = .systemPink
       }
       
       
       configureTitle()
       configureDescription()
       configureButtonForSliders()
       configureButtonForBackgroundColor()
       configureButtonForPicker()
       configureSliders()
       configureAddWishButton()
       
      
    }
    private func configureTitle() {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = Constants.titleText
        title.font = UIFont.systemFont(ofSize: Constants.titleFontSize)
        
        view.addSubview(title)
        NSLayoutConstraint.activate([
            title.pinCenterX(to: view),
            title.pinLeft(to: view, Constants.titleLeading),
            title.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.titleTop)
            ])
    
    }
    private func configureDescription() {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.text = Constants.descriptionText
        description.font = UIFont.boldSystemFont(ofSize: Constants.descriptionFontSize)
        description.textColor = UIColor(hex: Constants.hexWhite)
        
        view.addSubview(description)
        NSLayoutConstraint.activate([
            description.pinCenterX(to: view),
            description.pinLeft(to: view, Constants.descrtiptionLeading),
            description.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.descriptionTop)
        ])
    }
    
    private func configureButtonForSliders() {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(isSlidersShown ? Constants.buttonTitleWhenSlidersShown : Constants.buttonTitleWhenSlidersHidden, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(hex: Constants.hexWhite)
        button.layer.cornerRadius = Constants.buttonRadius
       
       
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        view.addSubview(button)
        toggleButton = button
        
        NSLayoutConstraint.activate([
            button.pinLeft(to: view, Constants.buttonLeading),
            button.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.buttonTop),
            button.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            button.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])

    }
    
    private func configureButtonForBackgroundColor() {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.buttonBGTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(hex: Constants.hexWhite)
        button.layer.cornerRadius = Constants.buttonRadius
        button.sizeToFit()
        
        
        button.addTarget(self, action: #selector(bgButtonTapped), for: .touchUpInside)
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.pinLeft(to: view, Constants.buttonBGLEading),
            button.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.buttonTop),
            button.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            button.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
    }
    
    private func configureButtonForPicker() {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.buttonPickerTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(hex: Constants.hexWhite)
        button.layer.cornerRadius = Constants.buttonRadius
        button.sizeToFit()
        
        
        button.addTarget(self, action: #selector(presentColorPicker), for: .touchUpInside)
        
        view.addSubview(button)
       
        button.pinLeft(to: view, Constants.buttonPickerLeading)
        button.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.buttonPickerTop)
        button.setWidth(Constants.buttonWidth)
        button.setHeight(Constants.buttonHeight)
        
    }
    
    private func configureSliders() {
        
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = Constants.stackSpacing
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: Constants.stackSpacing, left: Constants.stackMarginLeft, bottom: Constants.stackMarginBottom, right: Constants.stackMarginRight)
        if let hex = UserDefaults.standard.value(forKey: Constants.stackColorDefaults) as? Int { //HW3
            let stcolor = CGColor.from(hex: hex)//HW3
            stack.layer.backgroundColor = stcolor//HW3
        }
        else{stack.layer.backgroundColor = .from(hex: 0xFFFFFF) }//HW3
        stack.layer.cornerRadius = Constants.stackRadius
        stack.layer.masksToBounds = true

        view.addSubview(stack)
        slidersStack = stack
        stack.isHidden = !isSlidersShown

        let sliderRed = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderGreen = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderStackBackground = CustomSlider(title: Constants.stackTitle , min: Constants.sliderMin, max: Constants.sliderMax)

        [sliderRed, sliderGreen, sliderBlue, sliderStackBackground].forEach {
            stack.addArrangedSubview($0)
        }

        
        stack.pinLeft(to: view, Constants.stackLeading)
        stack.pinRight(to: view, Constants.stackTrailing)
        stack.pinBottom(to: view, Constants.stackBottom)
      


        sliderRed.valueChanged = { [weak self] value in
            guard let self else { return }
            self.redValue = CGFloat(value)
            self.updateBackgroundColor()
        }
        sliderGreen.valueChanged = { [weak self] value in
            guard let self else { return }
            self.greenValue = CGFloat(value)
            self.updateBackgroundColor()
        }
        sliderBlue.valueChanged = { [weak self] value in
            guard let self else { return }
            self.blueValue = CGFloat(value)
            self.updateBackgroundColor()
        }
        sliderStackBackground.valueChanged = { value in
            let color = UIColor(hex: Int(value * Double(Constants.hexWhite)))
            let stackColor = color.cgColor //HW3
            self.defaults.set(stackColor.hexValue, forKey: Constants.stackColorDefaults) //HW3
            stack.layer.backgroundColor = stackColor //HW3
        }
    }
    
    private func configureAddWishButton() { //HW3
        view.addSubview(addWishButton) //HW3
        addWishButton.setHeight(Constants.buttonHeight) //HW3
        addWishButton.pinBottom(to: view, Constants.buttonBottom) //HW3
        addWishButton.pinHorizontal(to: view, Constants.buttonSide) //HW3
        addWishButton.backgroundColor = .white //HW3
        addWishButton.setTitleColor(.black, for: .normal) //HW3
        addWishButton.setTitle(Constants.buttonText, for: .normal) //HW3
        addWishButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18) //HW3
    
        addWishButton.layer.cornerRadius = Constants.buttonRadius //HW3
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside) //HW3
        
    } //HW3
    
    
    private func updateBackgroundColor() {
        let color = UIColor(
            red: redValue,
            green: greenValue,
            blue: blueValue,
            alpha: 1
        )
        view.backgroundColor = color //HW3
        defaults.set(color.hex, forKey: Constants.backgroundDefaults) //HW3
    }
   
    @objc private func buttonTapped() {
        isSlidersShown.toggle()
        let shouldShow = isSlidersShown

        if let stack = slidersStack {
            UIView.animate(withDuration: 0.25) {
                stack.alpha = shouldShow ? 1 : 0
            } completion: { _ in
                stack.isHidden = !shouldShow
            }
        }
        toggleButton?.setTitle(shouldShow ? Constants.buttonTitleWhenSlidersShown
                                          : Constants.buttonTitleWhenSlidersHidden, for: .normal)
    }
    
    @objc private func bgButtonTapped() {
       
        let color = UIColor(hex:randomHexColor())
        view.backgroundColor = color //HW3
        defaults.set(color.hex, forKey: Constants.backgroundDefaults) //HW3
    }
    
    @objc private func presentColorPicker() {
        let picker = UIColorPickerViewController()
        picker.supportsAlpha = false
        picker.selectedColor = view.backgroundColor ?? .systemPink
        picker.delegate = self
        present(picker, animated: true)
    }
    
    private func randomHexColor() -> Int {
        Int.random(in: 0x000000...0xFFFFFF)
    }
    
    @objc private func addWishButtonPressed() {
        present(WishStoringViewController(), animated: true)
    }
}
extension UIColor {
    var hex: Int { //HW3
            var red: CGFloat = 0 //HW3
            var green: CGFloat = 0 //HW3
            var blue: CGFloat = 0 //HW3
            var alpha: CGFloat = 0 //HW3
            getRed(&red, green: &green, blue: &blue, alpha: &alpha) //HW3
            let rgb = (Int)(red*255)<<16 | (Int)(green*255)<<8 | (Int)(blue*255)<<0 //HW3
            return rgb //HW3
        } //HW3

        convenience init(hex: Int) {
            let r = CGFloat((hex >> 16) & 0xFF) / 255.0
            let g = CGFloat((hex >> 8) & 0xFF) / 255.0
            let b = CGFloat(hex & 0xFF) / 255.0
            self.init(red: r, green: g, blue: b, alpha: 1.0)
        }
}

extension CGColor { //HW3
    var hexValue: Int { //HW3
        guard let components = self.components else { return 0 } //HW3
        let red = Int((components[0] * 255).rounded()) //HW3
        let green = Int((components[1] * 255).rounded()) //HW3
        let blue = Int((components[2] * 255).rounded()) //HW3
        return (red << 16) | (green << 8) | blue
    } //HW3
    static func from(hex: Int) -> CGColor { //HW3
        let r = CGFloat((hex >> 16) & 0xFF) / 255.0 //HW3
        let g = CGFloat((hex >> 8) & 0xFF) / 255.0 //HW3
        let b = CGFloat(hex & 0xFF) / 255.0 //HW3
        return CGColor(red: r, green: g, blue: b, alpha: 1.0) //HW3
    } //HW3
} //HW3

// MARK: -  UIColorPickerViewControllerDelegate
extension WishMakerViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        view.backgroundColor = viewController.selectedColor
        defaults.set(viewController.selectedColor.hex, forKey: Constants.backgroundDefaults) //HW3
    }
}


