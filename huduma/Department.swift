//
//  Department.swift
//  huduma
//
//  Created by macbook on 05/03/2020.
//  Copyright © 2020 Arusey. All rights reserved.
//

import Foundation
import UIKit


class Department: Codable {
    var name: String?
    var service: String?
    var email: String?
    var phoneNumber: String?
    var image: String?

    private enum CodingKeys: String, CodingKey {
        case name
        case service
        case email
        case phoneNumber = "phone_number"
        case image
    }


    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try? container.decode(String.self, forKey: .name)
        service = try? container.decode(String.self, forKey: .service)
        email = try? container.decode(String.self, forKey: .email)
        phoneNumber = try? container.decode(String.self, forKey: .phoneNumber)
        image = try? container.decode(String.self, forKey: .image)
        
//        if let text = try container.decodeIfPresent(String.self, forKey: .image) {
//            if let data = Data(base64Encoded: text) {
//                image = UIImage(data: data)
//            }
//        }

    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(service, forKey: .service)
        try container.encode(email, forKey: .email)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(image, forKey: .image)
        
//        if let image = image, let data = image.pngData() {
//            try container.encode(data, forKey: .image)
//        }
//        var request: URLRequest = URLRequest(url: url)

    }

    init(name: String, service: String, email: String, phoneNumber: String, image: String) {
        self.name = name
        self.service = service
        self.email = service
        self.phoneNumber = phoneNumber
        self.image = image
    }

}
