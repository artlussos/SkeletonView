//
//  Copyright SkeletonView. All Rights Reserved.
//
//  Licensed under the MIT License (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      https://opensource.org/licenses/MIT
//
//  UIView+AssociatedObjects.swift
//
//  Created by Juanpe Catalán on 18/8/21.

import UIKit

// codebeat:disable[TOO_MANY_IVARS]
enum ViewAssociatedKeys {

    static var skeletonable = "skeletonable"
    static var hiddenWhenSkeletonIsActive = "hiddenWhenSkeletonIsActive"
    static var status = "status"
    static var skeletonLayer = "layer"
    static var flowDelegate = "flowDelegate"
    static var isSkeletonAnimated = "isSkeletonAnimated"
    static var viewState = "viewState"
    static var labelViewState = "labelViewState"
    static var imageViewState = "imageViewState"
    static var buttonViewState = "buttonViewState"
    static var headerFooterViewState = "headerFooterViewState"
    static var currentSkeletonConfig = "currentSkeletonConfig"
    static var skeletonCornerRadius = "skeletonCornerRadius"
    static var disabledWhenSkeletonIsActive = "disabledWhenSkeletonIsActive"
    static var delayedShowSkeletonWorkItem = "delayedShowSkeletonWorkItem"

}
// codebeat:enable[TOO_MANY_IVARS]

extension UIView {

    enum SkeletonStatus {
        case on
        case off
    }

    var _flowDelegate: SkeletonFlowDelegate? {
        get { withUnsafePointer(to: &ViewAssociatedKeys.flowDelegate) { return ao_get(pkey: $0) as? SkeletonFlowDelegate } }
        set { withUnsafePointer(to: &ViewAssociatedKeys.flowDelegate) {ao_setOptional(newValue, pkey: $0) }  }
    }

    var _skeletonLayer: SkeletonLayer? {
        get { withUnsafePointer(to: &ViewAssociatedKeys.skeletonLayer) { return ao_get(pkey: $0) as? SkeletonLayer } }
        set { withUnsafePointer(to: &ViewAssociatedKeys.skeletonLayer) {ao_setOptional(newValue, pkey: $0) }  }
    }

    var _currentSkeletonConfig: SkeletonConfig? {
        get { withUnsafePointer(to: &ViewAssociatedKeys.currentSkeletonConfig) { return ao_get(pkey: $0) as? SkeletonConfig } }
        set { withUnsafePointer(to: &ViewAssociatedKeys.currentSkeletonConfig) {ao_setOptional(newValue, pkey: $0) }  }
    }

    var _status: SkeletonStatus {
        get { withUnsafePointer(to: &ViewAssociatedKeys.status) { return ao_get(pkey: $0) as? SkeletonStatus ?? .off } }
        set { withUnsafePointer(to: &ViewAssociatedKeys.status) {ao_set(newValue, pkey: $0) }  }
    }

    var _isSkeletonAnimated: Bool {
        get { withUnsafePointer(to: &ViewAssociatedKeys.isSkeletonAnimated) { return ao_get(pkey: $0) as? Bool ?? false } }
        set { withUnsafePointer(to: &ViewAssociatedKeys.isSkeletonAnimated) {ao_set(newValue, pkey: $0) }  }
    }

    var _delayedShowSkeletonWorkItem: DispatchWorkItem? {
        get { withUnsafePointer(to: &ViewAssociatedKeys.delayedShowSkeletonWorkItem) { return ao_get(pkey: $0) as? DispatchWorkItem } }
        set { withUnsafePointer(to: &ViewAssociatedKeys.delayedShowSkeletonWorkItem) {ao_setOptional(newValue, pkey: $0) }  }
    }

    var _skeletonable: Bool {
        get { withUnsafePointer(to: &ViewAssociatedKeys.skeletonable) { return ao_get(pkey: $0) as? Bool ?? false } }
        set { withUnsafePointer(to: &ViewAssociatedKeys.skeletonable) {ao_set(newValue, pkey: $0) }  }
    }

    var _hiddenWhenSkeletonIsActive: Bool {
        get { withUnsafePointer(to: &ViewAssociatedKeys.hiddenWhenSkeletonIsActive) { return ao_get(pkey: $0) as? Bool ?? false } }
        set { withUnsafePointer(to: &ViewAssociatedKeys.hiddenWhenSkeletonIsActive) {ao_set(newValue, pkey: $0) }  }
    }

    var _disabledWhenSkeletonIsActive: Bool {
        get { withUnsafePointer(to: &ViewAssociatedKeys.disabledWhenSkeletonIsActive) { return ao_get(pkey: $0) as? Bool ?? true } }
        set { withUnsafePointer(to: &ViewAssociatedKeys.disabledWhenSkeletonIsActive) {ao_set(newValue, pkey: $0) }  }
    }

    var _skeletonableCornerRadius: Float {
        get { withUnsafePointer(to: &ViewAssociatedKeys.skeletonCornerRadius) { return ao_get(pkey: $0) as? Float ?? SkeletonViewAppearance.shared.skeletonCornerRadius } }
        set { withUnsafePointer(to: &ViewAssociatedKeys.skeletonCornerRadius) {ao_set(newValue, pkey: $0) }  }
    }
}
