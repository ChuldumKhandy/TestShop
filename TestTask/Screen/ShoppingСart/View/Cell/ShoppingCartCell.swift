//
//  ShoppingCartCell.swift
//  TestTask
//
//  Created by Хандымаа Чульдум on 17.07.2022.
//

import UIKit

protocol ShoppingCartCellDelegate: AnyObject {
    func tappedAddProduct(_ cell: ShoppingCartCell, id: String)
    func tappedDeleteProduct(_ cell: ShoppingCartCell, id: String)
}

class ShoppingCartCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    
    private var id = ""
    weak var delegate: ShoppingCartCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = Constants.defaultImage
        priceLabel.text = ""
        productQuantityLabel.text = ""
    }
    
    func configuration(imageUrl: String, name: String, price: String, id: String, quantity: String) {
        productImageView.imageFromUrl(url: imageUrl)
        nameLabel.text = name
        priceLabel.text = price + " ₽"
        productQuantityLabel.text = quantity + " шт."
        self.id = id
    }
    
    @IBAction private func tappedAddButton(_ sender: Any) {
        delegate?.tappedAddProduct(self, id: id)
    }
    
    @IBAction private func tappedDeleteButton(_ sender: Any) {
        delegate?.tappedDeleteProduct(self, id: id)
    }
    
}
