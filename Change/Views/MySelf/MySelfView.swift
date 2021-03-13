//
//  MySelf.swift
//  Change
//
//  Created by aiqin139 on 2021/3/10.
//

import SwiftUI

struct MySelfView: View {
    init() {
        UITableView.appearance().sectionHeaderHeight = .zero
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    NavigationLink(destination: DetailView()) {
                        InfoView()
                            .frame(height: 150)
                    }
                }
                
                Section {
                    NavigationLink(destination:  DailyView()) {
                        Label("每日一卦", systemImage: "star")
                    }
                }
                
                Section {
                    NavigationLink(destination:  ExplanationView()) {
                        Label("解卦说明", systemImage: "bookmark")
                    }
                }
                
                Section {
                    NavigationLink(destination:  AboutView()) {
                        Label("关于", systemImage: "message")
                    }
                }
                
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct MySelfView_Previews: PreviewProvider {
    static var previews: some View {
        MySelfView()
    }
}

