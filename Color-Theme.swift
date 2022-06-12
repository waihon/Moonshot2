//
//  Color-Theme.swift
//  Moonshot2
//
//  Created by Waihon Yew on 12/06/2022.
//

import Foundation
import SwiftUI

// Add functionality to ShapeStyle but only for times when it's
// being used as a color.
extension ShapeStyle where Self == Color {
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }

    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
}
