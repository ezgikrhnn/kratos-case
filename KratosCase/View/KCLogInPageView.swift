//
//  KCLogInPageView.swift
//  KratosCase
//
//  Created by Ezgi Karahan on 7.06.2024.
//

import UIKit

//butona tıklanması için delegate yazıyorum

protocol KCLogInPageViewDelegate: AnyObject {
    func logInButtonTapped()
    func createOneButtonTapped()
}

class KCLogInPageView: UIView {

    weak var delegate: KCLogInPageViewDelegate?
    
    //MARK: - Properties
    let logoImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let SimpsonBackgroundImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Background")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.font = UIFont.systemFont(ofSize: 20) // Font boyutu
        textField.setPaddingPoints(10)
        textField.layer.cornerRadius = 15
        textField.backgroundColor = .systemGray5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
        }()
        
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.setPaddingPoints(10)
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 15
        textField.isSecureTextEntry = true
        
        let eyeButton = UIButton(type: .custom)
        eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        eyeButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        eyeButton.contentMode = .center
                
        // Butona iç boşluk ekle
        eyeButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        textField.rightView = eyeButton
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
        }()
    
    let rememberLabel : UILabel = {
       let label = UILabel()
       label.text = "Remember Me"
       label.textColor = .gray
       label.font = UIFont(name: "ChalkboardSE-Bold", size: 15.0)
       label.numberOfLines = 5
       label.textAlignment = .left
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    
    let forgotPasswordLabel : UILabel = {
       let label = UILabel()
       label.text = "Forgot Password?"
       label.textColor = UIColor(named: "yellowColor")
       label.font = .systemFont(ofSize: 16, weight: .medium)
       label.numberOfLines = 5
       label.textAlignment = .left
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    
    let logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = UIColor(named: "yellowColor")
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
        return button
        }()
    
    let haveAccountLabel : UILabel = {
       let label = UILabel()
       label.text = "Don't have an account?"
       label.textColor = .gray
       label.font = .systemFont(ofSize: 16, weight: .medium)
       label.numberOfLines = 5
       label.textAlignment = .left
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    
    let createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create one", for: .normal)
        button.setTitleColor(.systemYellow, for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(createOneButtonPressed), for: .touchUpInside)
        return button
        }()
    
    lazy var accountStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [haveAccountLabel, createAccountButton])
            stackView.axis = .horizontal
            stackView.spacing = 5
            stackView.alignment = .center
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
    }()
    
    //MARK: -Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        addSubviews(SimpsonBackgroundImage, emailTextField, passwordTextField, rememberLabel, forgotPasswordLabel, logInButton, accountStackView, logoImage)
        addConstraints()
    }
    
    required init?(coder: NSCoder) { ///storyboard ya da  xib başlatıcısı
        fatalError("Unsupported")    ///desteklenmediği için fatalError
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            
            logoImage.topAnchor.constraint(equalTo: topAnchor, constant: -100),
            logoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 350),
            
            SimpsonBackgroundImage.topAnchor.constraint(equalTo: topAnchor),
            SimpsonBackgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            SimpsonBackgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            SimpsonBackgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Email text alanının konumu ve boyutu
            emailTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 120),
            emailTextField.widthAnchor.constraint(equalToConstant: 350),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
                        
            // Şifre text alanının konumu ve boyutu
            passwordTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            passwordTextField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 180),
            passwordTextField.widthAnchor.constraint(equalToConstant: 350),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            rememberLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            rememberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            
            forgotPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            forgotPasswordLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 70),
            logInButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.widthAnchor.constraint(equalToConstant: 350),
            
            accountStackView.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 30),
            accountStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
        ])
    }
    
    //log in button
    @objc private func logInButtonPressed() {
            delegate?.logInButtonTapped()
    }
    
    //create one button
    @objc private func createOneButtonPressed() {
            delegate?.createOneButtonTapped()
        }
}

extension UITextField {
    func setPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.rightView = paddingView
        self.leftViewMode = .always
        self.rightViewMode = .always
    }
}
