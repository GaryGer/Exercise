//
//  ListViewController.swift
//  iOS-AbilityTestProject
//
//  Created by Ger on 2018/6/24.
//  Copyright © 2018年 Test.Ger.com. All rights reserved.
//

import UIKit
import MJRefresh

protocol ListViewInput :class{
    func setListViewData(listModel:ListViewModel?)
    func setListViewDataDaild()
}

protocol ListViewOutput {
    func getListViewData()
    
}

class ListViewController: UIViewController,ListViewInput {
    
    fileprivate lazy var contentTableView :UITableView = {
        let tableview = UITableView(frame: self.view.bounds, style: .plain)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: "ListViewCell", bundle: Bundle.main), forCellReuseIdentifier:"tableViewCell")
        tableview.rowHeight = UITableViewAutomaticDimension
        return tableview
    }()
    
    fileprivate var viewOutput :ListViewOutput?
    fileprivate var rows:[ListViewRowModel]?
    fileprivate var heightAtIndexPath:[IndexPath:CGFloat]?
    fileprivate var refresh_header = MJRefreshNormalHeader()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        configRefreshHeader()
        setUpListViewOutput()
    }
    
    
    func setUpUI(){
        view.addSubview(contentTableView)
    }
    
    private func configRefreshHeader(){
        refresh_header.setRefreshingTarget(self, refreshingAction: #selector(refreshLoadData))
        contentTableView.mj_header = refresh_header
    }
    
    @objc private func refreshLoadData(){
        viewOutput?.getListViewData()
    }
    
    func setUpListViewOutput(){
        let api = ListViewApi()
        let repos = ListViewRepository(api: api)
        let useCases = ListViewUseCase(repo: repos)
        viewOutput = ListViewPresenter(useCase: useCases, viewInput: self)
        viewOutput?.getListViewData()
    }
    
    func setListViewData(listModel:ListViewModel?){
        rows = []
        if let optionModel = listModel {
            rows = optionModel.rows
        }
        self.configNavigationTitle(listModel?.title)
        if self.refresh_header.isRefreshing() {
            contentTableView.mj_header.endRefreshing()
        }
        contentTableView.reloadData()
    }
    func setListViewDataDaild(){
        
    }
    
    private func configNavigationTitle(_ title:String?){
        navigationItem.title = title ?? ""
    }
}

extension ListViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") as? ListViewCell
        cell?.cellModel = rows?[indexPath.row]
        return cell ?? ListViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = heightAtIndexPath?[indexPath]
        if height != nil {
            return height!
        }else{
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let height = cell.frame.size.height
        heightAtIndexPath?.updateValue(height, forKey: indexPath)
    }
    
}
