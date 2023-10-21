//
//  FileMainView.swift
//  SysBadgeApp
//
//  Created by Finn Behrens on 21.10.23.
//

import SwiftUI

import SysBadge

struct FileMainView: View {
    @State var showFileImporter: Bool = false
    @ObservedObject var fileModel = FileModel()
    
    var body: some View {
        NavigationStack(path: $fileModel.stack) {
            if fileModel.reading {
                ProgressView()
            } else {
                VStack {
                    Image(systemName: "folder.badge.person.crop")
                        .font(.system(size: 50))
                        .foregroundStyle(.gray)
                        .padding()
                    
                    Text("Open File")
                        .foregroundStyle(.blue)
                   
                    if fileModel.systemFile != nil {
                        NavigationLink(value: FileModel.Stack.file) {
                            Text(fileModel.systemFile!.name)
                        }
                    }
                }
                .padding()
                .fileImporter(isPresented: $showFileImporter, allowedContentTypes: [.systemDefinition], onCompletion: { res in
                    guard let url = try? res.get() else {
                        return
                    }
                    self.openFile(url: url)
                })
                /*.onDrop(of: [.init("dev.sysbadge.sysdf")], isTargeted: .constant(true), perform: { providers in
                    print(providers)
                    return true
                })*/
                .onTapGesture {
                    showFileImporter.toggle()
                }
                .navigationDestination(for: FileModel.Stack.self) { stack in
                    switch stack {
                        case .file:
                            if let system = fileModel.systemFile {
                                SystemFileView(system: system)
                            }
                    }
                }
            }
        }
    }
    
    func openFile(url: URL) {
        fileModel.openFile(url: url)
    }
}

#Preview {
    FileMainView()
}
