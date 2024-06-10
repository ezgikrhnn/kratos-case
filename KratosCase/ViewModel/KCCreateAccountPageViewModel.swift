//
//  KCCreateAccountPageViewModel.swift
//  KratosCase
//
//  Created by Ezgi Karahan on 10.06.2024.
//

/**UserModel sınıfında password adında bir özellik yok, çünkü şifre bir kullanıcı özelliği olarak saklanmıyor. şifreyi parametre olarak geçtim**/

import Foundation
import FirebaseAuth

class KCCreateAccountViewModel {
    
    func createAccount(with userModel: UserModel, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        // Firebase Authentication kullanarak kullanıcı oluşturma işlemini gerçekleştir
        Auth.auth().createUser(withEmail: userModel.email, password: password) { authResult, error in
            if let error = error {
                // Kullanıcı oluşturma işlemi başarısız oldu
                completion(.failure(error))
            } else {
                // Kullanıcı oluşturma işlemi başarılı
                completion(.success(()))
            }
        }
    }
}
