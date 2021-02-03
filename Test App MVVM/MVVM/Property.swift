//
//  Property.swift
//  Test App MVVM
//
//  Created by Victor on 01.02.2021.
//

import RxSwift

class Property<T>: Disposable {
    var value: T {
        didSet {
            subject.onNext(value)
        }
    }
    var get: T {
        get {
            return value
        }
    }
    private var subject: BehaviorSubject<T>
    var change: Observable<T> {
        get {
            return subject
        }
    }
    
    init(value: T) {
        self.subject = BehaviorSubject(value: value)
        self.value = value
    }
    
    convenience init(_ value: T) {
        self.init(value: value)
    }
    
    func set(value: T) {
        self.value = value
    }
        
    func subscribe(onNext: @escaping (T) -> Void) -> Disposable {
        return subject.subscribe(onNext: onNext)
    }
    
    func dispose() {
        subject.dispose()
    }
}

