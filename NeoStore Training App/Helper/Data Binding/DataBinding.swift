//
//  DataBinding.swift
//  NeoStore Training App
//
//  Created by Neosoft on 25/07/24.
//

import Foundation

enum DataBinding<T> {
    case loading
    case success(T) // T - Response
    case failure(Error)
}

