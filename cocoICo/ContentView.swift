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
                    Text("\n").padding(-20)
                    NavigationLink(destination: HomeView()) { Text("s")
                    }
                    .foregroundColor(Color.pink)
                    .padding(EdgeInsets(
                        top: 20, leading: 45, bottom: 20, trailing: 45
                    ))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1)
                    )
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                }
        }
        }
    }
}

struct NextView: View{
    @State var email = ""
    @State var password = ""
    @State var errorMessage = ""
    @Environment(\.presentationMode) var presentationMode
    @State var isLoginSuccess = false
    
    private func didTapDismissButton() {
            presentationMode.wrappedValue.dismiss()
        }
    
    var body: some View{
        VStack{
            TextField("メールアドレス\n", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("パスワード\n", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            NavigationView {
            HStack(spacing:100){
                Button("登録") {
                    if(email == "" && password == ""){
                        errorMessage = "メールアドレス・パスワードが未入力です"
                    }else if(email == "" && password != ""){
                        errorMessage = "メールアドレスが未入力です"
                    }else if(password == "" && email != ""){
                        errorMessage = "パスワードが未入力です"
                    }else{
                        Auth.auth().createUser(withEmail: email, password: password)
                        didTapDismissButton()
                        isLoginSuccess = true
                    }
                }
                .font(.headline)
                .foregroundColor(Color.white)
                .padding(EdgeInsets(
                    top: 20, leading: 35, bottom: 20, trailing: 35
                ))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1)
                )
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                
                NavigationLink(destination: HomeView(), isActive: $isLoginSuccess) {
                    EmptyView()
                }
                Button("ログイン") {
                    if(email == "" && password == ""){
                        errorMessage = "メールアドレス・パスワードが未入力です"
                    }else if(email == "" && password != ""){
                        errorMessage = "メールアドレスが未入力です"
                    }else if(password == "" && email != ""){
                        errorMessage = "パスワードが未入力です"
                    }else{
                        Auth.auth().signIn(withEmail: email, password: password){
                            authResult, error in
                            if authResult?.user != nil {
                                //ログイン成功処理
                                errorMessage = ""
                                isLoginSuccess = true
                            }else{
                                //ログイン失敗処理
                                errorMessage = "メールアドレスかパスワードが違います"
                                
                            }
                        }
                    }
                }
                .font(.headline)
                .foregroundColor(Color.white)
                .padding(20)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1)
                )
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
            }
        }
            .padding(.top, 20)
            Text(errorMessage)
        }
    }
}

struct HomeView: View{
    var body: some View{
        VStack{
            Text("aaaa").foregroundColor(Color.red)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
