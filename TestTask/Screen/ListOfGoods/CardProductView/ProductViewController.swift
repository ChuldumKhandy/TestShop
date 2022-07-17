//
//  ProductViewController.swift
//  TestTask
//
//  Created by Хандымаа Чульдум on 16.07.2022.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak private var productImageView: UIImageView!
    @IBOutlet weak private var productNameLabel: UILabel!
    @IBOutlet weak private var productDescLabel: UILabel!
    @IBOutlet weak private var productPriceLabel: UILabel!
    @IBOutlet weak private var productWeightLabel: UILabel!
    
    private var product: ProductModel?

    init(product: ProductModel) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        guard let product = product else {
            return
        }
        productImageView.imageFromUrl(url: product.image)
        productNameLabel.text = product.name
        productDescLabel.text = product.desc
        productPriceLabel.text = product.price.asString
        productWeightLabel.text = product.weight.asString
    }

    @IBAction private func tappedAddShoppingCartButton(_ sender: Any) {
        guard let product = product else {
            return
        }
        ShoppingCartStorage.shared.addProduct(productModel: product)
    }
    
}
