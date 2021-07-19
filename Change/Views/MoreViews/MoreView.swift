//
//  MoreView.swift
//  Change
//
//  Created by aiqin139 on 2021/3/10.
//

import SwiftUI

struct MoreNavigationView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        Form {
            LogoView()
                .frame(height: 150)
                .shadow(radius: 10)

            Section {
                NavigationLink(destination:  RecordView().environmentObject(modelData)) {
                    Text("占卦记录")
                }
            }
            
            Section {
                NavigationLink(destination:  RTFView(fileName: "占卦须知").navigationTitle("占卦须知")) {
                    Text("占卦须知")
                }

                NavigationLink(destination:  RTFView(fileName: "大衍占法").navigationTitle("大衍占法")) {
                    Text("大衍占法")
                }
                
                NavigationLink(destination:  RTFView(fileName: "数字占法").navigationTitle("数字占法")) {
                    Text("数字占法")
                }

                NavigationLink(destination:  RTFView(fileName: "念念有词").navigationTitle("念念有词")) {
                    Text("念念有词")
                }
            }
            
            Section {
                NavigationLink(destination:  RTFView(fileName: "占卦三不").navigationTitle("占卦三不")) {
                    Text("占卦三不")
                }
                
                NavigationLink(destination:  RTFView(fileName: "不诚不占").navigationTitle("不诚不占")) {
                    Text("不诚不占")
                }
                
                NavigationLink(destination:  RTFView(fileName: "不义不占").navigationTitle("占卦三不")) {
                    Text("不义不占")
                }
                
                NavigationLink(destination:  RTFView(fileName: "不疑不占").navigationTitle("不疑不占")) {
                    Text("不疑不占")
                }
            }
            
            Section {
                NavigationLink(destination:  RTFView(fileName: "元亨之意").navigationTitle("元亨之意")) {
                    Text("元亨之意")
                }
                
                NavigationLink(destination:  RTFView(fileName: "利贞之意").navigationTitle("利贞之意")) {
                    Text("利贞之意")
                }
            }
            
            Section {
                NavigationLink(destination:  RTFView(fileName: "license_cn").navigationTitle("关于软件")) {
                    Text("关于软件")
                }
            }
        }
        .navigationTitle("更多")
        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MoreView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationView {
            MoreNavigationView()
                .environmentObject(modelData)
        }
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
            .environmentObject(ModelData())
    }
}
