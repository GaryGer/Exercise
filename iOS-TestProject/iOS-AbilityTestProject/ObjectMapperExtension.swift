//
//  ObjectMapperExtension.swift
//  iOS-AbilityTestProject
//
//  Created by Ger on 2018/6/24.
//  Copyright © 2018年 Test.Ger.com. All rights reserved.
//

import RxSwift
import ObjectMapper

extension Observable {
    
    func mapObject<T: Mappable>(type: T.Type) -> Observable<T> {
        return self.map { response in
            //if response is a dictionary, then use ObjectMapper to map the dictionary
            //if not throw an error
            print(response)
            guard let dict = response as? [String: Any] else {
                throw RxSwiftMoyaError.JSONError
            }
            
            return Mapper<T>().map(JSON: dict)!
        }
    }
    
}
enum RxSwiftMoyaError: String {
    case JSONError
    case OtherError
}

extension RxSwiftMoyaError :Swift.Error{}
