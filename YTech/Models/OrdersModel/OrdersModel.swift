//
//  OrdersModel.swift
//  YTech
//
//  Created by Muhammet  on 7.11.2023.
//

import Foundation

struct OrdersModel: Codable {
    let content: [ContentResult]?
}

struct ContentResult: Codable {
    let orderId: Int?
    let orderSummaryState: String?
    let orderSummaryStateText: String?
    let deliveryAddress: DeliveryAddress?
    let itemSummary: String?
    let finalTotalPrice: Prices?
    let deliveryDate: String?
    let shipmentType: String?
    let button: Button?
    let createdAt: Int?
}

struct DeliveryAddress: Codable {
    let id: String?
    let name: String?
    let fullAddress: String?
    let latitude: Double?
    let longitude: Double?
}

struct Prices: Codable {
    let value: Double?
    let text: String?
    let currency: String?
    let symbol: String?
}

struct Button: Codable {
    let type: String?
    let text: String?
}


