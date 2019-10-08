//
//  APIClient.swift
//  TableView_Test2
//
//  Created by LeeX on 9/18/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation

private let sampleText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent nibh ex, sagittis interdum tincidunt quis, varius dictum nibh. Aliquam sit amet urna tellus"

class APIClient {
    static func getData(completion: @escaping ([ViewModel.ExpandableCell]) -> ()) {
        var data = [ViewModel.ExpandableCell]()
        for i in 0...Int.random(in: 10...100) {
            data.append(ViewModel.ExpandableCell(text: "Title for row \(i):\n\n\(sampleText.randomRepeat())",
                                                 expanded: false))
        }
        completion(data)
    }
}
