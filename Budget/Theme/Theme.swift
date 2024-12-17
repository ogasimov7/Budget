import SwiftUI

struct Theme {
    static let background = Color(.systemGroupedBackground)
    static let secondaryBackground = Color(.secondarySystemGroupedBackground)
    static let accent = Color("AccentColor")
    static let text = Color(.label)
    static let secondaryText = Color(.secondaryLabel)
    static let highlight = Color.yellow.opacity(0.3)
    
    struct CardStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding()
                .background(Theme.secondaryBackground)
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.05), radius: 10)
        }
    }
    
    struct ListRowStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(Theme.secondaryBackground)
                .cornerRadius(12)
        }
    }
}

extension View {
    func cardStyle() -> some View {
        modifier(Theme.CardStyle())
    }
    
    func listRowStyle() -> some View {
        modifier(Theme.ListRowStyle())
    }
} 