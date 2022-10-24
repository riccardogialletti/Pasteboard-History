//
//  MenuCommandsHandler.swift
//  Pasteboard
//
//  Created by Riccardo Gialletti on 22/10/22.
//

import AppKit
import Foundation

class MenuCommandsHandler {

    /// Executed when the open menu voice is clicked
    func openCommand() {
        let dialog = NSOpenPanel();

        dialog.title                    = "Choose a directory"
        dialog.showsResizeIndicator     = true
        dialog.showsHiddenFiles         = false
        dialog.allowsMultipleSelection  = false
        dialog.canChooseDirectories     = true
        dialog.canChooseFiles           = false

        if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
            if let url = dialog.url {
                //coordinator.setDirectory(url)
            }
        } else {
            print("user cancelled")
            return
        }
    }

    /// Executed when the favorites menu voice is clicked
    func showFavoritesCommand() {
        //coordinator.showFavorites()
    }

}
