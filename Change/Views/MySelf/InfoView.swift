//
//  InfoView.swift
//  Change
//
//  Created by aiqin139 on 2021/3/10.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        HStack(alignment: .center) {
            Image("先天八卦图")
                .resizable()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .frame(width: 80, height: 80)
            
            VStack(alignment: .leading) {
                Text("溪江月")
                    .bold()
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 1.0)
                
                Text("信则有，不信则无")
                    .foregroundColor(.gray)
            }
            .padding()
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}