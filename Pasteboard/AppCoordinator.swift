//
//  AppCoordinator.swift
//  Pasteboard
//
//  Created by Riccardo Gialletti on 22/10/22.
//

import Foundation
import Cocoa

class AppCoordinator {
    private (set) var pasteboardViewModel: PasteboardViewModel

    var timer: Timer!
    let pasteboard: NSPasteboard = .general
    var lastChangeCount: Int = 0

    init() {
        pasteboardViewModel = PasteboardViewModel()

        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { (t) in
            if self.lastChangeCount != self.pasteboard.changeCount {
                self.lastChangeCount = self.pasteboard.changeCount
                NotificationCenter.default.post(name: .NSPasteboardDidChange, object: self.pasteboard)
            }
        }
    }

}
