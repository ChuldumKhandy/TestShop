//
//  ProductModel.swift
//  TestTask
//
//  Created by Хандымаа Чульдум on 16.07.2022.
//

import Foundation

struct ProductModel: Codable {
    let id: String
    let image: String
    let price: Double
    let name: String
    let weight: Double
    let desc: String
}
