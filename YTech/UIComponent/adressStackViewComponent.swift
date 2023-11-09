//
//  adressStackViewComponent.swift
//  YTech
//
//  Created by Muhammet  on 9.11.2023.
//

import Foundation
import UIKit
import SnapKit

final class AddressStackViewComponent: UIStackView {
    private let pinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "pin.fill")
        return imageView
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Ev adresim"
        label.textColor = UIColor(named: "primaryBlue")
        label.font = UIFont(name: "Jost-Bold", size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    let detailAddressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Jost-Regular", size: 11)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStackView()
        configureSubviews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStackView() {
        axis = .horizontal
        distribution = .equalSpacing
        alignment = .center
        spacing = 0.5
        backgroundColor = .systemGray5
        layer.cornerRadius = 4
        isHidden = false
        
    }
    
    private func configureSubviews() {
        addArrangedSubview(pinImageView)
        addArrangedSubview(addressLabel)
        addArrangedSubview(detailAddressLabel)
    }
}
