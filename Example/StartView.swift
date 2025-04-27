//
//  StartView.swift
//  Example
//
//  Created by Sangwon Park on 4/26/25.
//

import SwiftUI
import BottomSheetPresenter

struct StartView: View {

    @State var isPresented = false
    @State var detents: [BottomSheetDetent] = [.large, .medium]
    @State var prefersGrabberVisible = true
    @State var isDismissable = true
    @State var useLegacyForcely = false

    var body: some View {
        HStack {
            VStack {
                Text("Modern")

                Button("large + medium") {
                    detents = [.large, .medium]
                    prefersGrabberVisible = true
                    isDismissable = true
                    useLegacyForcely = false
                    isPresented.toggle()
                }
                Button("medium (non dismissable)") {
                    detents = [.medium]
                    prefersGrabberVisible = true
                    isDismissable = false
                    useLegacyForcely = false
                    isPresented.toggle()
                }
                Button("[300 x 200] + m + l") {
                    detents = [.custom(height: 200), .medium, .large]
                    prefersGrabberVisible = true
                    isDismissable = true
                    useLegacyForcely = false
                    isPresented.toggle()
                }
            }
            VStack {
                Text("Legacy")

                Button("large + medium") {
                    detents = [.large, .medium]
                    prefersGrabberVisible = true
                    isDismissable = true
                    useLegacyForcely = true
                    isPresented.toggle()
                }
                Button("medium (non dismissable)") {
                    detents = [.medium]
                    prefersGrabberVisible = true
                    isDismissable = false
                    useLegacyForcely = true
                    isPresented.toggle()
                }
                Button("[300 x 200] + m + l") {
                    detents = [.custom(height: 200), .medium, .large]
                    prefersGrabberVisible = true
                    isDismissable = true
                    useLegacyForcely = true
                    isPresented.toggle()
                }
            }
        }
        .bottomSheet(
            isPresented: $isPresented,
            detents: detents,
            prefersGrabberVisible: prefersGrabberVisible,
            isDismissable: isDismissable,
            useLegacyForcely: useLegacyForcely,
            onDismiss: {
                // print("onDismiss")
            }) {
                if #available(iOS 15.0, *) {
                    ColorView(color: .red)
                        .frame(width: 300, height: 200)
                } else {
                    Text("This is only available in iOS 15.0 or later")
                }
            }
    }
}
