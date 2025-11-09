//
//  ViewController.swift
//  ivvlivanovPW2
//
//  Created by Иван Иванов on 20.09.2025.
//

import UIKit


final class WishMakerViewController: UIViewController {
    
    private var titleView: UILabel!
    private var redValue: CGFloat = 0
    private var greenValue: CGFloat = 0
    private var blueValue: CGFloat = 0
    private var isSlidersShown: Bool = true
    private weak var slidersStack: UIStackView?
    private weak var toggleButton: UIButton?
    
    private let defaults = UserDefaults.standard //HW3
    
    private let buttonForSlider: UIButton = UIButton(type: .system) //HW4
    private let buttonForPicker: UIButton = UIButton(type: .system) //HW4
    private let buttonForBg: UIButton = UIButton(type: .system) //HW4
    private let addWishButton: UIButton = UIButton(type: .system) //HW3
    private let sheduleWishesButton: UIButton = UIButton(type: .system) //HW4
    
    private var buttonsTextColor: UIColor = Constants.initialBackground //HW4
    
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
        static let buttonTop: CGFloat = 175 //HW3
        static let buttonWidth: CGFloat = 150
        static let buttonHeight: CGFloat = 40
        
        
        static let buttonBGLEading: CGFloat = 210
        static let buttonBGTitle: String = "Change bg randomly"
        
        static let buttonPickerTitle: String = "Pick a color"
        static let buttonPickerTop: CGFloat = 230 //HW3
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
        
        static let buttonAddWishBottom: CGFloat = 72 //HW3
        static let buttonSide: CGFloat = 20 //HW3
        static let buttonAddWishText: String = "Add Your Wish" //HW3
        
        static let buttonSheduleWishesBottom: CGFloat = 25 //HW4
        static let buttonSheduleWishesText: String = "Shedule wish granting" //HW4
        
        static let hexWhite: Int = 0xFFFFFF
        
        static let descrtiptionLeading: CGFloat = 20
        static let descriptionTop: CGFloat = 70
        
        static let buttonFontSize: CGFloat = 18
        
        static let initialBackground: UIColor = .systemPink
        static let stackDefaultBackground: UIColor = .white
        
        static let backgroundDefaults: String = "BGDefault" //HW3
        static let stackColorDefaults: String = "StackDefault" //HW3
        static let buttonTextColorDefaults: String = "DuttonTextColorDefault" //HW4
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
       
       if let hex = defaults.value(forKey: Constants.buttonTextColorDefaults) as? Int {
           let savedButtonColor = UIColor(hex: hex)
           addWishButton.setTitleColor(savedButtonColor, for: .normal)
           sheduleWishesButton.setTitleColor(savedButtonColor, for: .normal)
           buttonForPicker.setTitleColor(savedButtonColor, for: .normal)
           buttonForBg.setTitleColor(savedButtonColor, for: .normal)
           buttonForSlider.setTitleColor(savedButtonColor, for: .normal)
           buttonsTextColor = savedButtonColor
       }

       
       configureTitle()
       configureDescription()
       configureButtonForSliders()
       configureButtonForBackgroundColor()
       configureButtonForPicker()
       configureSliders()
       configureAddWishButton()
       configureSheduleWishesButton()
       
      
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
        buttonForSlider.translatesAutoresizingMaskIntoConstraints = false
        buttonForSlider.setTitle(isSlidersShown ? Constants.buttonTitleWhenSlidersShown : Constants.buttonTitleWhenSlidersHidden, for: .normal)
        buttonForSlider.setTitleColor(buttonsTextColor, for: .normal)
        buttonForSlider.backgroundColor = UIColor(hex: Constants.hexWhite)
        buttonForSlider.layer.cornerRadius = Constants.buttonRadius
       
       
        
        buttonForSlider.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        view.addSubview(buttonForSlider)
        toggleButton = buttonForSlider
        
        NSLayoutConstraint.activate([
            buttonForSlider.pinLeft(to: view, Constants.buttonLeading),
            buttonForSlider.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.buttonTop),
            buttonForSlider.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            buttonForSlider.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])

    }
    
    private func configureButtonForBackgroundColor() {
        buttonForBg.translatesAutoresizingMaskIntoConstraints = false
        buttonForBg.setTitle(Constants.buttonBGTitle, for: .normal)
        buttonForBg.setTitleColor(buttonsTextColor, for: .normal)
        buttonForBg.backgroundColor = UIColor(hex: Constants.hexWhite)
        buttonForBg.layer.cornerRadius = Constants.buttonRadius
        buttonForBg.sizeToFit()
        
        
        buttonForBg.addTarget(self, action: #selector(bgButtonTapped), for: .touchUpInside)
        
        view.addSubview(buttonForBg)
        NSLayoutConstraint.activate([
            buttonForBg.pinLeft(to: view, Constants.buttonBGLEading),
            buttonForBg.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.buttonTop),
            buttonForBg.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            buttonForBg.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
    }
    
    private func configureButtonForPicker() {
        buttonForPicker.translatesAutoresizingMaskIntoConstraints = false
        buttonForPicker.setTitle(Constants.buttonPickerTitle, for: .normal)
        buttonForPicker.setTitleColor(buttonsTextColor, for: .normal)
        buttonForPicker.backgroundColor = UIColor(hex: Constants.hexWhite)
        buttonForPicker.layer.cornerRadius = Constants.buttonRadius
        buttonForPicker.sizeToFit()
        
        
        buttonForPicker.addTarget(self, action: #selector(presentColorPicker), for: .touchUpInside)
        
        view.addSubview(buttonForPicker)
       
        buttonForPicker.pinLeft(to: view, Constants.buttonPickerLeading)
        buttonForPicker.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.buttonPickerTop)
        buttonForPicker.setWidth(Constants.buttonWidth)
        buttonForPicker.setHeight(Constants.buttonHeight)
        
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
        addWishButton.pinBottom(to: view, Constants.buttonAddWishBottom) //HW3
        addWishButton.pinHorizontal(to: view, Constants.buttonSide) //HW3
        addWishButton.backgroundColor = .white //HW3
        addWishButton.setTitleColor(buttonsTextColor, for: .normal) //HW3
        addWishButton.setTitle(Constants.buttonAddWishText, for: .normal) //HW3
        addWishButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonFontSize) //HW3
    
        addWishButton.layer.cornerRadius = Constants.buttonRadius //HW3
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside) //HW3
        
    } //HW3
    
    private func configureSheduleWishesButton() { //HW4
        view.addSubview(sheduleWishesButton) //HW4
        sheduleWishesButton.setHeight(Constants.buttonHeight) //HW4
        sheduleWishesButton.pinBottom(to: view, Constants.buttonSheduleWishesBottom) //HW4
        sheduleWishesButton.pinHorizontal(to: view, Constants.buttonSide) //HW4
        sheduleWishesButton.backgroundColor = .white //HW4
        sheduleWishesButton.setTitleColor(buttonsTextColor, for: .normal) //HW4
        sheduleWishesButton.setTitle(Constants.buttonSheduleWishesText, for: .normal) //HW4
        sheduleWishesButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonFontSize) //HW4
    
        sheduleWishesButton.layer.cornerRadius = Constants.buttonRadius //HW4
        sheduleWishesButton.addTarget(self, action: #selector(sheduleWishesButtonPressed), for: .touchUpInside) //HW4
        
    } //HW4
    
    private func updateBackgroundColor() { //HW4
        let color = UIColor( //HW4
            red: redValue, //HW4
            green: greenValue, //HW4
            blue: blueValue, //HW4
            alpha: 1 //HW4
        ) //HW4
        
        view.backgroundColor = color //HW3
        defaults.set(color.hex, forKey: Constants.backgroundDefaults) //HW3
        
        saveButtonsColor(color: color) //HW4
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
        
       saveButtonsColor(color: color)
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
        present(WishStoringViewController(backgroundColor: buttonsTextColor), animated: true) //HW4
    }
    @objc private func sheduleWishesButtonPressed() { //HW4
        let vc = WishCalendarViewController(backgroundColor: buttonsTextColor) //HW4
        navigationController?.pushViewController(vc, animated: true) //HW4
    } //HW4
    private func saveButtonsColor(color: UIColor) {
        buttonsTextColor = color //HW4
        addWishButton.setTitleColor(color, for: .normal) //HW4
        sheduleWishesButton.setTitleColor(color, for: .normal) //HW4
        buttonForBg.setTitleColor(color, for: .normal)
        buttonForSlider.setTitleColor(color, for: .normal)
        buttonForPicker.setTitleColor(color, for: .normal) //HW4
        defaults.set(color.hex, forKey: Constants.buttonTextColorDefaults) //HW4
    }
}

// MARK: -  UIColorPickerViewControllerDelegate
extension WishMakerViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        view.backgroundColor = viewController.selectedColor
        defaults.set(viewController.selectedColor.hex, forKey: Constants.backgroundDefaults) //HW3
        
        saveButtonsColor(color: viewController.selectedColor)
    }
}
