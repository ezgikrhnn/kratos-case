//
//  KCCreateAccountPageViewController.swift
//  KratosCase
//
//  Created by Ezgi Karahan on 8.06.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class KCCreateAccountPageViewController: UIViewController, KCCreateAccountPageViewDelegate {
  
    let CAview = KCCreateAccountPageView()
    let viewModel : KCCreateAccountViewModelProtocol
        
    // Dependency Injection ile ViewModel geçirilmesi
    init(viewModel: KCCreateAccountViewModelProtocol) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Account Page"
        view.addSubview(CAview)
        view.backgroundColor = .green
        addCostraints()
    }
    
    func addCostraints(){
        CAview.delegate = self 
        CAview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            CAview.topAnchor.constraint(equalTo: view.topAnchor),
            CAview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            CAview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            CAview.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func cancelButtonTapped() {
        let viewModel2 = KCLogInPageViewModel(auth: Auth.auth(), firestore: Firestore.firestore())
        let vc = KCLogInPageViewController(viewModel: viewModel2)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func createAccountButtonTapped() {
        // Kullanıcının e-posta, şifre, ad ve soyadı bilgilerini alıyorum
        guard let email = CAview.emailTextField.text?.lowercased(),
                 let password = CAview.passwordTextField.text,
                 let name = CAview.nameTextField.text,
                 let surname = CAview.surnameTextField.text else {
               return
           }
        //email boşluklu oluşturulursa hata alıyor:gmail
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // UserModel oluşturma
               let userModel = UserModel(name: name, surname: surname, email: trimmedEmail, uid: "")
               
               // ViewModel üzerinden hesap oluşturma işlemi
               viewModel.createAccount(with: userModel, password: password) { [weak self] (result: Result<UserModel, Error>) in
                   switch result {
                   case .success(let userModel):
                       // Başarılı bir şekilde hesap oluştu, ana ekrana geçiş yap
                       DispatchQueue.main.async {
                        
                            let vc = KCHomePageViewController(userModel: userModel)
                           vc.modalPresentationStyle = .fullScreen
                           self?.present(vc, animated: true, completion: nil)
                       }
                   case .failure(let error):
                       // Hata oluştuğunda kullanıcıya bilgi ver
                       print("Kullanıcı oluşturma hatası: \(error.localizedDescription)")
                       // Ayrıca burada bir hata mesajı gösterebiliriz
                   }
        }
    }
}
