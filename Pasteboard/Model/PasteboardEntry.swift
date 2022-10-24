//
//  PasteboardEntry.swift
//  Pasteboard
//
//  Created by Riccardo Gialletti on 22/10/22.
//

import Foundation
import Cocoa

enum PasteboardEntryType: String {
    case string = "Testo"
    case image = "Immagine"
    case url = "URL"
}

/// Describes a filesystem entry
struct PasteboardEntry {
    var type: PasteboardEntryType
    var item: NSPasteboardItem
    var value: String
    var uuid: UUID
    var modificationDate: Date // file modification date
}


extension PasteboardEntry {

    static func createFromPasteboardItem(_ item:NSPasteboardItem) -> Self? {

        var entryType : PasteboardEntryType = .string

        if let type = item.types.first {
            if(type.rawValue == "public.tiff") {
                entryType = .image
            }
            if(type.rawValue == "public.utf8-plain-text") {
                entryType = .string
            }

            if(type.rawValue == "public.html") {
                entryType = .string
            }

            if(type.rawValue == "public.rtf") {
                entryType = .string
            }
        }


        return PasteboardEntry(
            type: entryType,
            item: item,
            value: item.string(forType: .string) ?? "",
            uuid: UUID(),
            modificationDate: Date())
    }
}

extension PasteboardEntry:Identifiable {
    var id: UUID {
        uuid
    }
}

extension PasteboardEntry:Equatable {
    
}
