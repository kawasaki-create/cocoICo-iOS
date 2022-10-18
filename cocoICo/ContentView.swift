//
//  ContentView.swift
//  cocoICo
//
//  Created by かわさき on 2022/08/30.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore

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
                        .textFieldStyle(RoundedBorderTextFieldStyle()
                        )
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
    @State var postText = ""
    @Environment(\.presentationMode) var presentationMode
    @State var postLists:[String] = []
    @State var new = ""
    
    private func didTapDismissButton() {
                presentationMode.wrappedValue.dismiss()
            }
    
    var body: some View{
        VStack{
            TextField("行きたいところを入力してください\n", text: $new)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
            HStack(spacing:100){
                Button("追加") {
                    if(new == ""){
                        errorMessage = "入力は必須です"
                    }else{
                        self.postLists.append(self.new)
                        self.new = ""
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
    @State var errorMessage = ""
    @State var postText = ""
    @State var postLists:[String] = []
    @State var new = ""
    @State var post = ""
    @State var date = ""
    @State var documentId = ""
    @State var docIdList:[String] = []
    @State var listCount = 0
    @State var listTotalCount = 0
    @State var nnn = ""
    let db = Firestore.firestore()
    

   
    
    func getPost() {
        let userID = Auth.auth().currentUser!.uid
        db.collection("posts").whereField("user", isEqualTo: userID)
            .getDocuments(){(QuerySnapshot, err) in
                if let err = err{
                    print("Error getting documents: \(err)")
                }else{
                    for document in QuerySnapshot!.documents{
                        print("\(document.documentID) => \(document.data())")
                    }
                }
            }
    }
    
    func gepo() {
        let userID = Auth.auth().currentUser!.uid
        db.collection("posts").whereField("user", isEqualTo: userID)
            .getDocuments(){(QuerySnapshot, err) in
                if let err = err{
                    print("Error getting documents: \(err)")
                }else{
                    for document in QuerySnapshot!.documents{
                        post = document.get("post") as! String
                      //  date = document.get("date") as! Timestamp
                        postLists.append(post)
                        documentId = document.documentID
                        docIdList.append(documentId)
                    }
                }
            }
    }
    
    
    var body: some View{
        let newID = db.collection("posts").document().documentID
        let userID = Auth.auth().currentUser!.uid
        NavigationView {
            ZStack{
                HStack{
                    switch bottomBarKubun{
                    case 0:
                        Text(userID).foregroundColor(Color.red)
                    case 1:
                        List{
                            ForEach(postLists, id: \.self){item in
                                HStack{
                                    Text(item)
                                    Text(documentId)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                                .swipeActions(edge: .trailing){
                                    Button {
                                        db.collection("posts").document(documentId).delete()
                                        postLists = []
                                        gepo()
                                    }label: {
                                        Image(systemName: "trash.fill")
                                    }.tint(.red)
                                }
                            }
                        }
                    case 2:
                        Text("tomo")
                    case 3:
                        Text("sette")
                    default:
                        Text("")
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
                        postLists = []
                        gepo()
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
                    TextField("行きたいところを入力してください\n", text: $new)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    // 3. Viewの右方に配置
                    Spacer()
                    Button(action: {
                        // ボタンを押した時のアクションを記載
                        if(new == ""){
                            errorMessage = "入力は必須です"
                        }else{
                            self.postText = self.new
                            db.collection("posts").document().setData([
                                "post" : postText,
                                "date" : Date(),
                                "user" : Auth.auth().currentUser!.uid,
                                "id": db.collection("posts").document().documentID
                            ])
                            postLists = []
                            self.new = ""
                            gepo()
                        }
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
                    }
                }
                Text(errorMessage)
            }
        }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
