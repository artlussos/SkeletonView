//
//  Recoverable.swift
//  SkeletonView
//
//  Created by Juanpe Catalán on 13/05/2018.
//  Copyright © 2018 SkeletonView. All rights reserved.
//

import UIKit

protocol Recoverable {
    func saveViewState()
    func recoverViewState(forced: Bool)
}

extension UIView: Recoverable {

    var viewState: RecoverableViewState? {
        get { withUnsafePointer(to: &ViewAssociatedKeys.viewState) { return ao_get(pkey: $0) as? RecoverableViewState } }
        set { withUnsafePointer(to: &ViewAssociatedKeys.viewState) {ao_setOptional(newValue, pkey: $0) }  }
    }

    @objc func saveViewState() {
        viewState = RecoverableViewState(view: self)
    }

    @objc func recoverViewState(forced: Bool) {
        guard let storedViewState = viewState else { return }

        startTransition { [weak self] in
            guard let self = self else { return }

            self.layer.cornerRadius = storedViewState.cornerRadius
            self.layer.masksToBounds = storedViewState.clipToBounds

            if self.isUserInteractionDisabledWhenSkeletonIsActive {
                self.isUserInteractionEnabled = storedViewState.isUserInteractionsEnabled
            }

            if self.backgroundColor == .clear || forced {
                self.backgroundColor = storedViewState.backgroundColor
            }
        }
    }

}

extension UILabel {

    var labelState: RecoverableTextViewState? {
        get { withUnsafePointer(to: &ViewAssociatedKeys.labelViewState) { return ao_get(pkey: $0) as? RecoverableTextViewState } }
        set { withUnsafePointer(to: &ViewAssociatedKeys.labelViewState) {ao_setOptional(newValue, pkey: $0) }  }
    }

    override func saveViewState() {
        super.saveViewState()
        labelState = RecoverableTextViewState(view: self)
    }

    override func recoverViewState(forced: Bool) {
        super.recoverViewState(forced: forced)
        startTransition { [weak self] in
            guard let self = self,
                  let storedLabelState = self.labelState else {
                return
            }

            NSLayoutConstraint.deactivate(self.skeletonHeightConstraints)
            self.restoreBackupHeightConstraintsIfNeeded()

            if self.textColor == .clear || forced {
                self.textColor = storedLabelState.textColor
            }
        }
    }

}

extension UITextView {

    var textState: RecoverableTextViewState? {
        get { withUnsafePointer(to: &ViewAssociatedKeys.labelViewState) { return ao_get(pkey: $0) as? RecoverableTextViewState } }
        set { withUnsafePointer(to: &ViewAssociatedKeys.labelViewState) {ao_setOptional(newValue, pkey: $0) }  }
    }

    override func saveViewState() {
        super.saveViewState()
        textState = RecoverableTextViewState(view: self)
    }

    override func recoverViewState(forced: Bool) {
        super.recoverViewState(forced: forced)
        startTransition { [weak self] in
            guard let storedLabelState = self?.textState else { return }

            if self?.textColor == .clear || forced {
                self?.textColor = storedLabelState.textColor
            }
        }
    }

}

extension UITextField {

    var textState: RecoverableTextFieldState? {
        get { withUnsafePointer(to: &ViewAssociatedKeys.labelViewState) { return ao_get(pkey: $0) as? RecoverableTextFieldState } }
        set { withUnsafePointer(to: &ViewAssociatedKeys.labelViewState) {ao_setOptional(newValue, pkey: $0) }  }
    }

    override func saveViewState() {
        super.saveViewState()
        textState = RecoverableTextFieldState(view: self)
    }

    override func recoverViewState(forced: Bool) {
        super.recoverViewState(forced: forced)
        startTransition { [weak self] in
            guard let storedLabelState = self?.textState else { return }

            if self?.textColor == .clear || forced {
                self?.textColor = storedLabelState.textColor
            }

            if self?.placeholder == nil || forced {
                self?.placeholder = storedLabelState.placeholder
            }
        }
    }

}

extension UIImageView {

    var imageState: RecoverableImageViewState? {
        get { withUnsafePointer(to: &ViewAssociatedKeys.imageViewState) { return ao_get(pkey: $0) as? RecoverableImageViewState } }
        set { withUnsafePointer(to: &ViewAssociatedKeys.imageViewState) {ao_setOptional(newValue, pkey: $0) }  }
    }

    override func saveViewState() {
        super.saveViewState()
        imageState = RecoverableImageViewState(view: self)
    }

    override func recoverViewState(forced: Bool) {
        super.recoverViewState(forced: forced)
        startTransition { [weak self] in
            self?.image = self?.image == nil || forced ? self?.imageState?.image : self?.image
        }
    }

}

extension UIButton {

    var buttonState: RecoverableButtonViewState? {
        get { withUnsafePointer(to: &ViewAssociatedKeys.buttonViewState) { return ao_get(pkey: $0) as? RecoverableButtonViewState } }
        set { withUnsafePointer(to: &ViewAssociatedKeys.buttonViewState) {ao_setOptional(newValue, pkey: $0) }  }
    }

    override func saveViewState() {
        super.saveViewState()
        buttonState = RecoverableButtonViewState(view: self)
    }

    override func recoverViewState(forced: Bool) {
        super.recoverViewState(forced: forced)
        startTransition { [weak self] in
            if self?.title(for: .normal) == nil {
                self?.setTitle(self?.buttonState?.title, for: .normal)
            }
        }
    }

}

extension UITableViewHeaderFooterView {

    var headerFooterState: RecoverableTableViewHeaderFooterViewState? {
        get { withUnsafePointer(to: &ViewAssociatedKeys.headerFooterViewState) { return ao_get(pkey: $0) as? RecoverableTableViewHeaderFooterViewState } }
        set { withUnsafePointer(to: &ViewAssociatedKeys.headerFooterViewState) {ao_setOptional(newValue, pkey: $0) }  }
    }

    override func saveViewState() {
        super.saveViewState()
        headerFooterState = RecoverableTableViewHeaderFooterViewState(view: self)
    }

    override func recoverViewState(forced: Bool) {
        super.recoverViewState(forced: forced)
        startTransition { [weak self] in
            self?.backgroundView?.backgroundColor = self?.headerFooterState?.backgroundViewColor
        }
    }

}
