//
//  Command.swift
//  Test App MVVM
//
//  Created by Victor on 01.02.2021.
//

import RxSwift

class Command {
    let canExecute: Observable<Bool>!
    private var actions: [(() -> Void)] = []
    
    init(canExecute: Observable<Bool>) {
        self.canExecute = canExecute
    }
    
    convenience init() {
        self.init(canExecute: Observable.just(true))
    }
    
    @objc
    func execute() {
        actions.forEach { action in
            action()
        }
    }
    
    func subscribe(action: @escaping () -> Void) {
        self.actions.append(action)
    }
}

