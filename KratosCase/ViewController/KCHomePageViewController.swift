//
//  KCHomePageViewController.swift
//  KratosCase
//
//  Created by Ezgi Karahan on 7.06.2024.
//

import UIKit

class KCHomePageViewController: UIViewController, KCHomePageViewDelegate{
  
    private let homeView = KCHomePageView()
    var userModel: UserModel?
    let viewModel : KCHomePageViewModel
   
    init(userModel: UserModel) {
            self.userModel = userModel
            self.viewModel = KCHomePageViewModel(userModel: userModel)
            super.init(nibName: nil, bundle: nil)
        }
        
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home Page"
        view.addSubview(homeView)
        addCostraints()
        
        if let userModel = userModel {
            homeView.titleLabel.text = "\(userModel.name) \(userModel.surname)"
        }
    }
    
    func addCostraints(){
        homeView.delegate = self
        homeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            homeView.topAnchor.constraint(equalTo: view.topAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func logOutButtonTapped() {
        let vc = KCLogInPageViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    

}
