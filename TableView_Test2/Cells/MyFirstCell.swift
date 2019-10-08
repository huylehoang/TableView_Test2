//
//  MyFirstCell.swift
//  TableView_Test2
//
//  Created by LeeX on 9/4/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MyFirstCell: UITableViewCell {

    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    var disposeBagCell: DisposeBag = DisposeBag()
    let expandedAt: PublishSubject<MyFirstCell> = PublishSubject()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        setUpBinding()
    }
    
    override func prepareForReuse() {
        disposeBagCell = DisposeBag()
    }
    
    private func setUpBinding() {
        let _ = moreButton.rx.tap.bind { [weak self] (_) in
            guard let `self` = self else { return }
            self.expandedAt.onNext(self)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func binding(with data: ViewModel.ExpandableCell?) {
        lblDescription.text = data?.text
        self.moreButton.setTitle(data?.expanded ?? false ? "Less" : "More", for: .normal)
    }
}
