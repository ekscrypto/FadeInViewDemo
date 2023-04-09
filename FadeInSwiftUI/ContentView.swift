//
//  ContentView.swift
//  FadeInDemo
//
//  Created by Dave Poirier on 2023-04-09.
//

import SwiftUI

struct ContentView: View {
    
    @State var showModalView: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
                Button(action: {
                    showModalView = true
                }, label: {
                    Text("Show Modal Cover")
                })
            }
            .padding()
            
            if showModalView {
                ModalView(showModal: $showModalView)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
