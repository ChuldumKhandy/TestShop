//
//  ListOfGoodsViewController.swift
//  TestTask
//
//  Created by Хандымаа Чульдум on 16.07.2022.
//

import UIKit

protocol ListOfGoodsViewControllerProtocol: AnyObject {
    func didSuccess(products: [ProductModel])
    func didFaild()
}

class ListOfGoodsViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    
    private let presenter: ListOfGoodsPresenterProtocol
    private var products: [ProductModel] = []
    
    init(presenter: ListOfGoodsPresenter) {
        self.presenter = presenter
        super.init(nibName: "ListOfGoodsViewController", bundle: nil)
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
        tableView.reloadData()
    }
    
    @IBAction private func tappedSortButton(_ sender: Any) {
        presenter.showSort()
    }
    
    private func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "ProductCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ProductCellIdentifier")
    }
}

extension ListOfGoodsViewController: ListOfGoodsViewControllerProtocol {
    func didSuccess(products: [ProductModel]) {
        self.products = products
        tableView.reloadData()
    }
    
    func didFaild() {
        self.showOKAlert(withText: "Данные не подгрузились:(")
    }
}

extension ListOfGoodsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCellIdentifier", for: indexPath) as? ProductCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let product = products[indexPath.row]
        
        cell.delegate = self
        cell.configuration(imageUrl: product.image,
                           name: product.name,
                           weight: product.weight.asString,
                           price: product.price.asString)
        cell.setupCell(id: product.id, indexPath: indexPath)
        cell.isHiddenCheckImageView = !presenter.isProductInCart(product)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showCardProduct(index: indexPath.row)
    }
}

extension ListOfGoodsViewController: ProductCellDelegate {
    func tappedAddShoppingCart(_ indexPath: IndexPath, id: String) {
        guard let product = products.first(where: {
            $0.id == id
        }) else {
            return
        }
        ShoppingCartStorage.shared.addProduct(productModel: product)
        DispatchQueue.main.async {
            self.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}

