//
//  Copyright SkeletonView. All Rights Reserved.
//
//  Licensed under the MIT License (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      https://opensource.org/licenses/MIT
//
//  SkeletonTextNode.swift
//
//  Created by Juanpe Catalán on 19/8/21.

import UIKit

protocol SkeletonTextNode {

    var textLineHeight: SkeletonTextLineHeight { get }
    var estimatedLineHeight: CGFloat { get }
    var estimatedNumberOfLines: Int { get }
    var textAlignment: NSTextAlignment { get }
    var lastLineFillingPercent: Int { get }
    var multilineCornerRadius: Int { get }
    var multilineSpacing: CGFloat { get }
    var paddingInsets: UIEdgeInsets { get }
    var shouldCenterTextVertically: Bool { get }

}

enum SkeletonTextNodeAssociatedKeys {

    static var lastLineFillingPercent = "lastLineFillingPercent"
    static var multilineCornerRadius = "multilineCornerRadius"
    static var multilineSpacing = "multilineSpacing"
    static var paddingInsets = "paddingInsets"
    static var backupHeightConstraints = "backupHeightConstraints"
    static var textLineHeight = "textLineHeight"
    static var skeletonNumberOfLines = "skeletonNumberOfLines"

}

extension UILabel: SkeletonTextNode {

    var estimatedLineHeight: CGFloat {
        switch textLineHeight {
        case .fixed(let height):
            return height
        case .relativeToFont:
            return fontLineHeight ?? SkeletonAppearance.default.multilineHeight
        case .relativeToConstraints:
            guard let constraintsLineHeight = heightConstraints.first?.constant,
                  estimatedNumberOfLines != 0 else {
                return SkeletonAppearance.default.multilineHeight
            }

            return constraintsLineHeight / CGFloat(estimatedNumberOfLines)
        }
    }

    var textLineHeight: SkeletonTextLineHeight {
        get { withUnsafePointer(to: &SkeletonTextNodeAssociatedKeys.textLineHeight) { return ao_get(pkey: $0) as? SkeletonTextLineHeight ?? SkeletonAppearance.default.textLineHeight } }
        set { withUnsafePointer(to: &SkeletonTextNodeAssociatedKeys.textLineHeight) {ao_set(newValue, pkey: $0) }  }
    }

    var skeletonNumberOfLines: SkeletonTextNumberOfLines {
        get { withUnsafePointer(to: &SkeletonTextNodeAssociatedKeys.skeletonNumberOfLines) { return ao_get(pkey: $0) as? SkeletonTextNumberOfLines ?? SkeletonTextNumberOfLines.inherited } }
        set { withUnsafePointer(to: &SkeletonTextNodeAssociatedKeys.skeletonNumberOfLines) {ao_set(newValue, pkey: $0) }  }
    }

    var estimatedNumberOfLines: Int {
        switch skeletonNumberOfLines {
        case .inherited:
            return numberOfLines
        case .custom(let lines):
            return lines >= 0 ? lines : 1
        }
    }

    var lastLineFillingPercent: Int {
        get { withUnsafePointer(to: &SkeletonTextNodeAssociatedKeys.lastLineFillingPercent) { return ao_get(pkey: $0) as? Int ?? SkeletonAppearance.default.multilineLastLineFillPercent } }
        set { withUnsafePointer(to: &SkeletonTextNodeAssociatedKeys.lastLineFillingPercent) {ao_set(newValue, pkey: $0) }  }
    }

    var multilineCornerRadius: Int {
        get { withUnsafePointer(to: &SkeletonTextNodeAssociatedKeys.multilineCornerRadius) { return ao_get(pkey: $0) as? Int ?? SkeletonAppearance.default.multilineCornerRadius } }
        set { withUnsafePointer(to: &SkeletonTextNodeAssociatedKeys.multilineCornerRadius) {ao_set(newValue, pkey: $0) }  }
    }

    var multilineSpacing: CGFloat {
        get { withUnsafePointer(to: &SkeletonTextNodeAssociatedKeys.multilineSpacing) { return ao_get(pkey: $0) as? CGFloat ?? SkeletonAppearance.default.multilineSpacing } }
        set { withUnsafePointer(to: &SkeletonTextNodeAssociatedKeys.multilineSpacing) {ao_set(newValue, pkey: $0) }  }
    }

    var paddingInsets: UIEdgeInsets {
        get { withUnsafePointer(to: &SkeletonTextNodeAssociatedKeys.paddingInsets) { return ao_get(pkey: $0) as? UIEdgeInsets ?? .zero } }
        set { withUnsafePointer(to: &SkeletonTextNodeAssociatedKeys.paddingInsets) {ao_set(newValue, pkey: $0) }  }
    }

    var backupHeightConstraints: [NSLayoutConstraint] {
        get { withUnsafePointer(to: &SkeletonTextNodeAssociatedKeys.backupHeightConstraints) { return ao_get(pkey: $0) as? [NSLayoutConstraint] ?? [] } }
        set { withUnsafePointer(to: &SkeletonTextNodeAssociatedKeys.backupHeightConstraints) {ao_set(newValue, pkey: $0) }  }
    }

    var shouldCenterTextVertically: Bool {
        true
    }

    var fontLineHeight: CGFloat? {
        if let attributedText = attributedText,
           attributedText.length > 0 {
            let attributes = attributedText.attributes(at: 0, effectiveRange: nil)
            let fontAttribute = attributes.first(where: { $0.key == .font })
            return fontAttribute?.value as? CGFloat ?? font.lineHeight
        } else {
            return font.lineHeight
        }
    }

}

extension UITextView: SkeletonTextNode {

    var estimatedLineHeight: CGFloat {
        switch textLineHeight {
        case .fixed(let height):
            return height
        case .relativeToFont:
            return fontLineHeight ?? SkeletonAppearance.default.multilineHeight
        case .relativeToConstraints:
            return SkeletonAppearance.default.multilineHeight
        }
    }

    var textLineHeight: SkeletonTextLineHeight {
        get { withUnsafePointer(to: &SkeletonTextNodeAssociatedKeys.textLineHeight) { return ao_get(pkey: $0) as? SkeletonTextLineHeight ?? SkeletonAppearance.default.textLineHeight } }
        set { withUnsafePointer(to: &SkeletonTextNodeAssociatedKeys.textLineHeight) {ao_set(newValue, pkey: $0) }  }
    }

    var skeletonNumberOfLines: SkeletonTextNumberOfLines {
        get { withUnsafePointer(to: &SkeletonTextNodeAssociatedKeys.skeletonNumberOfLines) { return ao_get(pkey: $0) as? SkeletonTextNumberOfLines ?? SkeletonTextNumberOfLines.inherited } }
        set { withUnsafePointer(to: &SkeletonTextNodeAssociatedKeys.skeletonNumberOfLines) {ao_set(newValue, pkey: $0) }  }
    }

    var estimatedNumberOfLines: Int {
        switch skeletonNumberOfLines {
        case .inherited:
            return -1
        case .custom(let lines):
            return lines >= -1 ? lines : 1
        }
    }

    var lastLineFillingPercent: Int {
        get {
            let defaultValue = SkeletonAppearance.default.multilineLastLineFillPercent
            return withUnsafePointer(to: &SkeletonTextNodeAssociatedKeys.lastLineFillingPercent) { return ao_get(pkey: $0) as? Int ?? defaultValue }
        }
        set { withUnsafePointer(to: &SkeletonTextNodeAssociatedKeys.lastLineFillingPercent) {ao_set(newValue, pkey: $0) }  }
    }

    var multilineCornerRadius: Int {
        get {
            let defaultValue = SkeletonAppearance.default.multilineCornerRadius
            return withUnsafePointer(to: &SkeletonTextNodeAssociatedKeys.multilineCornerRadius) { return ao_get(pkey: $0) as? Int ?? defaultValue }
        }
        set { withUnsafePointer(to: &SkeletonTextNodeAssociatedKeys.multilineCornerRadius) {ao_set(newValue, pkey: $0) }  }
    }

    var multilineSpacing: CGFloat {
        get { withUnsafePointer(to: &SkeletonTextNodeAssociatedKeys.multilineSpacing) { return ao_get(pkey: $0) as? CGFloat ?? SkeletonAppearance.default.multilineSpacing } }
        set { withUnsafePointer(to: &SkeletonTextNodeAssociatedKeys.multilineSpacing) {ao_set(newValue, pkey: $0) }  }
    }

    var paddingInsets: UIEdgeInsets {
        get { withUnsafePointer(to: &SkeletonTextNodeAssociatedKeys.paddingInsets) { return ao_get(pkey: $0) as? UIEdgeInsets ?? .zero } }
        set { withUnsafePointer(to: &SkeletonTextNodeAssociatedKeys.paddingInsets) {ao_set(newValue, pkey: $0) }  }
    }

    var shouldCenterTextVertically: Bool {
        false
    }

    var fontLineHeight: CGFloat? {
        if let attributedText = attributedText,
           attributedText.length > 0 {
            let attributes = attributedText.attributes(at: 0, effectiveRange: nil)
            let fontAttribute = attributes.first(where: { $0.key == .font })
            return fontAttribute?.value as? CGFloat ?? font?.lineHeight
        } else {
            return font?.lineHeight
        }
    }

}
