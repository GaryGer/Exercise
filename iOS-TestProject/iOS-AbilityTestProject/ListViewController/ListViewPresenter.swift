//
//  ListViewPresenter.swift
//  iOS-AbilityTestProject
//
//  Created by Ger on 2018/6/24.
//  Copyright © 2018年 Test.Ger.com. All rights reserved.
//

import RxSwift

class ListViewPresenter: ListViewOutput {
    
    var useCase :ListViewUseCase!
    private weak var viewInput:ListViewInput?
    
    init(useCase:ListViewUseCase, viewInput:ListViewInput) {
        self.useCase = useCase
        self.viewInput = viewInput
    }
    
    func getListViewData() {
        
        useCase.excute(nextHandler: { (model:ListViewModel) -> () in
            self.viewInput?.setListViewData(listModel: model)
        }, errorHandler: { (error:Error) -> () in
            print(error)
            self.viewInput?.setListViewDataDaild()
        }) {
            print("compelete")
        }
    }
}
