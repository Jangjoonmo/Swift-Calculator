//
//  CalculatorBrain.swift
//  UMC_Workbook_Week3
//
//  Created by 장준모 on 2023/04/07.
//

import Foundation

class CalculatorBrain{
    
    private var accumulator = 0.0
    
    func setOperand(operand: Double) {
        accumulator = operand
        
    }
    
   private var operations: Dictionary<String, Operation> = [
        "π" : Operation.Constant(Double.pi),  // Double.pi,
        "e" : Operation.Constant(M_E), // M_E
        "√" : Operation.UnaryOperation(sqrt), // sqrt(<#T##Double#>)
        "cos" : Operation.UnaryOperation(cos), // cos(<#T##Double#>)
        "×" : Operation.BinaryOperation({ $0 * $1 }),
        "÷" : Operation.BinaryOperation({ $0 / $1 }),
        "+" : Operation.BinaryOperation({ $0 + $1 }),
        "-" : Operation.BinaryOperation({ $0 - $1 }),
        "=" : Operation.Equals
    ]
    
    private func executePendingBinaryOperation(){
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    enum Operation{
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    func perfomOperation(symbol: String) {
        if let operation = operations[symbol]{
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
               executePendingBinaryOperation()
            }
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    var result: Double {
        get{
            return accumulator
        }
    }
}
