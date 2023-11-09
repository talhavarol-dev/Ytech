//
//  FilterModel.swift
//  YTech
//
//  Created by Muhammet  on 7.11.2023.
//

import Foundation

// MARK: - Filters
struct Filters: Codable {
    let content: [Content]?
}

// MARK: - Content
struct Content: Codable {
    let name, value: String?
}
    
