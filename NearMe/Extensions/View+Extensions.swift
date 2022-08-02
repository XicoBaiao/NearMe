//
//  View+Extensions.swift
//  NearMe
//
//  Created by Baiao, Francisco Fonseca on 21/07/2022.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition { transform(self) }
        else { self }
    }
}
