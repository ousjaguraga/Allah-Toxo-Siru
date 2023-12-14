//
//  CircleName.swift
//  Allah Toxo Siru (iOS)
//
//  Created by Ovenger on 23/10/2023.
//

import SwiftUI
import Foundation

struct CircleName: View {
    var n: NameModel.Name
    var body: some View {
        HStack {
            VStack {
                ZStack {
                    Circle()
                        //.fill(gradient)
                        .shadow(color: .black, radius: 5, x: 0, y: 5)
                        .frame(width: 100, height: 100)
                    Text(n.arabic)
                        .font(.title)
                        .foregroundColor(Color.white)
                }
                Text(n.name[0].uppercased())
                    .font(.subheadline)
            }
            Spacer()
        }
    }
}

