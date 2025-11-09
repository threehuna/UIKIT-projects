//
//  WishEventCell.swift
//  ivvlivanovPW2
//
//  Created by Иван Иванов on 31.10.2025.
//

import UIKit

class WishEventCell: UICollectionViewCell { //HW4
    
    private enum Constants {
        static let titleFont: UIFont = .systemFont(ofSize: 15, weight: .medium)
        static let descriptionFont: UIFont = .systemFont(ofSize: 14, weight: .regular)
        static let offset: CGFloat = 5
        static let cornerRadius: CGFloat = 16
        static let backgroundColor: UIColor = UIColor(hex: 0x5AC4D3).withAlphaComponent(0.8)
        static let titleTop: CGFloat = 5
        static let titleLeading: CGFloat = 15
        static let dateLabelFontSize: CGFloat = 13
        static let endLabelBottom: CGFloat = 0
        static let numberOfLines: Int = 0
        
        static let textColor: UIColor = .white
    }
    static let reuseIdentifier: String = "WishEventCell"
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureWrap()
        configureTitleLabel()
        configureDescriptionLabel()
        configureStartDateLabel()
        configureEndDateLabel()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Cell Configuration
    func configure(with event: WishEventModel) {
        titleLabel.text = event.title
        titleLabel.textColor = Constants.textColor
        descriptionLabel.text = event.description
        startDateLabel.text = "Start Date: \(event.startDate)"
        endDateLabel.text = "End Date: \(event.endDate)"
    }
    // MARK: - UI Configuration
    private func configureWrap() {
        addSubview(wrapView)
        wrapView.pin(to: self, Constants.offset)
        wrapView.layer.cornerRadius = Constants.cornerRadius
        wrapView.backgroundColor = Constants.backgroundColor
    }
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.textColor = .black
        titleLabel.pinTop(to: wrapView, Constants.titleTop)
        titleLabel.font = Constants.titleFont
        titleLabel.pinLeft(to: wrapView, Constants.titleLeading)
    }
    private func configureDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.textColor = Constants.textColor
        descriptionLabel.font = Constants.descriptionFont
        descriptionLabel.numberOfLines = Constants.numberOfLines
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, Constants.offset)
        descriptionLabel.pinLeft(to: wrapView, Constants.titleLeading)
        descriptionLabel.pinRight(to: wrapView, Constants.titleLeading)
    }

    private func configureStartDateLabel() {
        addSubview(startDateLabel)
        startDateLabel.textColor = Constants.textColor
        startDateLabel.font = .systemFont(ofSize: Constants.dateLabelFontSize, weight: .regular)
        startDateLabel.pinTop(to: descriptionLabel.bottomAnchor, Constants.offset)
        startDateLabel.pinLeft(to: wrapView, Constants.titleLeading)
    }

    private func configureEndDateLabel() {
        addSubview(endDateLabel)
        endDateLabel.textColor = Constants.textColor
        endDateLabel.font = .systemFont(ofSize: Constants.dateLabelFontSize, weight: .regular)
        endDateLabel.pinTop(to: startDateLabel.bottomAnchor, Constants.endLabelBottom)
        endDateLabel.pinLeft(to: wrapView, Constants.titleLeading)
        endDateLabel.pinBottom(to: wrapView, Constants.offset)
    }

}
