//
//  DeviceInformationView.swift
//  SysBadge
//
//  Created by Finn Behrens on 20.10.23.
//

import SwiftUI
import SysBadge

struct DeviceInformationView: View {
    let information: DeviceInformation
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 2.5) { // Adjust spacing here
                Image(systemName: "info.circle")
                    .font(.system(size: 50))
                    .foregroundColor(.gray)
                    .padding()

                Text("SysBadge")
                    .font(.title)
                    .fontWeight(.bold)

                HStack {
                    HStack(spacing: 10) { // Adjust spacing here
                        Text("Model:")
                        Text(information.modelNumber)
                            .foregroundColor(.gray)
                    }

                    HStack(spacing: 10) { // Adjust spacing here
                        Text("Serial:")
                        Text(information.serialNumber)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 5)

                Text("Hardware Version: \(information.hardwareRevision)")
                    .foregroundColor(.gray)
                Text("Firmware Version: \(information.firmwareRevision)")
                    .foregroundColor(.gray)
                Text("Software Version: \(information.softwareRevision)")
                    .foregroundColor(.gray)

                Text("Manufacturer: \(information.manufacturerName)")
                    .foregroundColor(.gray)
            }
            .padding()
        }
        .frame(maxWidth: 300, maxHeight: 300)
    }
}


#Preview {
    DeviceInformationView(information: DeviceInformation(modelNumber: "0.0.1", serialNumber: "abc123", hardwareRevision: "0.0.1", firmwareRevision: "7.2.0", softwareRevision: "0.1.0", manufacturerName: "SysBadge"))
}
