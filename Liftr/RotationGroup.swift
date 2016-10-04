//
//  RotationGroup.swift
//  Liftr
//
//  Created by Christopher Dwyer on 8/29/16.
//  Copyright © 2016 Christopher Dwyer. All rights reserved.
//

import Foundation

struct RotationGroup {
    let name: String
    fileprivate var index: Int?
    fileprivate var elements: [Nestable]
    
    init(name: String) {
        self.init(name: name, index: nil)
    }
    
    init(name: String, index: Int?) {
        self.name = name
        self.index = index
        elements = []
    }
    
    mutating func addElement(element: Nestable) {
        elements.append(element)
        //AddRecord
    }
    
    mutating func removeElement(at index: Int) {
        elements.remove(at: index)
    }
    
    func getElement(at index: Int) -> Nestable? {
        if index < 0 || index >= elements.count {
            return .none
        }
        
        return elements[index]
    }
    
    mutating func swapElements(from fromIndex: Int, to toIndex: Int) {
        let tempElement = elements[fromIndex]
        self.elements[fromIndex] = self.elements[toIndex]
        self.elements[toIndex] = tempElement
    }
    
}

extension RotationGroup: Nestable {
    var status: NestableStatus {
        if elements.count == 0 {
            return .empty
        }
        
        if elements.filter({ $0.status != .complete }).count == 0 {
            return .complete
        }
        
        if elements.filter({ $0.status == .complete || $0.status == .inProgress }).count > 0 {
            return .inProgress
        }
        
        return .notStarted
    }
}
