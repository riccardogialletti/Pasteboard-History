//
//  NSNotification+Extension.swift
//  Pasteboard
//
//  Created by Riccardo Gialletti on 22/10/22.
//

import Foundation

extension NSNotification.Name {
    public static let NSPasteboardDidChange: NSNotification.Name = .init(rawValue: "pasteboardDidChangeNotification")
}
