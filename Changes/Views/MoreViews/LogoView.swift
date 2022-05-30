//
//  LogoView.swift
//  Changes
//
//  Created by aiqin139 on 2021/3/10.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        HStack(alignment: .center) {
            Image("先天八卦图")
                .resizable()
                .clipShape(HexagramShape())
                .frame(width: 80, height: 80)
            
            Spacer()
            
            VStack(alignment: .center) {
                Text("易经占卦")
                    .bold()
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 2.0)
                
                Text("逢凶化吉，遇难呈祥")
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }.padding()
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
