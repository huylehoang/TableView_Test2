//
//  DetailViewController.swift
//  TableView_Test2
//
//  Created by LeeX on 9/24/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
    
    @IBOutlet weak var txtViewDetail: UITextView!
    private let loading: PublishSubject<Bool> = PublishSubject()
    private let disposeBag = DisposeBag()
    var detail: String?
    
    var countDown = 10
    var timer: Observable<Int>!
    override func viewDidLoad() {
        super.viewDidLoad()
        loading.bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        
        txtViewDetail.text = detail
        txtViewDetail.isEditable = false
        txtViewDetail.textColor = .black
        txtViewDetail.font = .systemFont(ofSize: 24.0, weight: .regular)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        txtViewDetail.isHidden = true
        loading.onNext(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        txtViewDetail.setContentOffset(.zero, animated: false)
        txtViewDetail.isHidden = false
        loading.onNext(false)
    }
}
