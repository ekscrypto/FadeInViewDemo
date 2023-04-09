//
//  ModalView.swift
//  FadeInSwiftUI
//
//  Created by Dave Poirier on 2023-04-09.
//

import SwiftUI

struct ModalView: View {
    @Binding var showModal: Bool

    @State var fadeAlpha: CGFloat = 0.0 // start invisible

    var body: some View {
        VStack {
            Spacer ()
            
            Text("Hi, I'm presented modally!")
            Button(
                action: {
                    fadeAlpha = 0.0 // on dismiss, become invisible (will animate)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                        // once we are no longer visible, remove the view from the hierarchy
                        showModal = false
                    })
                },
                label: { Text("Dismiss") })
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.gray)
        .opacity(fadeAlpha)
        .animation(.easeIn, value: fadeAlpha)
        .onAppear { fadeAlpha = 1.0 } // animate to fully visible on appearance
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(showModal: .constant(true))
    }
}
