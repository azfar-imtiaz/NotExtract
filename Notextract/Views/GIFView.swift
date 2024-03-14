//
//  GIFView.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-03-14.
//

import SwiftUI
import FLAnimatedImage

struct GIFView: UIViewRepresentable {
    
    var name: String
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.addSubview(activityIndicator)
        view.addSubview(imageView)
        
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        return view
        
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        activityIndicator.startAnimating()
        guard let url = Bundle.main.url(forResource: name, withExtension: "gif") else {
            return
        }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                let image = FLAnimatedImage(animatedGIFData: data)
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    imageView.animatedImage = image
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    imageView.stopAnimating()
                }
            }
        }
    }
    
    private let imageView: FLAnimatedImageView = {
        let imageView = FLAnimatedImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // UNCOMMENT TO ADD ROUNDING TO YOUR VIEW
        // imageView.layer.cornerRadius = 24
        
        imageView.layer.masksToBounds = true
        return imageView
        
    }()
    
    
    
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .charcoal
        return activityIndicator
    }()
    
}
