//
//  ViewController.swift
//  Test App MVVM
//
//  Created by Victor on 01.02.2021.
//

import RxSwift
//import RxCocoa


infix operator <->
infix operator <-
infix operator </-

func <-> (left: Property<String>, right: UITextField) {
    left.change
        .filter { $0 != right.text }
        .subscribe(onNext: { right.text = $0 }).dispose()
    
    right.rx.text.filter({ (str) -> Bool in
        left.value != str
    }).subscribe(onNext: { val in
        left.value = val!
    }).dispose()
}

func <-> (left: Property<String>, right: UITextView) {
    left.change
        .filter { $0 != right.text }
        .subscribe(onNext: { right.text = $0 }).dispose()
    
    right.rx.text.filter({ (str) -> Bool in
        left.value != str
    }).subscribe(onNext: { val in
        left.value = val!
    }).dispose()
}

func <-> (left: Property<Bool>, right: UISwitch) {
    left.change
        .filter { right.isOn != $0 }
        .subscribe(onNext: { right.isOn = $0 }).dispose()
    
    right.rx.value.filter({ (val) -> Bool in
        left.value != val
    }).subscribe(onNext: { val in
        left.value = val
    }).dispose()
}

func <- (left: Property<String>, right: UILabel) {
    left.subscribe(onNext: { right.text = $0 }).dispose()
}

func <- (left: Command, right: UIButton) -> Disposable {
    return right.rx.tap.subscribe(onNext: { left.execute() })
}

func <- (left: Command, right: UIBarButtonItem) -> Disposable {
    return right.rx.tap.subscribe(onNext: { left.execute() })
}

//func <- (left: Property<NSURL?>, right: UIImageView) {
//    left.change
//        .map { $0! }
//        .subscribe(onNext: { right.af_setImage(withURL: $0 as URL) })
//}

func <-<T> (left: AsyncCommand<T>, right: UIButton) {
    right.rx.tap.subscribe(onNext: { left.execute() }).dispose()
    Observable.combineLatest(left.executing, left.canExecute) { !$0 && $1 }.subscribe(onNext: { right.isEnabled = $0 }).dispose()
}

func <-<T> (left: AsyncCommand<T>, right: UIBarButtonItem) {
    right.rx.tap.subscribe(onNext: { left.execute() }).dispose()
    Observable.combineLatest(left.executing, left.canExecute) { !$0 && $1 }.subscribe(onNext: { right.isEnabled = $0 }).dispose()
}

func <-<T> (left: AsyncCommand<T>, right: UIActivityIndicatorView) {
    right.hidesWhenStopped = true
    left.executing.subscribe(onNext: {
        if $0 {
            right.startAnimating()
        } else {
            right.stopAnimating()
        }
    }).dispose()
}

func </-<T> (left: AsyncCommand<T>, right: UIControl) {
    left.executing.subscribe(onNext: { right.isEnabled = !$0 }).dispose()
}
