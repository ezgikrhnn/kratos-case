//
//  File.swift
//  KratosCase
//
//  Created by Ezgi Karahan on 7.06.2024.
//

import UIKit

extension UIView{
    
    /**... operatörü (variadic parametre), metodun birden fazla UIView nesnesi alabileceğini gösterir. **/
    func addSubviews(_ views: UIView...){
        views.forEach(){
            addSubview($0)
        }
    }
}
