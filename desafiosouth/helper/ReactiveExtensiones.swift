//
//  ReactiveExtensiones.swift
//  desafiosouth
//
//  Created by Lucas de Assis Siqueira on 14/03/21.
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



