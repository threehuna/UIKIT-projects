//
//  AddWishCell.swift
//  ivvlivanovPW2
//
//  Created by Иван Иванов on 30.09.2025.
//
import UIKit

final class AddWishCell: UITableViewCell { //HW3
    enum Constants { //HW3
        static let insetH: CGFloat = 20 //HW3
        static let textTop: CGFloat = 20 //HW3
        static let spacing: CGFloat = 12 //HW3

        static let textViewHeight: CGFloat = 50 //HW3
        static let textViewRadius: CGFloat = 12 //HW3

        static let buttonTitle: String = "Add Your Wish" //HW3
        static let buttonHeight: CGFloat = 40 //HW3
        static let buttonRadius: CGFloat = 12 //HW3
        static let buttonBottom: CGFloat = 20 //HW3
        
        static let buttonInsetsRightLeft: CGFloat = 16
        static let buttonInsetsTopBottom: CGFloat = 0
        
        static let fontSize: CGFloat = 16
        static let bordreWidth: CGFloat = 1
    } //HW3

    var addWish: ((String) -> Void)? //HW3
    
    private let addWishButton2 = UIButton(type: .system) //HW3
    private let textView = UITextView() //HW3

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) { //HW3
        super.init(style: style, reuseIdentifier: reuseIdentifier) //HW3
        selectionStyle = .none //HW3
        backgroundColor = .clear //HW3

        configureTextView() //HW3
        configureAddWishButton() //HW3
    } //HW3

    @available(*, unavailable) //HW3
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") } //HW3

    private func configureTextView() { //HW3
        contentView.addSubview(textView) //HW3
        textView.translatesAutoresizingMaskIntoConstraints = false //HW3
        textView.layer.cornerRadius = Constants.textViewRadius //HW3
        textView.layer.borderWidth = Constants.bordreWidth //HW3
        textView.layer.borderColor = UIColor.gray.cgColor //HW3
        textView.font = .systemFont(ofSize: Constants.fontSize) //HW3

        textView.pinTop(to: contentView, Constants.textTop) //HW3
        textView.pinHorizontal(to: contentView, Constants.insetH) //HW3
        textView.setHeight(Constants.textViewHeight) //HW3
    } //HW3

    private func configureAddWishButton() { //HW3
        contentView.addSubview(addWishButton2) //HW3
        addWishButton2.translatesAutoresizingMaskIntoConstraints = false //HW3
        addWishButton2.setTitle(Constants.buttonTitle, for: .normal) //HW3
        addWishButton2.setTitleColor(.black, for: .normal) //HW3
        addWishButton2.backgroundColor = .white //HW3
        addWishButton2.layer.cornerRadius = Constants.buttonRadius //HW3
        addWishButton2.titleLabel?.font = .boldSystemFont(ofSize: Constants.fontSize) //HW3
        addWishButton2.contentEdgeInsets = UIEdgeInsets(top: Constants.buttonInsetsTopBottom, left: Constants.buttonInsetsRightLeft, bottom: Constants.buttonInsetsTopBottom, right: Constants.buttonInsetsRightLeft) //HW3

        addWishButton2.pinCenterX(to: contentView) //HW3
        addWishButton2.setHeight(Constants.buttonHeight) //HW3
        addWishButton2.pinBottom(to: contentView, Constants.buttonBottom) //HW3
        addWishButton2.pinTop(to: textView.bottomAnchor, Constants.spacing) //HW3

        addWishButton2.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside) //HW3
    } //HW3

    @objc private func didTapAdd() { //HW3
        let raw = textView.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "" //HW3
        guard !raw.isEmpty else { return } //HW3
        addWish?(raw) //HW3
        textView.text = "" //HW3
    } //HW3

    override func prepareForReuse() { //HW3
        super.prepareForReuse() //HW3
        textView.text = "" //HW3
    } //HW3
} //HW3
