//
//  KCLoginPageViewController.swift
//  KratosCase
//
//  Created by Ezgi Karahan on 7.06.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class KCLogInPageViewController: UIViewController, KCLogInPageViewDelegate {

    let logInView = KCLogInPageView()
    let viewModel : KCLogInPageViewModelProtocol
    
    //dependency Injection için constructor
    init(viewModel: KCLogInPageViewModelProtocol){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logInView.delegate = self //delegate
        view.addSubview(logInView)
        view.backgroundColor = .systemBackground
        addCostraints()
    }
    
    func addCostraints(){
        logInView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            logInView.topAnchor.constraint(equalTo: view.topAnchor),
            logInView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            logInView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logInView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func logInButtonTapped() {
        guard let email = logInView.emailTextField.text?.lowercased(),
                  let password = logInView.passwordTextField.text else {
                //kullanıcıdan bilgileri alamadım, uyarı göster:
            showAlert(title: "Error", message: "Invalid user name or password")
            return
            }
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)

        //viewmodel üzerinden oturum açma işlemi
        viewModel.loginUser(email: trimmedEmail, password: password) { [weak self] result in
            switch result {
            case .success(let userModel):
                DispatchQueue.main.async {
                    let vc = KCHomePageViewController(userModel: userModel)
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true, completion: nil)
                }
            case .failure(let error):
                print("Oturum açma Hatası: \(error.localizedDescription)")
                self?.showAlert(title: "Login Error", message: "Invalid user name or password")
            }
        }
    }
    
    func createOneButtonTapped() {
        let viewModel = KCCreateAccountViewModel(auth: Auth.auth(), firestore: Firestore.firestore())
        let vc = KCCreateAccountPageViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
