// Generated using Sourcery 1.4.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
//
//  ContentView.swift
//

import SwiftUI

@available(iOS 13.0, *)
struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                HeroView_Preview.navigationLink()
                WineView_Preview.navigationLink()
            }
            .navigationBarTitle(Text("Components"))
        }
    }
}

@available(iOS 13.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
