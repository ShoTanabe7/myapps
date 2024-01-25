//
//  StartUIView.swift
//  MyPoker
//
//  Created by 田辺　奨 on 2023/08/30.
//

import SwiftUI

struct StartUIView: View {

    var body: some View {
        VStack {
           
            NavigationStack {
                
                
                NavigationLink {
                    
                    HeadsUpUIView()
                }label: {
                    Text("Heads")
                }
            }
          
          
            
        }//Vstack
    }
}

struct StartUIView_Previews: PreviewProvider {
    static var previews: some View {
        StartUIView()
    }
}
