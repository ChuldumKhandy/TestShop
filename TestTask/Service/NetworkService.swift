//
//  NetworkService.swift
//  TestTask
//
//  Created by Хандымаа Чульдум on 16.07.2022.
//

import Alamofire
import Foundation

protocol NetworkServiceProtocol {
    func getGoods(_ completion: @escaping(([ProductModel]?, Error?) -> Void))
}

struct NetworkService: NetworkServiceProtocol {
    func getGoods(_ completion: @escaping (([ProductModel]?, Error?) -> Void)) {
        let url = Constants.baseUrl + "getGoods"
        
        let request = AF.request(url,
                                 method: .get)
        
        request.responseDecodable(of: [ProductModel].self) { response in
            switch response.result {
            case .failure(let error):
                completion(nil, error)
            case .success(let products):
                completion(products, nil)
                
            }
        }
    }
    
}
