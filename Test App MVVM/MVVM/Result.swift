//
//  Result.swift
//  Test App MVVM
//
//  Created by Victor on 01.02.2021.
//

import RxSwift

enum Result<T> {
    case Success(value: T)
    case Failure(error: Error)
}
