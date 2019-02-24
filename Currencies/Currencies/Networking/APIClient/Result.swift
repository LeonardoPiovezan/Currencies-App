//
//  Result.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 23/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

enum Result<T, U> where U: Error {
    case success(T)
    case failure(U)
}
