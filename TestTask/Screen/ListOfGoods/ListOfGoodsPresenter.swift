//
//  ListOfGoodsPresenter.swift
//  TestTask
//
//  Created by Хандымаа Чульдум on 16.07.2022.
//

import Foundation

protocol ListOfGoodsPresenterProtocol {
    func loadView(controller: ListOfGoodsViewController)
    func showSort()
    func sort(sortState: Sort)
    func isProductInCart(_ product: ProductModel) -> Bool
    func showCardProduct(index: Int)
    func cardProducts() -> [ProductModel]
}

class ListOfGoodsPresenter: ListOfGoodsPresenterProtocol {
    private weak var controller: ListOfGoodsViewControllerProtocol?
    private var networkService: NetworkServiceProtocol
    private let router: ListOfGoodsRouterProtocol
    private var products = [ProductModel]()
    private let sortHelper = SortingHelper.shared
    
    init(router: ListOfGoodsRouter, networkService: NetworkService) {
        self.networkService = networkService
        self.router = router
    }
    
    func loadView(controller: ListOfGoodsViewController) {
        self.controller = controller
        downloadTask()
    }
    
    func sort(sortState: Sort) {
        products = sortHelper.getSortedProducts(state: sortState, products: products)
        controller?.didSuccess(products: products)
    }
    
    func showSort() {
        router.showSortView(presentor: self)
    }
    
    func showCardProduct(index: Int) {
        router.showCardProductView(presentor: self, index: index)
    }
    
    func cardProducts() -> [ProductModel] {
        return products
    }
    
    func isProductInCart(_ product: ProductModel) -> Bool {
        let allProductsInCart = ShoppingCartStorage.shared.getAll()
        return !allProductsInCart.isEmpty && allProductsInCart.first(where: { $0.product.id == product.id }) != nil
    }
    
    private func downloadTask() {
        networkService.getGoods { [weak self] products, error in
            guard let self = self else {
                self?.controller?.didFaild()
                return
            }
            DispatchQueue.main.async {
                if let error = error {
                    self.controller?.didFaild()
                    print("error - \(error.localizedDescription)")
                    return
                }
                if let products = products {
                    self.products = self.sortHelper.getSortedProducts(state: self.sortHelper.currentSort, products: products)
                    self.controller?.didSuccess(products: products)
                }
            }
        }
    }
    
}
