//
//  SplitView.swift
//  NavigationAPIPractice
//
//  Created by Amish Tufail on 27/12/2023.
//

import SwiftUI

struct TwoColumnSplitView: View {
    let data = ["First", "Second", "Third"] // This data we iterate over
     
    @State var selection: String? = nil // We save a value here and send it to for use in detail
    @State var columnVisibility: NavigationSplitViewVisibility = .all // This controls our columns visibility
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List(data, id:\.self, selection: $selection) { data in
                Text(data)
            }
            .navigationTitle("DATA")
        } detail: {
            if selection == nil {
                Text("Nothing")
            } else {
                Text(selection!)
            }
        }
        // This just hides one column when it is selected
        .onChange(of: selection) { _, _ in
            if selection == nil {
                columnVisibility = .all
            } else {
                columnVisibility = .automatic
            }
        }

    }
}

struct ThreeColumnSplitView: View {
    let data = ["First", "Second", "Third"]
    let dataTwo = [Color.orange, Color.red, Color.cyan]
    
    @State var selection: String? = nil
    @State var selectionTwo: Color? = nil
    @State var columnVisibility: NavigationSplitViewVisibility = .all
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List(data, id:\.self, selection: $selection) { data in
                Text(data)
            }
            .navigationTitle("DATA")
        } content: {
            if selection == nil {
                Text("Nothing")
            } else {
                Text(selection!)
                List(dataTwo, id:\.self, selection: $selectionTwo) { color in
                    color
                        .frame(height: 20.0)
                }
            }
        } detail: {
            if selectionTwo == nil {
                Text("No Detail View")
            } else {
                selectionTwo
                    .frame(height: 100.0)
                    .clipShape(RoundedRectangle(cornerRadius: 18.0))
            }
        }
        .navigationSplitViewStyle(.balanced) // This fixes the overall issue in this
        .onChange(of: selection) { _, _ in
            if selection == nil {
                columnVisibility = .all
                
            } else {
                columnVisibility = .doubleColumn
            }
        }
        // This just nils the last view if first view is changed
        .onChange(of: selection) { _, _ in
            selectionTwo = nil
        }

    }
}

#Preview {
//    TwoColumnSplitView()
    ThreeColumnSplitView()
}
