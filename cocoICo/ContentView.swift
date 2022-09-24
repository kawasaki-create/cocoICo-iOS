//
//  ContentView.swift
//  cocoICo
//
//  Created by かわさき on 2022/08/30.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State var txt = "こんにちは"
    @State var img = ""
    @State var showingModal = false
    
    var body: some View {
            NavigationView {
                ZStack{
                    Color(red:0.753, green: 1, blue: 0.778)
                        .ignoresSafeArea()
                    VStack {
                            Rectangle()
                                .fill(Color.white)
                                .ignoresSafeArea()
                                .frame(maxHeight: 300)
                                .overlay(Text("cocoICo.")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    )
                        Text("").padding(30)
                        Button("登録・ログイン") {
                            self.showingModal.toggle()
                        }
                        .sheet(isPresented: $showingModal){
                            NextView()
                        }
                        .padding(20)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2)
                        )
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        .navigationTitle("FirstTitle")
                        .navigationBarTitleDisplayMode(.inline)
                    }
            }
                }
    }
}

struct NextView: View{
    @State var email = ""
    @State var password = ""
    var body: some View{
        VStack{
            TextField("メールアドレス\n", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("パスワード\n", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack(spacing:100){
                Button("登録") {
                    Auth.auth().signIn(withEmail: email, password: password)
                }
                .font(.headline)
                .foregroundColor(Color.white)
                .padding(EdgeInsets(
                    top: 20, leading: 35, bottom: 20, trailing: 35
                ))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1)
                )
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                Button("ログイン") {
                    
                }
                .font(.headline)
                .foregroundColor(Color.white)
                .padding(20)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1)
                )
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
            }
            .padding(.top, 20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
