//
//  PasteboardView.swift
//  Pasteboard
//
//  Created by Riccardo Gialletti on 22/10/22.
//

import Foundation
import SwiftUI

extension NSTextField {
        open override var focusRingType: NSFocusRingType {
                get { .none }
                set { }
        }
}

struct PasteboardView: View {
    @ObservedObject var viewModel : PasteboardViewModel
    @State private var searchText = ""
    @State private var selectedIndex = 0
    @State private var showToast = false

    private var coordinator: AppCoordinator

    init(coordinator:AppCoordinator) {
        self.coordinator = coordinator
        self.viewModel = coordinator.pasteboardViewModel
    }

    // MARK: - View
    var body: some View {

        ScrollView {
            VStack(alignment: .leading) {
                ZStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search ..", text: $searchText)
                    }
                }
                .frame(height: 25)
                .padding()

                Picker("", selection: $selectedIndex, content: {
                    Text("List").tag(0)
                    Text("Favourite").tag(1)
                })
                .pickerStyle(SegmentedPickerStyle())

                switch(selectedIndex) {
                case 0:
                    ForEach(searchResults) { entry in
                        HStack(alignment: .top) {
                            VStack {
                                Button {

                                    viewModel.addToFavourite(entry: entry)
                                } label: {

                                    Image(systemName: "bookmark.circle")
                                }
                                Button {
                                    viewModel.pasteboardEntries.removeAll { s in
                                        s.uuid == entry.uuid
                                    }
                                } label: {
                                    Image(systemName: "minus.circle.fill")
                                }
                            }
                            Text(entry.value)
                                .multilineTextAlignment(.leading)
                                .padding(.leading, 8)
                                .padding(.trailing, 8)
                                .padding(.top, 4)
                                .padding(.bottom, 4)
                                .frame(maxWidth: .infinity,alignment: .leading)
                        }
                        .onTapGesture {
                            coordinator.pasteboard.declareTypes([.string], owner: nil)
                            coordinator.pasteboard.setString(entry.value, forType: .string)
                            showToast = true
                        }
                        //.frame(width: 400)
                        .background(
                            .ultraThinMaterial ,
                            in: RoundedRectangle(cornerRadius: 8, style: .continuous)

                        )

                    }
                case 1:
                    ForEach(viewModel.pasteboardFavourites) { entry in
                        HStack(alignment: .top) {
                            VStack {
                                Button {
                                    viewModel.pasteboardFavourites.removeAll { s in
                                        s.uuid == entry.uuid
                                    }

                                } label: {
                                    Image(systemName: "minus.circle.fill")
                                }
                            }
                            Text(entry.value)
                                .multilineTextAlignment(.leading)
                                .padding(.leading, 8)
                                .padding(.trailing, 8)
                                .padding(.top, 4)
                                .padding(.bottom, 4)
                                .frame(maxWidth: .infinity,alignment: .leading)
                        }
                        .onTapGesture {
                            coordinator.pasteboard.declareTypes([.string], owner: nil)
                            coordinator.pasteboard.setString(entry.value, forType: .string)
                            showToast = true
                        }
                        //.frame(width: 400)
                        .background(
                            .ultraThinMaterial ,
                            in: RoundedRectangle(cornerRadius: 8, style: .continuous)

                        )

                    }

                default:
                    Text("That's was orrible")
                }

                //.searchable(text: $searchText,placement: .toolbar )

            }
            .toast(message: "Elemento copiato",
                   isShowing: $showToast,
                   duration: Toast.short)
        }.padding(12)

    }

    

    var searchResults: [PasteboardEntry] {
        if searchText.isEmpty {
            return viewModel.pasteboardEntries
        } else {
            return viewModel.pasteboardEntries.filter { $0.value.contains(searchText) }
        }
    }
}

struct FileView_Previews: PreviewProvider {
    static var previews: some View {
        PasteboardView(coordinator:AppCoordinator())
    }
}

struct MyTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
        .padding(30)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.red, lineWidth: 3)
        ).padding()
    }
}
