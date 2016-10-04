//
//  Exercise.swift
//  Liftr
//
//  Created by Christopher Dwyer on 9/27/16.
//  Copyright © 2016 Christopher Dwyer. All rights reserved.
//

import Foundation

struct ExerciseSet {
    // Private Variables
    fileprivate var completed: Bool
    fileprivate var index: Int
    fileprivate let exercise: Exercise
    fileprivate let weightCalculationTypeId: Int
    fileprivate let weightCalculationData: Int
    fileprivate var weightCalculationType: WeightCalculationType? {
        get {
            switch weightCalculationTypeId {
            case 0:
                return WeightCalculationType.straight(weightCalculationData)
            case 1:
                return WeightCalculationType.oneRepMax(weightCalculationData)
            case 2:
                return WeightCalculationType.threeRepMax(weightCalculationData)
            default:
                return nil
            }
        }
    }
    
    // Calculated Variables
    
    init(completed: Bool, index: Int, exercise: Exercise, weightCalculationType: WeightCalculationType) {
        self.completed = completed
        self.index = index
        self.exercise = exercise
        switch weightCalculationType {
        case .straight(let weight):
            weightCalculationTypeId = 0
            weightCalculationData = weight
        case .oneRepMax(let percentage):
            weightCalculationTypeId = 1
            weightCalculationData = percentage
        case .threeRepMax(let percentage):
            weightCalculationTypeId = 2
            weightCalculationData = percentage
        }
    }
    
    mutating func toggleCompleted() {
        completed = !completed
        //Update Database
    }
}

extension ExerciseSet: Nestable {
    var status: NestableStatus {
        return completed ? .complete : .notStarted
    }
}
