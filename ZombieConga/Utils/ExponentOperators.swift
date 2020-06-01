//
//  ExponentOperator.swift
//  ZombieConga
//
//  Created by Samantha Gatt on 5/31/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import Foundation

precedencegroup ExponentiationPrecedence {
  associativity: left
  higherThan: MultiplicationPrecedence
}
infix operator ** : ExponentiationPrecedence
func ** <T: BinaryInteger>(lhs: T, rhs: T) -> T {
    T.self(pow(Double(lhs), Double(rhs)))
}
func ** <T: BinaryFloatingPoint>(lhs: T, rhs: T) -> T {
    T.self(pow(Double(lhs), Double(rhs)))
}


postfix operator **
postfix func ** <T: BinaryInteger>(int: T) -> T {
    T.self(int * int)
}
postfix func ** <T: BinaryFloatingPoint>(float: T) -> T {
    T.self(float * float)
}

precedencegroup ExponentiationAssignment {
  associativity: right
  higherThan: MultiplicationPrecedence
}
infix operator **= : ExponentiationAssignment
func **= <T: BinaryInteger>(lhs: inout T, rhs: T) {
    lhs = lhs ** rhs
}
func **= <T: BinaryFloatingPoint>(lhs: inout T, rhs: T) {
    lhs = lhs ** rhs
}


