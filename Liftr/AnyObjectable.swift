//
//  AnyObjectable.swift
//  Liftr
//
//  Created by Christopher Dwyer on 9/27/16.
//  Copyright © 2016 Christopher Dwyer. All rights reserved.
//

import Foundation

protocol AnyObjectable {
    var toAnyObject: Any { get }
    static func createFrom(anyObject obj: Any) -> Self?
}
