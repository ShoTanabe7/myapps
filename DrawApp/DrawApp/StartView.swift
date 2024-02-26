//
//  StartView.swift
//  DrawApp
//
//  Created by 田辺　奨 on 2024/02/05.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationStack {
            NavigationLink("Level1") {
                Level1Content()
            }
            NavigationLink("Level2") {
                Level2Content()
            }
        }
    }
}

#Preview {
    StartView()
}
