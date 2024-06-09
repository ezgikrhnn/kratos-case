//
//  KCCreateAccountView.swift
//  KratosCase
//
//  Created by Ezgi Karahan on 8.06.2024.
//

import UIKit

class KCCreateAccountPageView: UIView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        
    }
    
    required init?(coder: NSCoder) { ///storyboard ya da  xib başlatıcısı
        fatalError("Unsupported")    ///desteklenmediği için fatalError
    }
    
}
