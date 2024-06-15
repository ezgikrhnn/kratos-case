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
                   
            // UIImageView için kısıtlamalar ekle
            NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor)
            ])
                    
            // 5 sn sonra ana ekrana geçiş yap
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                self.showMainScreen()
            }
                    
            } catch {
                print("GIF yüklenirken hata oluştu: \(error)")
            }
    }
    
    func showMainScreen() {
        let auth: FirebaseAuthProtocol = Auth.auth()
        let firestore: FirestoreProtocol = Firestore.firestore()
        let viewModel = KCLogInPageViewModel(auth: auth, firestore: firestore)
                
        let vc = KCLogInPageViewController(viewModel: viewModel) // Ana ekran vc'si
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
