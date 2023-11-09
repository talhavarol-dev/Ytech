//
//  orderStatusButtonComponent.swift
//  YTech
//
//  Created by Muhammet  on 9.11.2023.
//

import Foundation
import UIKit

final class OrderStatusButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureButton() {
        layer.cornerRadius = 4
        backgroundColor = UIColor(named: "primaryBlue")
        titleLabel?.font = UIFont(name: "Jost-Bold", size: 14)
    }
}
