//
//  PastOrderViewModel.swift
//  YTech
//
//  Created by Muhammet  on 8.11.2023.
//

import Foundation
import Alamofire

protocol PastOrderViewModelProtocol{
    func fetchPastOrders(onSuccess: @escaping (OrdersModel?) -> Void, onError: @escaping (AFError) -> Void)
    func fetchFilter(onSuccess: @escaping (Filters?) -> Void, onError: @escaping (AFError) -> Void)
    
}

final class PastOrderViewModel{
    
    private var service: ServicesProtocol
    init(service: ServicesProtocol) {
        self.service = service
    }
}

extension PastOrderViewModel: PastOrderViewModelProtocol {
    func fetchPastOrders(onSuccess: @escaping (OrdersModel?) -> Void, onError: @escaping (Alamofire.AFError) -> Void) {
        service.fetchPastOrders{ orders in
            guard let orders = orders else {
                onSuccess(nil)
                return
            }
            onSuccess(orders)
        } onError: { error in
            onError(error)
        }
    }
    func fetchFilter(onSuccess: @escaping (Filters?) -> Void, onError: @escaping (Alamofire.AFError) -> Void) {
        service.fetchFilter{ filters in
            guard let filters = filters else {
                onSuccess(nil)
                return
            }
            onSuccess(filters)
        } onError: { error in
            onError(error)
        }
    }
}


