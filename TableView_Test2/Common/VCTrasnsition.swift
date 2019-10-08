//
//  VCTrasnsition.swift
//  TableView_Test2
//
//  Created by LeeX on 9/24/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

enum VCTrasition {
    case push(vc: UIViewController)
    case pop
}

extension Reactive where Base: UIViewController {
    var navigate: Binder<VCTrasition> {
        return Binder(self.base, binding: { (vc, transition) in
            switch transition {
            case .push(let nextVC):
                vc.navigationController?.pushViewController(nextVC, animated: true)
            case .pop:
                vc.navigationController?.popViewController(animated: true)
            }
        })
    }
}

