//
//  WishCalendarViewController.swift
//  ivvlivanovPW2
//
//  Created by Иван Иванов on 31.10.2025.
//

import UIKit

final class WishCalendarViewController: UIViewController { //HW4
    
    
    private var backgroundColor: UIColor
    private let createEventButton: UIButton = .init(type: .system)
    
    
    init(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    var events: [WishEventModel] = []
    private let collectionView: UICollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    private enum Constants {
        static let wishCalendarTitle: String = "Wish Calendar"
        static let contentInset: UIEdgeInsets = .init(top: 20, left: 10, bottom: 20, right: 10)
        static let collectionTop: CGFloat = 10
        static let createEventButtonTitle: String = "+"
       
        static let buttonHeight: CGFloat = 60
        static let buttonSide: CGFloat = 170
        static let buttonCreateEventBottom: CGFloat = 25
        static let buttonWidth: CGFloat = 40
        static let createEventButtonFontSize: CGFloat = 35
        
        static let collectionMinimumInteritemSpacing: CGFloat = 0
        static let collectionMinimumLineSpacing: CGFloat = 0
        
        static let eventButtonColor: UIColor = .white
        
        static let eventButtonRatio: CGFloat = 2
    }
    
    override func viewDidLoad() {
        self.loadEvents()
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        title = Constants.wishCalendarTitle
        configureCollection()
        configureCreateEventButton()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        createEventButton.layer.cornerRadius = createEventButton.frame.height / Constants.eventButtonRatio
    }

    private func loadEvents() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            do {
                let items = try CoreDataManager.shared.fetchEvents()
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.events = items
                    self.collectionView.reloadData()
                }
            } catch {
               
            }
        }
    }

    
    private func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = backgroundColor
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = Constants.contentInset
        
        
        if let layout = collectionView.collectionViewLayout as?
            UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = Constants.collectionMinimumInteritemSpacing
            layout.minimumLineSpacing = Constants.collectionMinimumLineSpacing
            layout.invalidateLayout()
        }
        collectionView.register(
            WishEventCell.self,
            forCellWithReuseIdentifier: WishEventCell.reuseIdentifier
        )
        view.addSubview(collectionView)
        collectionView.pinHorizontal(to: view)
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        collectionView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.collectionTop)
    }
    private func configureCreateEventButton() {
        createEventButton.translatesAutoresizingMaskIntoConstraints = false
        createEventButton.setTitle(Constants.createEventButtonTitle, for: .normal)
        createEventButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.createEventButtonFontSize)
        createEventButton.setTitleColor(backgroundColor, for: .normal)
        createEventButton.backgroundColor = Constants.eventButtonColor
        createEventButton.layer.masksToBounds = true

        view.addSubview(createEventButton)

        createEventButton.setHeight(Constants.buttonHeight)
        createEventButton.setWidth(Constants.buttonWidth)
        createEventButton.pinBottom(to: view, Constants.buttonCreateEventBottom)
        createEventButton.pinHorizontal(to: view, Constants.buttonSide)

        createEventButton.addTarget(self, action: #selector(createEventButtonPressed), for: .touchUpInside)
    }
    
    @objc private func createEventButtonPressed() {
        let creationVC = WishEventCreationView(backgroundColor: backgroundColor)
        creationVC.onSave = { [weak self] in
            self?.loadEvents()
        }
        let nav = UINavigationController(rootViewController: creationVC)
        present(nav, animated: true)
    }
}

