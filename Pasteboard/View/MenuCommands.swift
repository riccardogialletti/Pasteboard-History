//
//  MenuCommands.swift
//  Pasteboard
//
//  Created by Riccardo Gialletti on 22/10/22.
//

import Foundation
import SwiftUI

struct MenuCommands: Commands {
    var commandsHandler:MenuCommandsHandler

    var body: some Commands {
        CommandGroup(replacing: CommandGroupPlacement.newItem) {
            // replace with nothing so we don't have to deal with multiple windows
        }
        CommandGroup(after: CommandGroupPlacement.newItem) {
            /*Button("Open...") {
                commandsHandler.openCommand()
            }
            Button("Show Favorites") {
                commandsHandler.showFavoritesCommand()
            }*/
        }
    }
}
