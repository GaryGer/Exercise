//
//  UseCase.swift
//  iOS-AbilityTestProject
//
//  Created by Ger on 2018/6/24.
//  Copyright © 2018年 Test.Ger.com. All rights reserved.
//

import RxSwift
typealias ErrorHandler = (Error) -> ()
typealias CompleteHandler = () -> ()

class UseCase<RequestValue, ResponeValue> {
    typealias NextHandler = (ResponeValue) ->()
    var disposable:Disposable?
    
    func excute(requestValue:RequestValue? = nil, nextHandler:@escaping NextHandler, errorHandler: @escaping ErrorHandler, completeHandler: CompleteHandler? = nil){
        
        disposable = buildObservable(requestValue: requestValue)
        .observeOn(MainScheduler.instance)
        .subscribeOn(ConcurrentMainScheduler.instance)
        .subscribe(onNext: nextHandler, onError: errorHandler, onCompleted: completeHandler)
    }
    
    func buildObservable(requestValue:RequestValue?) -> Observable<ResponeValue>{
        fatalError("You must override func buildObservable")
    }
}
