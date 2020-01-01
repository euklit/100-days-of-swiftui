//
//  Shapes.swift
//  DiceParadise
//
//  Created by Niklas Lieven on 28.12.19.
//  Copyright © 2019 euklit. All rights reserved.
//

import SwiftUI

struct Pentagon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let sideLengthPentagon = rect.width / CGFloat((2 * cos(Double.pi / 5)))
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: sideLengthPentagon * CGFloat(sin(Double.pi / 5))))
        path.addLine(to: CGPoint(x: rect.midX + sideLengthPentagon / 2, y: sideLengthPentagon * (CGFloat(sin(Double.pi / 5)+cos(Double.pi / 10)))))
        path.addLine(to: CGPoint(x: rect.midX - sideLengthPentagon / 2, y: sideLengthPentagon * (CGFloat(sin(Double.pi / 5)+cos(Double.pi / 10))))) // line parallel to x-axis
        path.addLine(to: CGPoint(x: rect.minX, y: sideLengthPentagon * CGFloat(sin(Double.pi / 5))))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}

struct Kite: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: 2 * rect.maxY / 3))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: 2 * rect.maxY / 3))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        return path
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        return path
    }
}

