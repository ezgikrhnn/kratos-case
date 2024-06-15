//
//  SplashViewController.swift
//  KratosCase
//
//  Created by Ezgi Karahan on 15.06.2024.
//

import UIKit
import SwiftyGif
import FirebaseAuth
import FirebaseFirestore

class SplashViewController: UIViewController {
    
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black // Arkaplan rengini ayarla
        
        // UIImageView oluştur ve view'e ekle
        imageView.image = UIImage(named: "launch_gif.gif") // Buraya splash görüntünüzü ekleyin
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        do {
            let gif = try UIImage(gifName: "launch_gif.gif")
            imageView.setGifImage(gif)
        } catch {
            print("GIF yüklenirken hata oluştu: \(error)")
        }
        
        // UIImageView için kısıtlamalar ekle
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        // 5 saniye sonra ana ekrana geçiş yap
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.showMainScreen()
        }
    }
    
    func showMainScreen() {
        let auth: FirebaseAuthProtocol = Auth.auth()
        let firestore: FirestoreProtocol = Firestore.firestore()
        let viewModel = KCLogInPageViewModel(auth: auth, firestore: firestore)
                
        let mainVC = KCLogInPageViewController(viewModel: viewModel) // Ana ekranınızın view controller'ını burada çağırın
        mainVC.modalPresentationStyle = .fullScreen
        self.present(mainVC, animated: true, completion: nil)
    }
}
