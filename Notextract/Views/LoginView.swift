//
//  LoginView.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-03-05.
//

import SwiftUI
import Combine

struct LoginView: View {
    @ScaledMetric(relativeTo: .body) private var secureFieldHeight: CGFloat = 22
    
    @State private var logoOffsetY: CGFloat = 300
    @State private var loginSectionOffsetY: CGFloat = 500
    @State private var keyboardHeight: CGFloat = 0
    @State private var loginFieldsHeight: Double = 500
    @State private var isSignUpMode: Bool = false
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var repeatedPassword: String = ""
    
    @FocusState private var isFieldInFocus: Bool
    
    var body: some View {
        ZStack {
            Color(.charcoal)
            
            VStack {
                if !isSignUpMode {
                    Spacer()
                    
                    Image("notExtract")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                        .offset(y: logoOffsetY)
                        .opacity(isFieldInFocus ? 0.0 : 1.0)
                        .animation(Animation.easeInOut)
                }
                
                if !isSignUpMode {
                    loginSection()                    
                } else {
                    signUpSection()
                }
            }
            .background(.ivory)
        }
        .frame(height: UIScreen.main.bounds.height)
        .onReceive(Publishers.keyboardHeight) { keyboardHeight = $0 }
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    logoOffsetY = 0
                    loginSectionOffsetY = 0
                }
            }
        }
    }
}

extension LoginView {
    func loginSection() -> some View {
        VStack {
            Text("Welcome!")
                .font(.customFont("LeagueSpartan-Bold", size: 35))
                .foregroundStyle(.gold)
                .padding(.bottom, 30)
            
            TextField("Username", text: $username)
                .underlineTextField()
                .padding()
                .foregroundStyle(.ivory)
                .font(.customFont("LeagueSpartan-Regular", size: 20))
                .padding(.bottom, 10)
                .focused($isFieldInFocus)
            
            SecureField("Password", text: $password)
                .frame(minHeight: secureFieldHeight)
                .underlineTextField()
                .padding()
                .foregroundStyle(.ivory)
                .font(.customFont("LeagueSpartan-Regular", size: 20))
                .padding(.bottom, 20)
                .focused($isFieldInFocus)
            
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
                    withAnimation {
                        isSignUpMode.toggle()
                        // loginSectionOffsetY = isSignUpMode ? -300 : 0
                        loginFieldsHeight = isSignUpMode ? UIScreen.main.bounds.height : 500
                    }
                } label: {
                    Text("Sign up")
                        .foregroundStyle(.gold)
                        .font(.customFont("Lora-Regular", size: 15))
                }
            }
            .padding(.top, 30)
            .padding(.bottom, 20)
            .opacity(isFieldInFocus ? 0.0 : 1.0)
        }
        .padding()
        .frame(height: loginFieldsHeight)
        .background(.charcoal)
        .roundedCorner(30, corners: isSignUpMode ? [] : [.topLeft, .topRight])
        .offset(y: loginSectionOffsetY)
        .animation(Animation.easeInOut)
        // .padding(.bottom)
    }
    
    func signUpSection() -> some View {
        VStack {
            Spacer()
            
            Text("Let's get you signed up!")
                .font(.customFont("LeagueSpartan-Bold", size: 35))
                .foregroundStyle(.gold)
                .padding(20)
                .multilineTextAlignment(.center)
                .opacity(isFieldInFocus ? 0.0 : 1.0)
            
            TextField("Email", text: $username)
                .underlineTextField()
                .padding()
                .foregroundStyle(.ivory)
                .font(.customFont("LeagueSpartan-Regular", size: 20))
                .padding(.bottom, 10)
                .focused($isFieldInFocus)
            
            SecureField("Password", text: $password)
                .frame(minHeight: secureFieldHeight)
                .underlineTextField()
                .padding()
                .foregroundStyle(.ivory)
                .font(.customFont("LeagueSpartan-Regular", size: 20))
                .padding(.bottom, 10)
                .focused($isFieldInFocus)
            
            SecureField("Repeat Password", text: $repeatedPassword)
                .frame(minHeight: secureFieldHeight)
                .underlineTextField()
                .padding()
                .foregroundStyle(.ivory)
                .font(.customFont("LeagueSpartan-Regular", size: 20))
                .padding(.bottom, 20)
                .focused($isFieldInFocus)
            
            Spacer()
            
            Button {
                print("Sign up successful!!")
            } label: {
                Text("Sign up")
                    .foregroundStyle(.charcoal)
                    .frame(width: 150)
                    .font(.customFont("LeagueSpartan-Regular", size: 20))
                    .padding()
                    .background(.gold)
                    .cornerRadius(5.0)
            }
            
            HStack(spacing: .zero) {
                Text("Go back to")
                    .foregroundStyle(.ivory)
                    .font(.customFont("Lora-Regular", size: 15))
                    .padding(.trailing, 5)
                
                Button {
                    print("Going back to login!")
                    withAnimation {
                        isSignUpMode.toggle()
                        // loginSectionOffsetY = isSignUpMode ? -300 : 0
                        loginFieldsHeight = isSignUpMode ? UIScreen.main.bounds.height : 500
                    }
                } label: {
                    Text("login")
                        .foregroundStyle(.gold)
                        .font(.customFont("Lora-Regular", size: 15))
                }
            }
            .padding(.top, 30)
            .padding(.bottom, 20)
            .opacity(isFieldInFocus ? 0.0 : 1.0)
            
            Spacer()
        }
        .padding()
        .frame(height: loginFieldsHeight)
        .roundedCorner(30, corners: isSignUpMode ? [] : [.topLeft, .topRight])
        .offset(y: loginSectionOffsetY)
        .animation(Animation.easeInOut)
        .padding(.bottom)
        .background(.charcoal)
    }
}

#Preview {
    LoginView()
}
