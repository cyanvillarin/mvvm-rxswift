//
//  ReactiveExtensions.swift
//  mvvm-rxswift
//
//  Created by CYAN on 9/26/20.
//  Copyright © 2020 Cyan Villarin. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension UIViewController: loadingViewable {}

extension Reactive where Base: UIViewController {
    
    /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
    public var isAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (vc, active) in
            if active {
                vc.startAnimating()
            } else {
                vc.stopAnimating()
            }
        })
    }
    
}
