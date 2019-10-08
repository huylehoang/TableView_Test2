//
//  ViewModel.swift
//  TableView_Test2
//
//  Created by LeeX on 9/5/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation
import UIKit
import RxDataSources
import RxSwift
import RxCocoa

class ViewModel {
    struct ExpandableCell {
        var text: String
        var expanded: Bool
    }
    
    private var arr = [ExpandableCell]()
    private let disposeBag = DisposeBag()
    
    lazy private var unexpandedRowHeight: CGFloat = {
        let labelLineHeight = UIFont.systemFont(ofSize: 14.0, weight: .regular).lineHeight.rounded()
        let buttonHeight = CGFloat(30)
        let verticalSpacing = CGFloat(8)
        return labelLineHeight * 5 + buttonHeight + verticalSpacing * 5
    }()
    
    let cells: PublishSubject<[MySection]> = PublishSubject()
    let expandedAt: PublishSubject<MyFirstCell> = PublishSubject()
    let transition: PublishSubject<VCTrasition> = PublishSubject()
    let loading: PublishSubject<Bool> = PublishSubject()
    
    private func valid(_ index: Int) -> Bool {
        return index >= 0 && index < arr.count
    }
    
    func setupData() {
        APIClient.getData { [weak self] (data) in
            guard let `self` = self else { return }
            self.arr.append(contentsOf: data)
            self.cells.onNext([MySection(items: data)])
        }
    }
    
    func rowHeight(for indexPath: IndexPath) -> CGFloat {
        guard valid(indexPath.row), arr[indexPath.row].expanded == false
            else { return UITableView.automaticDimension }
        return unexpandedRowHeight
    }
    
    func toggle(at index: Int) {
        guard valid(index) else { return }
        arr[index].expanded.toggle()
    }
    
    func data(at index: Int) -> ExpandableCell? {
        return valid(index) ? arr[index] : nil
    }
    
}

extension ViewModel {
    func dataSource() -> RxTableViewSectionedReloadDataSource<MySection> {
        let dataSource = RxTableViewSectionedReloadDataSource<MySection>(
            configureCell: { [weak self] (dataSource, tableView, indexPath, item) -> UITableViewCell in
                guard let `self` = self else { return UITableViewCell() }
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyFirstCell", for: indexPath) as! MyFirstCell
                cell.binding(with: self.data(at: indexPath.row))
                cell.expandedAt
                    .bind(to: self.expandedAt)
                    .disposed(by: cell.disposeBagCell)
                return cell
        })
        return dataSource
    }
}
