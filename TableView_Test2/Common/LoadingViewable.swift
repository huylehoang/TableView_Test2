//
//  LoadingViewable.swift
//  TableView_Test2
//
//  Created by LeeX on 9/24/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol LoadingViewable {
    
}

extension LoadingViewable where Self: UIViewController {
    
    fileprivate func startAnimating() {
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = view.center
        loadingView.backgroundColor = UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        loadingView.restorationIdentifier = "loadingView"
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0);
        actInd.style = .whiteLarge
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2,
                                y: loadingView.frame.size.height / 2);
        loadingView.addSubview(actInd)
        view.addSubview(loadingView)
        actInd.startAnimating()
        
    }
    
    fileprivate func stopAnimating() {
        if let loadingView = view.subviews.filter({$0.restorationIdentifier == "loadingView"}).first
            , let actInd = loadingView.subviews.filter({ $0 is UIActivityIndicatorView }).first as? UIActivityIndicatorView
        {
            UIView.animate(withDuration: 0.3, animations: {
                actInd.alpha = 0
                actInd.stopAnimating()
                loadingView.alpha = 0
            }) { (_) in
                loadingView.removeFromSuperview()
            }
        }
    }
}

extension UIViewController: LoadingViewable {}

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
