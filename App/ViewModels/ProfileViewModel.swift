//
//  ProfileViewModel.swift
//  App
//

import SwiftUI
import Combine

@MainActor
public final class ProfileViewModel: ObservableObject {
    @Published public var user: User?
    @Published public var isEditing: Bool = false
    @Published public var editedName: String = ""

    public init(user: User? = User.mock) {
        self.user = user
        self.editedName = user?.fullName ?? ""
    }

    public func saveProfile() {
        guard let current = user else { return }
        self.user = User(
            id: current.id,
            email: current.email,
            fullName: editedName,
            avatarURL: current.avatarURL,
            createdAt: current.createdAt
        )
        self.isEditing = false
    }
}
