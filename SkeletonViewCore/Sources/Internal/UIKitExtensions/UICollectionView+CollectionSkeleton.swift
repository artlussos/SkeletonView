//
//  UICollectionView+CollectionSkeleton.swift
//  SkeletonView-iOS
//
//  Created by Juanpe Catalán on 02/02/2018.
//  Copyright © 2018 SkeletonView. All rights reserved.
//

import UIKit

extension UICollectionView: CollectionSkeleton {

    var estimatedNumberOfRows: Int {
        guard let flowlayout = collectionViewLayout as? UICollectionViewFlowLayout else { return 0 }
        switch flowlayout.scrollDirection {
        case .vertical:
            return Int(ceil(frame.height / flowlayout.itemSize.height))
        case .horizontal:
            return Int(ceil(frame.width / flowlayout.itemSize.width))
        default:
            return 0
        }
    }

    var skeletonDataSource: SkeletonCollectionDataSource? {
        get {
            withUnsafePointer(to: &CollectionAssociatedKeys.dummyDataSource) {
                return ao_get(pkey: $0) as? SkeletonCollectionDataSource
            }
        }

        set {
            withUnsafePointer(to: &CollectionAssociatedKeys.dummyDataSource)  {
                ao_setOptional(newValue, pkey: $0)
                self.dataSource = newValue
            }
        }
    }

    var skeletonDelegate: SkeletonCollectionDelegate? {
        get {
            withUnsafePointer(to: &CollectionAssociatedKeys.dummyDelegate)  {
                return ao_get(pkey: $0) as? SkeletonCollectionDelegate
            }
        }
        set {
            withUnsafePointer(to: &CollectionAssociatedKeys.dummyDelegate)  {
                ao_setOptional(newValue, pkey: $0)
                self.delegate = newValue
            }
        }
    }

    func addDummyDataSource() {
        guard let originalDataSource = self.dataSource as? SkeletonCollectionViewDataSource,
            !(originalDataSource is SkeletonCollectionDataSource)
            else { return }

        let dataSource = SkeletonCollectionDataSource(collectionViewDataSource: originalDataSource)
        self.skeletonDataSource = dataSource
        reloadData()
    }

    func updateDummyDataSource() {
        if (dataSource as? SkeletonCollectionDataSource) != nil {
            reloadData()
        } else {
            addDummyDataSource()
        }
    }

    func removeDummyDataSource(reloadAfter: Bool) {
        guard let dataSource = self.dataSource as? SkeletonCollectionDataSource else { return }
        self.skeletonDataSource = nil
        self.dataSource = dataSource.originalCollectionViewDataSource
        if reloadAfter { self.reloadData() }
    }

}
