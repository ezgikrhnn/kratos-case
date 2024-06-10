//
//  KCLogInPageViewModel.swift
//  KratosCase
//
//  Created by Ezgi Karahan on 7.06.2024.
//

import Foundation
import FirebaseAuth

class KCLogInPageViewModel {
    
    func loginUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                // Giriş işlemi başarısız:
                completion(.failure(error))
            } else {
                // Giriş işlemi başarılı:
                completion(.success(()))
            }
        }
    }
}
