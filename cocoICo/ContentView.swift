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
    @State var email = ""
    @State var password = ""
    @State var errorMessage = ""
    @State var isLoginSuccess = false
    
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
                    TextField("メールアドレス\n", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("パスワード\n", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
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
                    .padding(.top, 20)
                    Text(errorMessage)
                    Button("test") {
                        email = "test@example.com"
                        password = "testpass"
                    }
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .padding(EdgeInsets(
                        top: 20, leading: 35, bottom: 20, trailing: 35
                    ))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1)
                    )
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.red))
                    NavigationLink(destination: HomeView(), isActive: $isLoginSuccess) {
                        
                    }
                }
        }
        }
    }
}

struct NextView: View{
    @State var email = ""
    @State var password = ""
    @State var errorMessage = ""
    @State var isLoginSuccess = false
    
    
    var body: some View{
        VStack{
            TextField("メールアドレス\n", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("パスワード\n", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
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
            .padding(.top, 20)
            Text(errorMessage)
            
        }
    }
}

struct HomeView: View{
   @State var topName = ""
    @State var bottomBarKubun = 0
    @State var showingModal = false
    let userID = Auth.auth().currentUser!.uid
    var body: some View{
        NavigationView {
            ZStack{
                VStack{
                    if(bottomBarKubun == 0){
                        Text(userID).foregroundColor(Color.red)
                    }else if(bottomBarKubun == 1){
                        Text("行きたい店")
                    }else if(bottomBarKubun == 2){
                        Text("友達")
                    }else if(bottomBarKubun == 3){
                        Text("設定")
                    }
                }
                .navigationTitle(topName)
                .navigationBarTitleDisplayMode(.inline)
                if(bottomBarKubun == 1){
                    floatingButton
                }
            }
            .toolbar{
                ToolbarItemGroup(placement: .bottomBar){
                    Button("行きたい店") {
                        self.topName = "行きたい店"
                        bottomBarKubun = 1
                    }
                    Spacer()
                    Button("友達") {
                        topName = "友達"
                        bottomBarKubun = 2
                    }
                    Spacer()
                    Button("設定") {
                        topName = "設定"
                        bottomBarKubun = 3
                    }
                }
            }
        }
    }
    var floatingButton: some View {
            VStack {
                // 2. ButtonをViewの下方に配置
                Spacer()
                HStack {
                    // 3. Viewの右方に配置
                    Spacer()
                    Button(action: {
                        // ボタンを押した時のアクションを記載
                        self.showingModal.toggle()
                    }) {
                        // 4. Buttonのデザインを作成。記号の"+"を配置。
                        Image(systemName: "plus.circle.fill")
                            // Fontサイズ
                            .font(.system(size: 24))
                            // Buttonの文字色
                            .foregroundColor(.white)
                            // Buttonのサイズ
                            .frame(width: 60, height: 60)
                            // Buttonの色
                            .background(Color.blue)
                            // Buttonの角の丸み
                            .cornerRadius(30.0)
                            // Buttonの陰
                            .shadow(color: .gray, radius: 3, x: 3, y: 3)
                            // Buttonの端からの距離
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 16.0, trailing: 20))
                    }.sheet(isPresented: $showingModal){
                        NextView()
                    }
                }
            }
        }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
