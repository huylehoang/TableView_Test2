//
//  ViewController.swift
//  TableView_Test2
//
//  Created by LeeX on 9/4/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = ViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setUpBinding()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.isHidden = true
        viewModel.loading.onNext(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.isHidden = false
        viewModel.loading.onNext(false)
    }
    
    private func setupData() {
        viewModel.setupData()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "MyFirstCell", bundle: nil), forCellReuseIdentifier: "MyFirstCell")
        tableView.separatorStyle = .none
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    private func setUpBinding() {
        
        viewModel.loading
            .bind(to: self.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.transition
            .bind(to: self.rx.navigate)
            .disposed(by: disposeBag)
        
        viewModel.cells
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(dataSource: viewModel.dataSource()))
            .disposed(by: disposeBag)
        
        viewModel.expandedAt
            .observeOn(MainScheduler.instance)
            .subscribe { [unowned self] (cell) in
                if let cell = cell.element, let indexPath = self.tableView.indexPath(for: cell) {
                    self.viewModel.toggle(at: indexPath.row)
                    self.tableView.reloadRows(at: [indexPath], with: .fade)
                }
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .observeOn(MainScheduler.instance)
            .subscribe { [unowned self] (indexPath) in
                if let indexPath = indexPath.element, let detail = self.viewModel.data(at: indexPath.row)?.text {
                    let vc = UIStoryboard(name: "Main", bundle: nil)
                        .instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                    vc.detail = detail
                    self.viewModel.transition.onNext(.push(vc: vc))
                }
            }
            .disposed(by: disposeBag)
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.rowHeight(for: indexPath)
    }
}
