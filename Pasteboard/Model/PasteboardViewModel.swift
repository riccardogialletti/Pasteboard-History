//
//  PasteboardViewModel.swift
//  Pasteboard
//
//  Created by Riccardo Gialletti on 22/10/22.
//
import Foundation
import Combine
import SwiftUI

class PasteboardViewModel: ObservableObject {

    @Published var pasteboardEntries: [PasteboardEntry] = []
    @Published var pasteboardFavourites: [PasteboardEntry] = []
    @Published var pasteboardEntriesTypes: [PasteboardEntryType] = []

    func getPasteboardItems(item: NSPasteboardItem) {

        if let entry = PasteboardEntry.createFromPasteboardItem(item) {

            if(self.pasteboardEntries.isEmpty) {
                self.pasteboardEntries.append(entry)
                self.pasteboardEntriesTypes.append(entry.type)
                self.pasteboardEntries.reverse()
            } else {

                if(!self.pasteboardEntries.contains(where: { e in
                    e.value == entry.value
                })) {
                    self.pasteboardEntries.append(entry)
                    self.pasteboardEntries.reverse()
                }

                if(!self.pasteboardEntriesTypes.contains(where: { t in
                    t == entry.type
                })) {
                    self.pasteboardEntriesTypes.append(entry.type)
                }
            }


        }
    }

    func addToFavourite(entry: PasteboardEntry) {

        if(self.pasteboardFavourites.isEmpty) {

            self.pasteboardFavourites.append(entry)
            self.pasteboardFavourites.reverse()
        } else {

            if(!self.pasteboardFavourites.contains(where: { e in
                e.value == entry.value
            })) {
                self.pasteboardFavourites.append(entry)
                self.pasteboardFavourites.reverse()
            }
        }
    }

    init() {

        NotificationCenter.default.addObserver(self, selector: #selector(onPasteboardChanged), name: .NSPasteboardDidChange, object: nil)
    }

    @objc func onPasteboardChanged(_ notification: Notification) {

        guard let pb = notification.object as? NSPasteboard else { return }
        guard let items = pb.pasteboardItems else { return }
        guard let item = items.first else { return }
        self.getPasteboardItems(item: item)
    }
}
