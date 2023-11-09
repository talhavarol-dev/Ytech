//
//  NetworkConstant.swift
//  YTech
//
//  Created by Muhammet  on 7.11.2023.
//

import Foundation

extension Constant {
    // MARK: - Network
    class NetworkConstant{
        
        enum OrdersServiceEndPoint: String {
            case BASE_URL = "https://demo5416316.mockable.io"
            case activeORDERS = "/active-orders"
            case pastORDERS = "/past-orders"
            case FILTER = "/order-filters"

            static func fetchActiveOrders() -> String {
                "\(BASE_URL.rawValue)\(activeORDERS.rawValue)"
            }
            
            static func fetchPastOrders() -> String {
                "\(BASE_URL.rawValue)\(pastORDERS.rawValue)"
            }
            
            static func fetchFilter() -> String {
                "\(BASE_URL.rawValue)\(FILTER.rawValue)"
            }
        }
    }
}
