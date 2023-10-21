//
//  SystemFileView.swift
//  SysBadgeApp
//
//  Created by Finn Behrens on 21.10.23.
//

import SwiftUI
import SysBadge

struct SystemFileView: View {
    @ObservedObject var fileModel: FileModel
    
    var body: some View {
        SystemFileViewInner(fileModel: fileModel)
        .navigationTitle(fileModel.systemFile?.name ?? "Unknown system")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Label("Upload", systemImage: "square.and.arrow.up")
            }
        }
    }
}

fileprivate struct SystemFileViewInner: View {
    @State var searchText: String = ""
    @ObservedObject var fileModel: FileModel
   
    var body: some View {
        if fileModel.systemFile?.json == nil {
            Text("Cannot show unparsed system")
        } else {
            List(filterMembers(), id: \.self) { member in
                MemberView(member: member)
            }
            .searchable(text: $searchText, prompt: "Name")
        }
    }
    
    func filterMembers() -> [System.Member] {
        let full = fileModel.systemFile?.json?.members ?? []
        guard !searchText.isEmpty else { return full }
        return full.filter { member in
            member.name.lowercased().contains(searchText.lowercased())
        }
    }
}

#Preview {
    SystemFileView(fileModel: FileModel())
}
