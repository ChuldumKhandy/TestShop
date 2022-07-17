//
//  SortingHelper.swift
//  TestTask
//
//  Created by Хандымаа Чульдум on 16.07.2022.
//

import Foundation

enum Sort: Int {
    case price = 1
    case weight = 2
    case none = 0
}

class SortingHelper {
    static let shared = SortingHelper()
    
    var currentSort: Sort = .none
    
    func getSortedProducts(state: Sort, products: [ProductModel]) -> [ProductModel] {
        currentSort = state
        switch state {
        case .price:
            return products.sorted {
                $0.price < $1.price
            }
        case .weight:
            return products.sorted {
                $0.weight > $1.weight
            }
        case .none:
            return products
        }
    }
}
