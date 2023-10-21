//
//  FileMainModel.swift
//  SysBadgeApp
//
//  Created by Finn Behrens on 21.10.23.
//

import Foundation
import OSLog
import SysBadge

@MainActor
class FileModel: ObservableObject {
    static let logger = Logger(subsystem: "dev.sysbadge.sysbadge", category: "FileModel")
    
    @Published
    var reading: Bool = false
    
    @Published
    var systemFile: SystemFile?
    
    @Published
    var stack: [Stack] = []
    
    func openFile(url: URL) {
        self.reading = true
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard url.startAccessingSecurityScopedResource() else {
                Self.logger.warning("Could not access security scoped resource")
                Task {
                    await self.setSystem(system: nil)
                }
                return
            }
            do {
                let system = try SystemFile(contentsOf: url)
                Task {
                    await self.setSystem(system: system)
                }
            } catch {
                Self.logger.warning("Could not read file: \(error.localizedDescription)")
                Task {
                    await self.setSystem(system: nil)
                }
            }
            url.stopAccessingSecurityScopedResource()
        }
    }
    
    func setSystem(system: SystemFile?) {
        if system == nil {
            Self.logger.debug("Could not load empty system, unlocking")
        } else {
            Self.logger.debug("Loaded system: \(system!.name)")
        }
        
        self.reading = false
        self.systemFile = system
        self.stack = [.file]
    }
    
    enum Stack: Hashable, Equatable {
        case file
    }
}
