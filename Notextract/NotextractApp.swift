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
        /* PROPERTIES FOR SETTING FONT TYPE, SIZE AND COLOR OF NAVIGATION BAR TITLE */
        
        let appear = UINavigationBarAppearance()
        
        appear.configureWithTransparentBackground()
        
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "LeagueSpartan-Bold", size: 36) ?? .systemFont(ofSize: 36),
            .foregroundColor: UIColor(.charcoal),
        ]

        appear.largeTitleTextAttributes = attrs
        // appear.titleTextAttributes = attrs
        UINavigationBar.appearance().standardAppearance = appear
        UINavigationBar.appearance().compactAppearance = appear
        UINavigationBar.appearance().scrollEdgeAppearance = appear
        
        /* PROPERTIES FOR SEGMENTEDPICKERSTYLE */
        
        UISegmentedControl.appearance().selectedSegmentTintColor = .gold
        UISegmentedControl.appearance().setTitleTextAttributes([.font: UIFont(name: "LeagueSpartan-Regular", size: 20) ?? .systemFont(ofSize: 20)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.font: UIFont(name: "LeagueSpartan-Regular", size: 20) ?? .systemFont(ofSize: 20)], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.ivory], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.charcoal], for: .normal)
        
        /* FIREBASE CONFIGURATION */
        // FirebaseApp.configure()
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let userStore = UserStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userStore)
        }
    }
}
