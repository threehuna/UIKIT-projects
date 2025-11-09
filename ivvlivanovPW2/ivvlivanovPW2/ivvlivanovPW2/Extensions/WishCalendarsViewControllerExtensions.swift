//
//  WishCalendarsViewControllerExtensions.swift
//  ivvlivanovPW2
//
//  Created by Иван Иванов on 31.10.2025.
//

import UIKit

// MARK: - UICollectionViewDataSource
extension WishCalendarViewController: UICollectionViewDataSource { //HW4
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return events.count
    }
    func collectionView(
        _
        collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WishEventCell.reuseIdentifier,
            for: indexPath
        )
        
        guard let wishEventCell = cell as? WishEventCell else {
            return cell
        }

        let model = events[indexPath.item]

        wishEventCell.configure(with: model)
        
        return wishEventCell
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension WishCalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _
        collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 10, height: 100)
    }
    func collectionView(
        _
        collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print("Cell tapped at index \(indexPath.item)")
    }
}
