//
//  CGPointAddSubtract.swift
//  ZombieConga
//
//  Created by Samantha Gatt on 5/31/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import Foundation
import CoreGraphics

// Adding two vectors
func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}
func += (lhs: inout CGPoint, rhs: CGPoint) {
    lhs = lhs + rhs
}

// Subtracting two vectors
func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}
func -= (lhs: inout CGPoint, rhs: CGPoint) {
    lhs = lhs - rhs
}

// Multiplying two vectors
func * (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x * rhs.x, y: lhs.y * rhs.y)
}
func *= (lhs: inout CGPoint, rhs: CGPoint) {
    lhs = lhs * rhs
}

// Multiplying a vector by a scalar (Scaling the vector)
func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
}
func *= (lhs: inout CGPoint, rhs: CGFloat) {
    lhs = lhs * rhs
}

// Dividing two vectors
func / (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x / rhs.x, y: lhs.y / rhs.y)
}
func /= (lhs: inout CGPoint, rhs: CGPoint) {
    lhs = lhs / rhs
}

// Dividing a vector by a scalar
func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
}
func /= (lhs: inout CGPoint, rhs: CGFloat) {
    lhs = lhs / rhs
}

extension CGPoint {
    /// Angle of vector (arctan of y/x)
    var angle: CGFloat { atan2(y, x) }
    /// Length of vector (Pythagorean Theorem)
    var length: CGFloat { sqrt(x** + y**) }
    /// The vector normalized into a single unit (length of 1)
    var unitVector: CGPoint { self / length }
}
