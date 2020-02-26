//
//  UITextField+Validations.swift
//  huduma
//
//  Created by macbook on 26/02/2020.
//  Copyright © 2020 Arusey. All rights reserved.
//
import Foundation
import UIKit

extension UITextField {
    func validatedText(validationType: ValidatorType) throws -> String {
        let validator = VaildatorFactory.validatorFor(type: validationType)
        return try validator.validated(self.text!)
    }
}

//extension UIImage {
//
//    public static func loadFrom(url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
//        DispatchQueue.global().async {
//            if let data = try? Data(contentsOf: url) {
//                DispatchQueue.main.async {
//                    completion(UIImage(data: data))
//                }
//            } else {
//                DispatchQueue.main.async {
//                    completion(nil)
//                }
//            }
//        }
//    }
//
//}
