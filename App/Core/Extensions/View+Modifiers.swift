//
//  View+Modifiers.swift
//  App
//

import SwiftUI

public struct StandardCardModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.appSecondaryBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(Color.appBorder.opacity(0.4), lineWidth: 1)
            )
    }
}

public extension View {
    func standardCard() -> some View {
        modifier(StandardCardModifier())
    }

    @ViewBuilder
    func isHidden(_ hidden: Bool) -> some View {
        if hidden {
            EmptyView()
        } else {
            self
        }
    }
}
