//
//  ShoppingCartPresenter.swift
//  TestTask
//
//  Created by Хандымаа Чульдум on 17.07.2022.
//

import Foundation

protocol ShoppingCartPresenterProtocol {
    func loadView(controller: ShoppingCartViewController)
    func getProductsInShoppingCart()
    func calculateTotalPrice() -> Double 
}

class ShoppingCartPresenter: ShoppingCartPresenterProtocol {
    private weak var controller: ShoppingCartViewControllerProtocol?
    private var products = [ShoppingCartModel]()
    
    func loadView(controller: ShoppingCartViewController) {
        self.controller = controller
    }
    
    func getProductsInShoppingCart() {
        products = ShoppingCartStorage.shared.getAll()
        controller?.didSuccess(products: products, totalPrice: calculateTotalPrice())
    }
    
    func calculateTotalPrice() -> Double {
        var price: Double = 0
        products.forEach {
            price += $0.quantity.asDouble * $0.product.price
        }
        return price
    }
}
