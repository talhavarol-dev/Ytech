//
//  totalAmountStackViewComponent.swift
//  YTech
//
//  Created by Muhammet  on 9.11.2023.
//

import UIKit
import SnapKit

final class TotalAmountStackComponent: UIStackView {
    let totalAmountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "primaryBlue")
        label.font = UIFont(name: "Jost-Regular", size: 12)
        label.numberOfLines = 1
        return label
    }()
    
    let totalAmount: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor(named: "primaryBlue")
        label.font = UIFont(name: "Jost-Bold", size: 16)
        return label
    }()
    
    let orderStatusButton: OrderStatusButton = {
        let button = OrderStatusButton()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        axis = .horizontal
        distribution = .equalSpacing
        alignment = .leading
        spacing = 2.0
        
        let totalAmountStack = UIStackView(arrangedSubviews: [totalAmountLabel, totalAmount])
        totalAmountStack.axis = .vertical
        totalAmountStack.alignment = .leading
        orderStatusButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        addArrangedSubview(totalAmountStack)
        addArrangedSubview(orderStatusButton)
    }
}

