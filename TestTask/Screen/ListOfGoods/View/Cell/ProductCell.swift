//
//  ProductCell.swift
//  TestTask
//
//  Created by Хандымаа Чульдум on 16.07.2022.
//

import UIKit

protocol ProductCellDelegate: AnyObject {
    func tappedAddShoppingCart(_ indexPath: IndexPath, id: String)
}

class ProductCell: UITableViewCell {

    @IBOutlet weak private var productImageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var weightLabel: UILabel!
    @IBOutlet weak private var priceLabel: UILabel!
    @IBOutlet weak private var checkImageView: UIImageView!
    
    private var id = ""
    var isHiddenCheckImageView: Bool {
        get {
            checkImageView.isHidden
        }
        set {
            checkImageView.isHidden = newValue
        }
    }
    
    private var indexPath: IndexPath?
    
    weak var delegate: ProductCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        productImageView.image = Constants.defaultImage
        isHiddenCheckImageView = true
    }
    
    func configuration(imageUrl: String, name: String, weight: String, price: String) {
        productImageView.imageFromUrl(url: imageUrl)
        nameLabel.text = name
        weightLabel.text = "☆ " + weight
        priceLabel.text = price + " ₽"
    }
    
    func setupCell(id: String, indexPath: IndexPath) {
        self.id = id
        self.indexPath = indexPath
    }
    
    @IBAction private func tappedAddShoppingCart(_ sender: Any) {
        guard let indexPath = indexPath else {
            return
        }

        delegate?.tappedAddShoppingCart(indexPath, id: id)
    }
}
