//
//  UtilityExtentions.swift
//  Allah Toxo Siru
//
//  Created by Ovenger on 28/01/2022.
//

import Foundation
import SwiftUI


extension String: Identifiable{
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}


extension Color {
    static let primaryLight = Color("PrimaryLight")
}
