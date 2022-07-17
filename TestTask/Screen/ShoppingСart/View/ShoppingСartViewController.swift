//
//  ShoppingСartViewController.swift
//  TestTask
//
//  Created by Хандымаа Чульдум on 16.07.2022.
//

import UIKit

protocol ShoppingCartViewControllerProtocol: AnyObject {
    func didSuccess(products: [ShoppingCartModel], totalPrice: Double)
    func didFaild()
}

class ShoppingCartViewController: UIViewController {

    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var totalPriceLabel: UILabel!
    
    private let presenter: ShoppingCartPresenterProtocol
    private var products: [ShoppingCartModel] = []
    
    init(presenter: ShoppingCartPresenter) {
        self.presenter = presenter
        super.init(nibName: "ShoppingСartViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadView(controller: self)
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getProductsInShoppingCart()
    }

    private func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "ShoppingCartCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ShoppingCartCellIdentifier")
    }
    
}

extension ShoppingCartViewController: ShoppingCartViewControllerProtocol {
    func didLoad() {
        
    }
    
    func didSuccess(products: [ShoppingCartModel], totalPrice: Double) {
        self.products = products
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.totalPriceLabel.text = totalPrice.asString + " ₽"
        }
    }
    
    func didFaild() {
        self.showOKAlert(withText: "Данные не подгрузились:(")
    }
}

extension ShoppingCartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCartCellIdentifier", for: indexPath) as? ShoppingCartCell else {
            return UITableViewCell()
        }
        
        let product = products[indexPath.row].product
        let quantity = products[indexPath.row].quantity
        cell.selectionStyle = .none
        cell.delegate = self
        cell.configuration(imageUrl: product.image,
                           name: product.name,
                           price: (product.price * quantity.asDouble).asString,
                           id: product.id,
                           quantity: quantity.asString)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            ShoppingCartStorage.shared.removeProduct(productID: products[indexPath.row].product.id,
                                                     isAll: true)
            presenter.getProductsInShoppingCart()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

extension ShoppingCartViewController: ShoppingCartCellDelegate {
    func tappedAddProduct(_ cell: ShoppingCartCell, id: String) {
        guard let product = products.first(where: {
            $0.product.id == id
        }) else {
            return
        }

        ShoppingCartStorage.shared.addProduct(productModel: product.product)
        presenter.getProductsInShoppingCart()
    }
    
    func tappedDeleteProduct(_ cell: ShoppingCartCell, id: String) {
        ShoppingCartStorage.shared.removeProduct(productID: id, isAll: false)
        presenter.getProductsInShoppingCart()
    }
}
