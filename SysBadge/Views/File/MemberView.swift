//
//  MemberView.swift
//  SysBadgeApp
//
//  Created by Finn Behrens on 21.10.23.
//

import SwiftUI
import SysBadge

struct MemberView: View {
    let member: System.Member
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(member.name)
            
            Text("(\(member.pronouns))")
                .font(.caption2)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    MemberView(
        member: System.Member(name: "Myriad Kit", pronouns: "they/them")
    )
}
