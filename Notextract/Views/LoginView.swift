//
//  LoginView.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-03-05.
//

import SwiftUI

struct LoginView: View {
    @State private var logoOffsetY: CGFloat = 300
    @State private var loginSectionOffsetY: CGFloat = 300
    
    var body: some View {
        ZStack {
            Color(.ivory)
                .ignoresSafeArea()
            
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
                        .padding(20)
                    
                    TextField("Username", text: .constant(""))
                        .padding()
                        .background(.ivory)
                        .foregroundStyle(.charcoal)
                        .font(.customFont("LeagueSpartan-Regular", size: 20))
                        .cornerRadius(5.0)
                        .padding(.bottom, 10)
                    
                    SecureField("Password", text: .constant(""))
                        .padding()
                        .background(.ivory)
                        .foregroundStyle(.charcoal)
                        .font(.customFont("LeagueSpartan-Regular", size: 20))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    
                    Button {
                        print("Login pressed!")
                    } label: {
                        Text("Login")
                            .foregroundStyle(.black)
                            .frame(width: 150)
                            .font(.customFont("LeagueSpartan-Regular", size: 20))
                            .padding()
                            .background(.gold)
                            .cornerRadius(5.0)
                    }
                    
                    HStack(spacing: .zero) {
                        Text("Don't have an account?")
                            .foregroundStyle(.ivory)
                            .font(.customFont("Lora-Italic", size: 15))
                            .padding(.trailing, 5)
                        
                        Button {
                            print("Sign up pressed!")
                        } label: {
                            Text("Sign up")
                                .foregroundStyle(.gold)
                                .font(.customFont("Lora-Italic", size: 15))
                        }
                            
                    }
                    .padding(10)
                }
                .padding()
                .background(.charcoal)
                .roundedCorner(30, corners: [.topLeft, .topRight])
                .offset(y: loginSectionOffsetY)
                .animation(Animation.easeInOut.delay(1))
                .padding(.bottom, 20)
                                                    
            }
        }
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
