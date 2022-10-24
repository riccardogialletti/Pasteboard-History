//
//  ContentView.swift
//  Pasteboard
//
//  Created by Riccardo Gialletti on 22/10/22.
//

import SwiftUI

struct ContentView: View {

    var coordinator:AppCoordinator
    var statusItem: NSStatusItem?

    var body: some View {
        VStack {

            PasteboardView(coordinator: coordinator)

        }
        .frame(width: 500, height: 500)

    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coordinator: AppCoordinator())
    }
}


