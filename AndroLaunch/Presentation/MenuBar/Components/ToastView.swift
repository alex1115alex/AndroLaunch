//
//  ToastView.swift
//  AndroLaunch
//

import SwiftUI

struct ToastView: View {
    let message: String
    
    var body: some View {
        HStack(spacing: 12) {
            // Icon
            Image(systemName: "checkmark")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
            
            // Message text
            Text(message)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(minWidth: 250, maxWidth: 350)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.black.opacity(0.9))
                .shadow(color: .black.opacity(0.3), radius: 12, x: 0, y: 6)
        )
        .padding(8)
        .onAppear {
            print("🍞 ToastView appeared with message: '\(message)'")
        }
    }
}

#Preview {
    ToastView(message: "Screenshot copied to clipboard")
        .frame(width: 300, height: 60)
}