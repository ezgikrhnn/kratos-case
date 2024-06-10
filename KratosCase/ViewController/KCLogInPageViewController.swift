//
//  KCLoginPageViewController.swift
//  KratosCase
//
//  Created by Ezgi Karahan on 7.06.2024.
//

import UIKit


class KCLogInPageViewController: UIViewController, KCLogInPageViewDelegate {

    let logInView = KCLogInPageView()
    let viewModel = KCLogInPageViewModel()
    
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
            guard let email = logInView.emailTextField.text,
                  let password = logInView.passwordTextField.text else {
                // Kullanıcıdan gerekli bilgileri alamazsak işlemi iptal edelim
                // Ayrıca burada bir hata mesajı gösterebiliriz
                return
            }

        //viewmodel üzerinden oturum açma işlemi
        viewModel.loginUser(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    let vc = KCHomePageViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true, completion: nil)
                }
            case .failure(let error):
                print("Oturum açma Hatası: \(error.localizedDescription)")
            }
        }
    }
    
    func createOneButtonTapped() {
        let vc = KCCreateAccountPageViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
