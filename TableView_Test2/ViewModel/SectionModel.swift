//
//  SectionModel.swift
//  TableView_Test2
//
//  Created by LeeX on 9/23/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation
import RxDataSources

struct MySection {

    var items: [ViewModel.ExpandableCell]
    
}

extension MySection: SectionModelType {
    typealias Item = ViewModel.ExpandableCell
    
    init(original: MySection, items: [Item]) {
        self = original
        self.items = items
    }
}
