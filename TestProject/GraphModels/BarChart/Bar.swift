//
//  Bar.swift
//  UAXC
//
//  Created by David  Terkula on 9/9/22.
//

import Foundation
import SwiftUI
import UIKit

struct Bar: Identifiable {
    var id = UUID()
    
    var label: String
    var value: Double
    var size: Double
    var scaleFactor: Double
    var color: Color
}
