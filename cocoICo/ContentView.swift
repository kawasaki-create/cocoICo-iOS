//
//  ContentView.swift
//  cocoICo
//
//  Created by かわさき on 2022/08/30.
//

import SwiftUI

struct ContentView: View {
    @State var txt = "こんにちは"
    @State var img = ""
    
    var body: some View {
                NavigationView {
                    VStack {
                        NavigationLink(destination: NextView()) {
                            Text("クリックで遷移") .padding()
                                .navigationTitle("FirstTitle")
                                .navigationBarTitleDisplayMode(.inline)
                        }
                        Text(txt + "\n")
                            .padding()
                        Button("適当ボタン") {
                            txt = "foo"
                        }
                    }
                }
    }
}

struct NextView: View{
    var body: some View{
        Text("NextView").padding()
            .navigationBarTitle("SecontScreen")
            .navigationBarTitleDisplayMode(.automatic)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
