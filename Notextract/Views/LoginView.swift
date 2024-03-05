//
//  LoginView.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-03-05.
//

import SwiftUI

struct LoginView: View {
    @State private var logoOffsetY: CGFloat = 300
    @State private var loginSectionOffsetY: CGFloat = 500
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            Color(.ivory)
            
            VStack {
                Spacer()
                
                Image("notExtract")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .offset(y: logoOffsetY)
                    .animation(Animation.easeInOut.delay(1))
                
                Spacer()
                
                VStack {
                    Text("Welcome!")
                        .font(.customFont("LeagueSpartan-Bold", size: 35))
                        .foregroundStyle(.gold)
                        .padding(30)
                    
                    TextField("Username", text: $username)
//                        .placeholder(when: username.isEmpty) {
//                            Text("Username")
//                                .foregroundStyle(.charcoal)
//                        }
                        .underlineTextField()
                        .padding()
                        .foregroundStyle(.ivory)
                        .font(.customFont("LeagueSpartan-Regular", size: 20))
                        .cornerRadius(5.0)
                        .padding(.bottom, 10)
                    
                    SecureField("Password", text: $password)
//                        .placeholder(when: password.isEmpty) {
//                            Text("Password")
//                                .foregroundStyle(.charcoal)
//                        }
                        .underlineTextField()
                        .padding()
                        // .background(.ivory)
                        .foregroundStyle(.ivory)
                        .font(.customFont("LeagueSpartan-Regular", size: 20))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    
                    Button {
                        print("Login pressed!")
                    } label: {
                        Text("Login")
                            .foregroundStyle(.charcoal)
                            .frame(width: 150)
                            .font(.customFont("LeagueSpartan-Regular", size: 20))
                            .padding()
                            .background(.gold)
                            .cornerRadius(5.0)
                    }
                    
                    HStack(spacing: .zero) {
                        Text("Don't have an account?")
                            .foregroundStyle(.ivory)
                            .font(.customFont("Lora-Regular", size: 15))
                            .padding(.trailing, 5)
                        
                        Button {
                            print("Sign up pressed!")
                        } label: {
                            Text("Sign up")
                                .foregroundStyle(.gold)
                                .font(.customFont("Lora-Regular", size: 15))
                        }
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 20)
                }
                .padding()
                .frame(maxHeight: .infinity)
                .background(.charcoal)
                .roundedCorner(30, corners: [.topLeft, .topRight])
                .offset(y: loginSectionOffsetY)
                .animation(Animation.easeInOut.delay(1))
            }
        }
        .ignoresSafeArea()
        .onAppear {
            /*
            CODE SNIPPET FOR VIEWING ALL FONTS AND GETTING CORRECT NAMES
             for family: String in UIFont.familyNames {
                print(family)
                for names in UIFont.fontNames(forFamilyName: family) {
                    print("\t\(names)")
                }
            }
             */
            withAnimation {
                logoOffsetY = 0
                loginSectionOffsetY = 0
            }
        }
    }
}

#Preview {
    LoginView()
}
