//
//  SortViewController.swift
//  TestTask
//
//  Created by Хандымаа Чульдум on 16.07.2022.
//

import UIKit

class SortViewController: UIViewController {
    
    var presenter: ListOfGoodsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tappedSortButton(_ sender: UIButton) {
        let sortState: Sort = .init(rawValue: sender.tag) ?? .none
        presenter?.sort(sortState: sortState)
        
        self.dismiss(animated: true)
    }
    
    @IBAction func tappedCancelButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
