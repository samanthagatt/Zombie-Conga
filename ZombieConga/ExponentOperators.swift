//
//  ExponentOperator.swift
//  ZombieConga
//
//  Created by Samantha Gatt on 5/31/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import Foundation

precedencegroup Exponentiative {
  associativity: left
  higherThan: MultiplicationPrecedence
}
infix operator ** : Exponentiative
func ** <T: BinaryInteger>(lhs: T, rhs: T) -> T {
    T.self(pow(Double(lhs), Double(rhs)))
}
func ** <T: BinaryFloatingPoint>(lhs: T, rhs: T) -> T {
    T.self(pow(Double(lhs), Double(rhs)))
}


postfix operator **
postfix func ** <T: BinaryInteger>(number: T) -> T {
    T.self(number * number)
}
postfix func ** <T: BinaryFloatingPoint>(number: T) -> T {
    T.self(number * number)
}

precedencegroup ExponentiativeAssignment {
  associativity: right
  higherThan: MultiplicationPrecedence
}
infix operator **= : ExponentiativeAssignment
func **= <T: BinaryInteger>(lhs: inout T, rhs: T) {
    lhs = lhs ** rhs
}
func **= <T: BinaryFloatingPoint>(lhs: inout T, rhs: T) {
    lhs = lhs ** rhs
}
