//
//  CustomTableViewCellSize.swift
//  table-app
//
//  Created by Alexandr Kozorez on 07.02.2022.
//

import CoreGraphics

enum CustomTableViewCellSize: CGFloat {
    typealias RawValue = CGFloat
    
    case element = 40
    case offsetX = 20
    case offsetY = 10
    case title = 13
    case paragraph = 11
    
    static var widthDifference: CGFloat {
        -2 * elementWithXOffset
    }
    
    static var elementWithXOffset: CGFloat {
        CustomTableViewCellSize.element.rawValue + (CustomTableViewCellSize.offsetX.rawValue * 2)
    }
    
    static var elementWithYOffset: CGFloat {
        CustomTableViewCellSize.element.rawValue + (CustomTableViewCellSize.offsetY.rawValue * 2)
    }
}
