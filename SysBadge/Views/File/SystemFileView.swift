//
//  SystemFileView.swift
//  SysBadgeApp
//
//  Created by Finn Behrens on 21.10.23.
//

import SwiftUI
import SysBadge

struct SystemFileView: View {
    let system: SystemFile
    
    var body: some View {
        SystemFileViewInner(system: system)
        .navigationTitle(system.name)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Label("Upload", systemImage: "square.and.arrow.up")
            }
        }
    }
}

fileprivate struct SystemFileViewInner: View {
    @State var searchText: String = ""
    let system: SystemFile
   
    var body: some View {
        if system.json == nil {
            Text("Cannot show unparsed system")
        } else {
            VStack {
                Text(system.name)
                    .font(.headline)
                    .padding(.top)
               
                if let json = system.json {
                    Text(json.source_id.localizedStringResource)
                        .foregroundStyle(.gray)
                }
                
                Spacer()
                
                List(filterMembers(), id: \.self) { member in
                    MemberView(member: member)
                }
                .searchable(text: $searchText, prompt: "Name")
            }
        }
    }
    
    func filterMembers() -> [System.Member] {
        let full = system.json?.members ?? []
        guard !searchText.isEmpty else { return full }
        return full.filter { member in
            member.name.lowercased().contains(searchText.lowercased())
        }
    }
}

#Preview {
    SystemFileView(system: try! SystemFile(data: Data(base64Encoded:  "U1lCRAEAAAAJAAAAwAAAALMAAABQbHVyYWxLaXQgRXhhbXBsZSBTeXN0ZW0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFwAAAAAAAAABAAMAAQAAAAAAAAAJAAAAygAAABkAAAAnAAAAEQAAADIAAABQbHVyYWxLaXQgRXhhbXBsZSBTeXN0ZW0AAAAAAAAAAGV4bXBsAAAACAAAAAAAAgANAAAAWgAAABEAAABSAAAAFQAAAKoAAAAdAAAACgAAAE15cmlhZCBLaXQAAAAAAAB0aGV5L3RoZW0AAAAAAAAAVGVzdGVyIFQuIFRlc3Rpbmd0b24AAAAAAAAAAAAAAAB7Im5hbWUiOiJQbHVyYWxLaXQgRXhhbXBsZSBTeXN0ZW0iLCJzb3VyY2VfaWQiOnsiUGx1cmFsS2l0Ijp7ImlkIjoiZXhtcGwifX0sIm1lbWJlcnMiOlt7Im5hbWUiOiJNeXJpYWQgS2l0IiwicHJvbm91bnMiOiJ0aGV5L3RoZW0ifSx7Im5hbWUiOiJUZXN0ZXIgVC4gVGVzdGluZ3RvbiIsInByb25vdW5zIjoiIn1dfRJe6R7yNupK940QJI/MWlvMV3nWQnViDWNESTrOHWpk")!))
}
