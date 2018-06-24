//
//  ListViewApi.swift
//  iOS-AbilityTestProject
//
//  Created by Ger on 2018/6/24.
//  Copyright © 2018年 Test.Ger.com. All rights reserved.
//

import RxSwift
import Moya

class ListViewApi {
    let provider = RxMoyaProvider<ListViewApiStatement>()
    
    func getListViewContent() -> Observable<ListViewModel> {
        return provider.request(.ApiForGetListContent())
        .filterSuccessfulStatusCodes()
        .mapJSON()
        .mapObject(type:ListViewModel.self)
    }
}

enum ListViewApiStatement {
    case ApiForGetListContent()
}

extension ListViewApiStatement:TargetType{
    var baseURL: URL {
        return URL(string: "http://thoughtworks-ios.herokuapp.com")!
    }
    
    var path: String {
        return "/facts.json"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        return .request
    }
    
    
}
