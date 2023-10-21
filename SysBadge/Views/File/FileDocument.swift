//
//  FileDocument.swift
//  SysBadgeApp
//
//  Created by Finn Behrens on 21.10.23.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

import SysBadge


struct SystemDefinitionFile: FileDocument {
    static var readableContentTypes: [UTType] { [UTType.systemDefinition] }
    
    var data: Data
    var system: SystemFile
    
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        self.data = data
        self.system = try SystemFile(data: data)
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        FileWrapper(regularFileWithContents: data)
    }
}
