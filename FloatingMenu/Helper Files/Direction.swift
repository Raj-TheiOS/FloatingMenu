//
//  Direction.swift
//  FloatingMenu
//
//  Created by K Rajeshwar on 20/04/23.
//

import Foundation

enum Direction {
    case Up
    case Down
    case Left
    case Right

    func offsetPoint(point: CGPoint, offset: CGFloat) -> CGPoint {
        switch self {
        case .Up:
            return CGPoint(x: point.x, y: point.y - offset)
        case .Down:
            return CGPoint(x: point.x, y: point.y + offset)
        case .Left:
            return CGPoint(x: point.x - offset, y: point.y)
        case .Right:
            return CGPoint(x: point.x + offset, y: point.y)
        }
    }
}
