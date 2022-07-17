//
//  ViewController.swift
//  TestTask
//
//  Created by Хандымаа Чульдум on 16.07.2022.
//

import UIKit

class CardProductPageViewController: UIPageViewController {

    private var pages = [UIViewController]()
    
    private let pageControl = UIPageControl()
    private let closeButton = UIButton()
    private var initialPage = 0
    
    private var products: [ProductModel] = []
    
    var presenter: ListOfGoodsPresenterProtocol?
    
    init(index: Int) {
        initialPage = index
        super.init(transitionStyle: .scroll,
                   navigationOrientation: .horizontal,
                   options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        setup()
        layout()
    }

    private func setup() {
        dataSource = self
        delegate = self
        
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitleColor(.systemBlue, for: .normal)
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.addTarget(self, action: #selector(tappedCloseButton(_:)), for: .primaryActionTriggered)
    }
    
    private func setData() {
        guard let products = presenter?.cardProducts() else {
            return
        }
        
        self.products = products
        products.forEach {
            let vc = ProductViewController(product: $0)
            pages.append(vc)
        }
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
    
    private func layout() {
        view.addSubview(pageControl)
        view.addSubview(closeButton)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
            closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            closeButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2)
        ])
    }
    
    @objc
    private func tappedCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension CardProductPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        return currentIndex == 0 ? pages.last : pages[currentIndex - 1]
    }
        
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }

        return currentIndex < pages.count - 1 ? pages[currentIndex + 1] : pages.first
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
    }
}
