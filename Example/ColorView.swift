//
//  ColorView.swift
//  Example
//
//  Created by Sangwon Park on 4/27/25.
//

import SwiftUI

@available(iOS 15.0, *)
struct ColorView: View {
    @Environment(\.dismiss) private var dismiss
    let color: UIColor
    var body: some View {
        VStack {
            Button("Close") {
                dismiss()
            }
            Rectangle()
                .fill(Color(color))
                .frame(width: 100, height: 100)
                .cornerRadius(20)
        }
    }
}
