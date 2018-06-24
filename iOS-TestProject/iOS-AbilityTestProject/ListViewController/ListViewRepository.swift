//
//  ListViewRepository.swift
//  iOS-AbilityTestProject
//
//  Created by Ger on 2018/6/24.
//  Copyright © 2018年 Test.Ger.com. All rights reserved.
//

import RxSwift

protocol ListViewRespositorProtocol {
    func requestListViewData() -> Observable<ListViewModel>
}

class ListViewRepository :ListViewRespositorProtocol{
    
    
    fileprivate var api: ListViewApi!
    init(api:ListViewApi) {
        self.api = api
    }
    
    func requestListViewData() -> Observable<ListViewModel>{
        return api.getListViewContent()
    }
    
}
