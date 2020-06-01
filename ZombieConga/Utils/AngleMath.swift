//
//  AngleMath.swift
//  ZombieConga
//
//  Created by Samantha Gatt on 6/1/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import Foundation
import CoreGraphics

prefix operator |
prefix func | <T>(lhs: T) -> T where T: Comparable, T: SignedNumeric {
    abs(lhs)
}

// For aesthetic
postfix operator |
postfix func | <T: BinaryInteger>(int: T) -> T { int }
postfix func | <T: BinaryFloatingPoint>(float: T) -> T { float }

extension CGFloat {
    var isNegative: Bool { self < 0 }
    func shortestAngle(to otherAngle: CGFloat) -> CGFloat {
        /// Difference between `self` and `otherAngle` (making sure it's not over 360°)
        var shortest = (otherAngle - self).truncatingRemainder(dividingBy: .pi*2)
        if shortest >= .pi { shortest -= .pi }
        if shortest <= -.pi { shortest += .pi*2 }
        return shortest
    }

}
