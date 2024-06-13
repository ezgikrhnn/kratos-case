//
//  KCLogInPageViewModel.swift
//  KratosCase
//
//  Created by Ezgi Karahan on 7.06.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class KCLogInPageViewModel {
    
    func loginUser(email: String, password: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                let uid = authResult.user.uid
                let db = Firestore.firestore()
                let userRef = db.collection("users").document(uid)
                
                userRef.getDocument { document, error in
                    if let document = document, document.exists {
                        if let data = document.data(),
                           let name = data["name"] as? String,
                           let surname = data["surname"] as? String,
                           let email = data["email"] as? String {
                            let userModel = UserModel(name: name, surname: surname, email: email, uid: uid)
                            completion(.success(userModel))
                        } else {
                            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Veri formatı hatası"])))
                        }
                    } else {
                        completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Kullanıcı bulunamadı"])))
                    }
                }
            }
        }
    }
}
