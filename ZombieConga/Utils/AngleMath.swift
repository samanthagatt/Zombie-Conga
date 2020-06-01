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
prefix func | <T: BinaryInteger>(int: T) -> T {
    T.init(int.magnitude)
}
prefix func | <T: BinaryFloatingPoint>(float: T) -> T {
    T.init(float.magnitude)
}

// For aesthetic
postfix operator |
postfix func | <T: BinaryInteger>(int: T) -> T { int }
postfix func | <T: BinaryFloatingPoint>(float: T) -> T { float }

let π: CGFloat = .pi
func shortestAngle(between angle1: CGFloat,
                   and angle2: CGFloat) -> CGFloat {
    /// Difference between angle2 and angle1 (making sure it's not over 360°)
    var angle = (angle2 - angle1).truncatingRemainder(dividingBy: 2*π)
    if angle >= π { angle -= π }
    if angle <= -π { angle += 2*π }
    return angle
}

extension CGFloat {
    var isNegative: Bool { self < 0 }
}
