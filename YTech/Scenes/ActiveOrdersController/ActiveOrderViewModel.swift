//
//  HomeViewModel.swift
//  YTech
//
//  Created by Muhammet  on 7.11.2023.
//

import Alamofire

protocol ActiveOrderViewModelProtocol{
    func fetchActiveOrders(onSuccess: @escaping (OrdersModel?) -> Void, onError: @escaping (AFError) -> Void)
}

final class ActiveOrderViewModel{
    
    private var service: ServicesProtocol
    init(service: ServicesProtocol) {
        self.service = service
    }
}
extension ActiveOrderViewModel: ActiveOrderViewModelProtocol {
    func fetchActiveOrders(onSuccess: @escaping (OrdersModel?) -> Void, onError: @escaping (Alamofire.AFError) -> Void) {
        service.fetchActiveOrders { orders in
            guard let orders = orders else {
                onSuccess(nil)
                return
            }
            onSuccess(orders)
        } onError: { error in
            onError(error)
        }
    }
}
