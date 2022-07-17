//
//  ProductStorage.swift
//  TestTask
//
//  Created by Хандымаа Чульдум on 16.07.2022.
//

import Foundation

class ShoppingCartStorage {
    static let shared = ShoppingCartStorage()
    
    private var products: [ShoppingCartModel] = []
    
    func getAll() -> [ShoppingCartModel] {
        guard let data = UserDefaults.standard.data(forKey: "ShoppingCartStorage"),
              let products = try? JSONDecoder().decode([ShoppingCartModel].self, from: data) else {
            return []
        }
        self.products = products
        return products
    }
    
    func addProduct(productModel: ProductModel) {
        guard var product = products.first(where: { $0.product.id == productModel.id }),
              let indexProduct = products.firstIndex(where: { $0.product.id == productModel.id }) else {
            products.append(ShoppingCartModel(product: productModel, quantity: 1))
            saveProducts()
            return
        }
        product.quantity += 1
        
        products.removeAll {
            $0.product.id == product.product.id
        }
        
        products.insert(ShoppingCartModel(product: product.product, quantity: product.quantity), at: indexProduct)
        
        saveProducts()
    }
    
    func removeProduct(productID: String, isAll: Bool) {
        guard var product = products.first(where: { $0.product.id == productID }),
              let indexProduct = products.firstIndex(where: { $0.product.id == productID }) else {
            return
        }
        
        if product.quantity == 1 || isAll {
            products.removeAll {
                $0.product.id == productID
            }
        } else {
            product.quantity -= 1
            products.removeAll {
                $0.product.id == productID
            }
            
            products.insert(ShoppingCartModel(product: product.product, quantity: product.quantity), at: indexProduct)
        }

        saveProducts()
    }
    
    func saveProducts() {
        let data = try? JSONEncoder().encode(products)
        UserDefaults.standard.set(data, forKey: "ShoppingCartStorage")
    }
}
