//
//  ListOfGoodsRouter.swift
//  TestTask
//
//  Created by Хандымаа Чульдум on 16.07.2022.
//

import UIKit

protocol ListOfGoodsRouterProtocol {
    func setRootController(controller: UIViewController)
    func showSortView(presentor: ListOfGoodsPresenterProtocol)
    func showCardProductView(presentor: ListOfGoodsPresenterProtocol, index: Int)
}

final class ListOfGoodsRouter {
    private var controller: UIViewController?
}

extension ListOfGoodsRouter: ListOfGoodsRouterProtocol {
    func setRootController(controller: UIViewController) {
        self.controller = controller
    }
    
    func showSortView(presentor: ListOfGoodsPresenterProtocol) {
        let sortVC = ListOfGoodsAssambly.buildSort(presenter: presentor)
        sortVC.modalPresentationStyle = .overCurrentContext
        self.controller?.present(sortVC, animated: true)
    }
    
    func showCardProductView(presentor: ListOfGoodsPresenterProtocol, index: Int) {
        let cardProductVC = ListOfGoodsAssambly.buildCardProduct(presenter: presentor, index: index)
        cardProductVC.modalPresentationStyle = .overCurrentContext
        self.controller?.present(cardProductVC, animated: true)
    }
}
