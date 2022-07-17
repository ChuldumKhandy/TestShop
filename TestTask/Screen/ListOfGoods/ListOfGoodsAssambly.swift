//
//  ListOfGoodsAssambly.swift
//  TestTask
//
//  Created by Хандымаа Чульдум on 16.07.2022.
//

import UIKit

class ListOfGoodsAssambly {
    static func build() -> UIViewController {
        let router = ListOfGoodsRouter()
        let networkService = NetworkService()
        let presenter = ListOfGoodsPresenter(router: router, networkService: networkService)
        let controller = ListOfGoodsViewController(presenter: presenter)
        router.setRootController(controller: controller)
        return controller
    }
    
    static func buildSort(presenter: ListOfGoodsPresenterProtocol) -> UIViewController {
        let sortController = SortViewController()
        sortController.presenter = presenter
        
        return sortController
    }
    
    static func buildCardProduct(presenter: ListOfGoodsPresenterProtocol, index: Int) -> UIViewController {
        let cardProductController = CardProductPageViewController(index: index)
        cardProductController.presenter = presenter
        
        return cardProductController
    }
}
