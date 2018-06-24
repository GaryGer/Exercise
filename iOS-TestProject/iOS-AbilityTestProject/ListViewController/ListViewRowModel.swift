//
//  CellModel.swift
//  iOS-AbilityTestProject
//
//  Created by Ger on 2018/6/24.
//  Copyright © 2018年 Test.Ger.com. All rights reserved.
//

import RxSwift
import ObjectMapper

class ListViewModel :Mappable{
    var title:String?
    var rows :[ListViewRowModel]?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        title <- map["title"]
        rows <- map["rows"]
    }
}

class ListViewRowModel :Mappable{
    
    var title:String?
    var description:String?
    var imageHref:String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        description <- map["description"]
        imageHref <- map["imageHref"]
    }
    
    
}
