//
//  MainView.swift
//  code-tr
//
//  Created by Faruk Kuz on 19.08.2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var authService = AuthenticationService.shared
    
    var body: some View {
        Group {
            if authService.isAuthenticated {
                FleetView()
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            } else {
                LoginView()
                    .transition(.asymmetric(
                        insertion: .move(edge: .leading).combined(with: .opacity),
                        removal: .move(edge: .trailing).combined(with: .opacity)
                    ))
            }
        }
        .animation(.easeInOut(duration: 0.6), value: authService.isAuthenticated)
    }
}

#Preview {
    MainView()
}
