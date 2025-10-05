//
//  WrittenWishCell.swift
//  ivvlivanovPW2
//
//  Created by Иван Иванов on 30.09.2025.
//
import UIKit

final class WrittenWishCell: UITableViewCell { //HW3
//    static let reuseId: String = "WrittenWishCell" //HW3
    var onDelete: (() -> Void)?
    private enum Constants { //HW3
        static let wrapColor: UIColor = .white //HW3
        static let wrapRadius: CGFloat = 16 //HW3
        static let wrapOffsetV: CGFloat = 5 //HW3
        static let wrapOffsetH: CGFloat = 10 //HW3
        static let wishLabelOffset: CGFloat = 8 //HW3
        
        static let trashImageSize: CGFloat = 24
        
        static let wishLabelWithAnchor: CGFloat = 0.8
        
    } //HW3
    private let wishLabel: UILabel = UILabel() //HW3
    let button: UIButton = UIButton(type: .system) //HW3
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) { //HW3
        super.init(style: style, reuseIdentifier: reuseIdentifier) //HW3
        configureUI() //HW3
    } //HW3
    @available(*, unavailable) //HW3
    required init?(coder: NSCoder) { //HW3
        fatalError("init(coder:) has not been implemented") //HW3
    } //HW3
    func configure(with wish: String) { //HW3
        wishLabel.text = wish //HW3
    } //HW3
    override func prepareForReuse() {
        super.prepareForReuse()
        wishLabel.text = nil
    }
    private func configureUI() { //HW3
        selectionStyle = .none //HW3
        backgroundColor = .clear //HW3
        let wrap: UIView = UIView() //HW3
        contentView.addSubview(wrap) //HW3
        wrap.backgroundColor = Constants.wrapColor //HW3
        wrap.layer.cornerRadius = Constants.wrapRadius //HW3
        wrap.pinVertical(to: contentView, Constants.wrapOffsetV) //HW3
        wrap.pinHorizontal(to: contentView, Constants.wrapOffsetH) //HW3
        wrap.addSubview(wishLabel) //HW3
        wishLabel.translatesAutoresizingMaskIntoConstraints = false //HW3
        wishLabel.pin(to: wrap, Constants.wishLabelOffset) //HW3
        wishLabel.widthAnchor.constraint(lessThanOrEqualTo: wrap.widthAnchor, multiplier: Constants.wishLabelWithAnchor).isActive = true //HW3
        
        wrap.addSubview(button) //HW3
        wrap.addSubview(button) //HW3
        button.setImage(UIImage(systemName: "trash"), for: .normal) //HW3
        button.tintColor = .black //HW3
        button.pinRight(to: wrap, Constants.wishLabelOffset) //HW3
        button.pinCenterY(to: wrap) //HW3
        button.setWidth(Constants.trashImageSize).isActive = true //HW3
        button.setHeight(Constants.trashImageSize).isActive = true //HW3
        button.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside) //HW3

        
    } //HW3
    
    @objc private func deleteTapped(){ //HW3
        onDelete?() //HW3
    } //HW3
} //HW3
