//
//  NotextractApp.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-02-27.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()
      return true
  }
}

@main
struct NotextractApp: App {
    init() {
        let appear = UINavigationBarAppearance()
        
        appear.configureWithTransparentBackground()
        
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "LeagueSpartan-Bold", size: 40)!,
            .foregroundColor: UIColor(.charcoal),
        ]

        appear.largeTitleTextAttributes = attrs
        appear.titleTextAttributes = attrs
        UINavigationBar.appearance().standardAppearance = appear
        UINavigationBar.appearance().compactAppearance = appear
        UINavigationBar.appearance().scrollEdgeAppearance = appear
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
