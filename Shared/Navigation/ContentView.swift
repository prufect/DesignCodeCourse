//
//  ContentView.swift
//  Shared
//
//  Created by Prudhvi Gadiraju on 7/29/20.
//

import SwiftUI

struct ContentView: View {
    
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    #endif
    
    var body: some View {
        #if os(iOS)
        if horizontalSizeClass == .compact {
            TabBar()
        } else {
            Sidebar()
        }
        #else
        Sidebar()
            .frame(minWidth: 1000, minHeight: 600)
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
