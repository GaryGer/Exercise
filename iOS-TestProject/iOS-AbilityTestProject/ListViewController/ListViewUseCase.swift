//
//  ListViewUseCase.swift
//  iOS-AbilityTestProject
//
//  Created by Ger on 2018/6/24.
//  Copyright © 2018年 Test.Ger.com. All rights reserved.
//

import RxSwift

class ListViewUseCase: UseCase<ListViewRequestValue, ListViewModel> {
    var repo :ListViewRespositorProtocol!
    
    init(repo:ListViewRespositorProtocol) {
        self.repo = repo
    }
    
    override func buildObservable(requestValue: ListViewRequestValue?) -> Observable<ListViewModel> {
        return repo.requestListViewData()
    }
}
