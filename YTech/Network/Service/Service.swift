//
//  Service.swift
//  YTech
//
//  Created by Muhammet  on 7.11.2023.
//

import Foundation
import Alamofire

//MARK: - Services Protocol
protocol ServicesProtocol {
    // Movie Functions
    func fetchActiveOrders(onSuccess: @escaping (OrdersModel?) -> Void, onError: @escaping (AFError) -> Void)
    func fetchPastOrders(onSuccess: @escaping (OrdersModel?) -> Void, onError: @escaping (AFError) -> Void)
    func fetchFilter(onSuccess: @escaping (Filters?) -> Void, onError: @escaping (AFError) -> Void)
    
}

//MARK: - Service
final class Services: ServicesProtocol {
    func fetchActiveOrders(onSuccess: @escaping (OrdersModel?) -> Void, onError: @escaping (AFError) -> Void) {
        ServiceManager.shared.fetch(path: Constant.NetworkConstant.OrdersServiceEndPoint.fetchActiveOrders()) { (response: OrdersModel) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
    
    func fetchPastOrders(onSuccess: @escaping (OrdersModel?) -> Void, onError: @escaping (AFError) -> Void) {
        ServiceManager.shared.fetch(path: Constant.NetworkConstant.OrdersServiceEndPoint.fetchPastOrders()) { (response: OrdersModel) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
    
    func fetchFilter(onSuccess: @escaping (Filters?) -> Void, onError: @escaping (AFError) -> Void) {
        ServiceManager.shared.fetch(path: Constant.NetworkConstant.OrdersServiceEndPoint.fetchFilter()) { (response: Filters) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
}
