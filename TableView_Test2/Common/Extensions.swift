//
//  Extensions.swift
//  TableView_Test2
//
//  Created by LeeX on 9/4/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation
import UIKit

extension String.StringInterpolation {
    mutating func appendInterpolation(repeat str: String, _ count: Int) {
        for _ in 0 ..< count {
            appendLiteral(str)
        }
    }
}

extension String {
    func `repeat`(_ times: Int) -> String {
        return "\(repeat: self, times)"
    }
    
    func randomRepeat() -> String {
        return self.repeat(Int.random(in: 2...10))
    }
}


