//
//  Calculation.swift
//  OwnPlayground
//
//  Created by Phyo Pwint  on 26/4/16.
//  Copyright © 2016 Phyo Pwint . All rights reserved.
//

import Foundation
class Calculation
{
    private var accumulator = 0.0
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    private var operations: Dictionary<String, Operation> = [
        "x" : Operation.Constant(M_PI),
        "+" : Operation.UnaryOperation(sqrt),
        "-" : Operation.BinaryOperation({ $0 - $1 }),
        "/" : Operation.BinaryOperation({ $0 / $1}),
        "=" : Operation.Equals
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
    }
    
    private struct pendingBinaryOperation {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    private var pending: pendingBinaryOperation?
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
                case .Constant(let value):
                    accumulator = value
                break
                case .UnaryOperation(let foo):
                    accumulator = foo(accumulator)
                break
                case .BinaryOperation(let foo2):
                    executePendingBinaryOperation()
                    pending = pendingBinaryOperation(binaryFunction: foo2, firstOperand: accumulator)
                break
                case .Equals:
                    executePendingBinaryOperation()
                break
            }
        }
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
}