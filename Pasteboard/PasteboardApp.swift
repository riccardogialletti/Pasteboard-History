//
//  PasteboardApp.swift
//  Pasteboard
//
//  Created by Riccardo Gialletti on 22/10/22.
//

import SwiftUI
import Foundation

class AppDelegate: NSObject, NSApplicationDelegate {

    var statusItem : NSStatusItem?
    var popover: NSPopover?

    func applicationDidFinishLaunching(_ notification: Notification) {

        let contentView =  ContentView(coordinator: AppCoordinator())
            .background(VisualEffectView().ignoresSafeArea())

        let popover = NSPopover()
        popover.contentSize = NSSize(width: 400, height: 400)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: contentView)
        self.popover = popover

        let view = NSHostingView(rootView: contentView)

        // Don't forget to set the frame, otherwise it won't be shown.
        view.frame = NSRect(x: 0, y: 0, width: 400, height: 400)

        let menuItem = NSMenuItem()
        menuItem.view = view

        let menu = NSMenu()
        menu.addItem(menuItem)

        // StatusItem is stored as a class property.
        self.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = self.statusItem?.button {
            //button.title = "Click"
            let itemImage = NSImage(named: "statusBarIcon")
            itemImage?.isTemplate = true
            statusItem?.button?.image = itemImage
            button.action = #selector(showPopover(_:))
        }
        /*self.statusItem?.menu = menu
         self.statusItem?.button?.title = "Board"
         self.statusItem?.button?.image = NSImage(systemSymbolName: "list.bullet.clipboard",accessibilityDescription: "Clipboard")*/

    }

    @objc func showPopover(_ sender: AnyObject?) {
        if let button = self.statusItem?.button
        {
            if self.popover?.isShown ?? false {
                self.popover?.performClose(sender)
            } else {
                self.popover?.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
}

@main
struct PasteboardApp: App {

    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    //var coordinator:AppCoordinator
    //var menuCommandsHandler:MenuCommandsHandler
    

    var body: some Scene {
        //AppScene(coordinator: coordinator, menuCommandsHandler: menuCommandsHandler)

        /*WindowGroup {
         // ContentView(coordinator: coordinator)
         //   .background(VisualEffectView().ignoresSafeArea())
         }
         /*.commands {
          MenuCommands(commandsHandler: menuCommandsHandler)
          }*/
         .windowStyle(.hiddenTitleBar)*/

        Settings {
            AnyView(VStack{})
        }
    }

    /*init() {
     coordinator = AppCoordinator()
     menuCommandsHandler = MenuCommandsHandler(coordinator: coordinator)
     }*/




}

/*struct AppScene:Scene {
 var coordinator:AppCoordinator
 var menuCommandsHandler:MenuCommandsHandler

 var body: some Scene {
 /*WindowGroup {
  ContentView(coordinator: coordinator)
  .background(VisualEffectView().ignoresSafeArea())
  }
  /*.commands {
   MenuCommands(commandsHandler: menuCommandsHandler)
   }*/
  .windowStyle(.hiddenTitleBar)*/

 }
 }*/

struct VisualEffectView: NSViewRepresentable {
    func makeNSView(context: Context) -> NSVisualEffectView {
        let effectView = NSVisualEffectView()
        effectView.state = .active
        return effectView
    }

    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
    }
}

