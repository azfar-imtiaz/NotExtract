//
//  LoginView.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-03-05.
//

import SwiftUI
import Combine
import AlertToast

struct LoginView: View {
    
    @ObservedObject var authManager: AuthManager
    
    @ScaledMetric(relativeTo: .body) private var secureFieldHeight: CGFloat = 22
    
    @State private var logoOffsetY: CGFloat = 300
    @State private var loginSectionOffsetY: CGFloat = 500
    @State private var loginFieldsHeight: Double = 500
    @State private var isSignUpMode: Bool = false
    
    @State private var firstName : String = ""
    @State private var lastName  : String = ""
    @State private var username  : String = ""
    @State private var password  : String = ""
    @State private var repeatPassword : String = ""
    @State private var isLoading : Bool = false
    
    @State private var showSignUpFailureToast : Bool = false
    @State private var signUpError : String = ""
    
    @FocusState private var isFieldInFocus: Bool
    
    var body: some View {
        ZStack {
            Color(.charcoal)
            
            VStack {
                if !isSignUpMode {
                    Spacer()
                    
                    withAnimation {
                        GIFView(name: "notextract_ascend")
                            .aspectRatio(contentMode: .fit)
                            .frame(height: UIScreen.main.bounds.height * 0.4)
                            .offset(y: logoOffsetY)
                            .opacity(isFieldInFocus ? 0.0 : 1.0)
                    }
                }
                
                if !isSignUpMode {
                    loginSection()                    
                } else {
                    signUpSection()
                }
            }
            .background(.ivoryAlways)
        }
        .frame(height: UIScreen.main.bounds.height)
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
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
                .opacity(isFieldInFocus ? 0.0 : 1.0)
            
            CustomTextField(placeholderText: "Email", color: .ivoryAlways, text: $username)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.none)
                .frame(minHeight: secureFieldHeight)
                .underlineTextField(color: .ivoryAlways)
                .padding()
                .foregroundStyle(.ivoryAlways)
                .font(.customFont("LeagueSpartan-Regular", size: 20))
                .padding(.bottom, 20)
                .focused($isFieldInFocus)
            
            CustomSecureField(placeholderText: "Password", color: .ivoryAlways, text: $password)
                .frame(minHeight: secureFieldHeight)
                .underlineTextField(color: .ivoryAlways)
                .padding()
                .foregroundStyle(.ivoryAlways)
                .font(.customFont("LeagueSpartan-Regular", size: 20))
                .padding(.bottom, 20)
                .focused($isFieldInFocus)
            
            Button {
                print("Login pressed!")
                withAnimation {
                    isFieldInFocus = false
                }
                isLoading = true
                if !authManager.login(username: username, password: password) {
                    isLoading = false
                    print("Login failed!")
                }
            } label: {
                if isLoading {
                    ProgressView()
                        .tint(.charcoal)
                        .frame(width: 150)
                        .padding()
                        .background(.gold)
                        .roundedCorner(8, corners: .allCorners)
                } else {
                    Text("Login")
                        .foregroundStyle(.charcoal)
                        .frame(width: 150)
                        .font(.customFont("LeagueSpartan-Regular", size: 20))
                        .padding()
                        .background(.gold)
                        .roundedCorner(8, corners: .allCorners)
                }
            }
            
            if isFieldInFocus {
                Spacer()
            }
            
            HStack(spacing: .zero) {
                Text("Don't have an account?")
                    .foregroundStyle(.ivoryAlways)
                    .font(.customFont("Lora-Regular", size: 15))
                    .padding(.trailing, 5)
                
                Button {
                    print("Sign up pressed!")
                    withAnimation {
                        isSignUpMode.toggle()
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
        .transition(.move(edge: .bottom))
        .frame(height: isFieldInFocus ? loginFieldsHeight + 100 : loginFieldsHeight)
        .background(.charcoalAlways)
        .roundedCorner(30, corners: isSignUpMode ? [] : [.topLeft, .topRight])
        .offset(y: loginSectionOffsetY)
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
            
            HStack(spacing: 20) {
                CustomTextField(placeholderText: "First name", color: .ivoryAlways, text: $firstName)
                    .autocorrectionDisabled(true)
                    .underlineTextField(color: .ivoryAlways)
                    .foregroundStyle(.ivoryAlways)
                    .font(.customFont("LeagueSpartan-Regular", size: 20))
                    .padding(.bottom, 10)
                    .focused($isFieldInFocus)
                
                Spacer()
                
                CustomTextField(placeholderText: "Last name", color: .ivoryAlways, text: $lastName)
                    .autocorrectionDisabled(true)
                    .underlineTextField(color: .ivoryAlways)
                    .foregroundStyle(.ivoryAlways)
                    .font(.customFont("LeagueSpartan-Regular", size: 20))
                    .padding(.bottom, 10)
                    .focused($isFieldInFocus)
            }
            .padding()
            
            CustomTextField(placeholderText: "Email", color: .ivoryAlways, text: $username)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.none)
                .underlineTextField(color: .ivoryAlways)
                .padding()
                .foregroundStyle(.ivoryAlways)
                .font(.customFont("LeagueSpartan-Regular", size: 20))
                .padding(.bottom, 10)
                .focused($isFieldInFocus)
            
            CustomSecureField(placeholderText: "Password", color: .ivoryAlways, text: $password)
                .frame(minHeight: secureFieldHeight)
                .underlineTextField(color: .ivoryAlways)
                .padding()
                .foregroundStyle(.ivoryAlways)
                .font(.customFont("LeagueSpartan-Regular", size: 20))
                .padding(.bottom, 10)
                .focused($isFieldInFocus)
            
            CustomSecureField(placeholderText: "Repeat password", color: .ivoryAlways, text: $repeatPassword)
                .frame(minHeight: secureFieldHeight)
                .underlineTextField(color: .ivoryAlways)
                .padding()
                .foregroundStyle(.ivoryAlways)
                .font(.customFont("LeagueSpartan-Regular", size: 20))
                .padding(.bottom, 20)
                .focused($isFieldInFocus)
            
            if !isFieldInFocus {
                Spacer()
            }
            
            Button {
                isFieldInFocus = false
                isLoading = true
                authManager.signUp(firstName: firstName, lastName: lastName, email: username, password: password, repeatedPassword: repeatPassword) { error in
                    if let error = error {
                        signUpError = error.localizedDescription
                        isLoading = false
                        showSignUpFailureToast.toggle()
                    } else {
                        print("Sign up successful!!")
                    }
                }
            } label: {
                if isLoading {
                    ProgressView()
                        .tint(.charcoal)
                        .frame(width: 150)
                        .padding()
                        .background(.gold)
                        .roundedCorner(8, corners: .allCorners)
                } else {
                    Text("Sign up")
                        .foregroundStyle(.ivoryAlways)
                        .frame(width: 150)
                        .font(.customFont("LeagueSpartan-Regular", size: 20))
                        .padding()
                        .background(.gold)
                        .roundedCorner(8, corners: .allCorners)
                }
            }
            
            HStack(spacing: .zero) {
                Text("Go back to")
                    .foregroundStyle(.ivoryAlways)
                    .font(.customFont("Lora-Regular", size: 15))
                    .padding(.trailing, 5)
                
                Button {
                    print("Going back to login!")
                    withAnimation {
                        isSignUpMode.toggle()
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
        .transition(.move(edge: .bottom))
        .frame(height: loginFieldsHeight)
        .roundedCorner(30, corners: isSignUpMode ? [] : [.topLeft, .topRight])
        .offset(y: loginSectionOffsetY)
        .padding(.bottom)
        .background(.charcoalAlways)
        .toast(isPresenting: $showSignUpFailureToast, duration: 2, tapToDismiss: true) {
            AlertToast(
                displayMode: .alert,
                type: .error(.puce),
                title: "Sign up failed!",
                subTitle: signUpError,
                style: AlertToast.AlertStyle.style(
                    backgroundColor: .ivoryAlways,
                    titleColor: .puce,
                    subTitleColor: .charcoalAlways,
                    titleFont: Font.customFont("LeagueSpartan-Regular", size: 18),
                    subTitleFont: Font.customFont("LeagueSpartan-Regular", size: 15)
                )
            )
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            LoginView(authManager: AuthManager()).preferredColorScheme($0)
        }
    }
}
