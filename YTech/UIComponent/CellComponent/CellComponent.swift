//
//  CellComponent.swift
//  YTech
//
//  Created by Muhammet  on 8.11.2023.
//

import Foundation
import UIKit
import MapKit

final class CustomCellComponent: UIView {
    
    var model: ContentResult?
    
    private let baseView: UIView = {
        let view = UIView()
        return view
    }()
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        return view
    }()
    private let topStackViewComponent: TopStackComponent = {
        let stackView = TopStackComponent()
        return stackView
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    private let bottomStackViewComponent: BottomStackViewComponent = {
        let stackView = BottomStackViewComponent()
        return stackView
    }()
    private let adressStackViewComponent: AddressStackViewComponent = {
        let stackView = AddressStackViewComponent()
        return stackView
    }()
    private let totalAmountStackViewComponent: TotalAmountStackComponent = {
        let stackView = TotalAmountStackComponent()
        return stackView
    }()
    private let bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    private let finalStackView: FinalStackComponent = {
        let stackView = FinalStackComponent()
        return stackView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(baseView)
        baseView.addSubview(cardView)
        cardView.addSubview(topStackViewComponent)
        cardView.addSubview(lineView)
        cardView.addSubview(bottomStackViewComponent)
        configureConstraints()
    }
    
    func configureCells(model: ContentResult, isPastOrderVC: Bool) {
        self.model = model
        
        topStackViewComponent.orderLabel.text = model.orderSummaryStateText
        bottomStackViewComponent.adressStackView.isHidden = isPastOrderVC
        
        guard let fullAddress = model.deliveryAddress?.fullAddress else {
            bottomStackViewComponent.adressStackView.detailAddressLabel.text = "Adres bilgisi yok"
            return
        }
        bottomStackViewComponent.adressStackView.detailAddressLabel.text = fullAddress
        
        guard let itemSummary = model.itemSummary, let itemCountDouble = Double(itemSummary) else {
            
            bottomStackViewComponent.totalAmountStackViewComponent.totalAmountLabel.text = "Ürün bilgisi yok"
            return
        }
        bottomStackViewComponent.totalAmountStackViewComponent.totalAmountLabel.text = "Toplam \(Int(itemCountDouble)) Ürün"
        
        guard let text = model.finalTotalPrice?.text, let symbol = model.finalTotalPrice?.symbol else {
            bottomStackViewComponent.totalAmountStackViewComponent.totalAmount.text = "TL"
            return
        }
        bottomStackViewComponent.totalAmountStackViewComponent.totalAmount.text = text + symbol
        
        guard let createdAt = model.createdAt else {
            finalStackView.orderNumberLabel.text = "Sipariş tarihi bilgisi yok"
            return
        }
        finalStackView.orderNumberLabel.text = "Sipariş No:\(createdAt.description)"
        
        if let buttonText = model.button?.text {
            bottomStackViewComponent.totalAmountStackViewComponent.orderStatusButton.setTitle(buttonText, for: .normal)
        } else {
            bottomStackViewComponent.totalAmountStackViewComponent.orderStatusButton.titleLabel?.text = "Siparişi Değerlendir"
        }
        
        if isPastOrderVC {
            if model.orderSummaryState == "DELIVERED" {
                topStackViewComponent.orderLabel.textColor = .green
            } else if model.orderSummaryState == "CANCELLED" {
                topStackViewComponent.orderLabel.textColor = .red
            } else{
                topStackViewComponent.orderLabel.textColor = .black
            }
        }else{
            if let buttonType = model.button?.type, buttonType == "IN_DELIVERY" {
                bottomStackViewComponent.totalAmountStackViewComponent.orderStatusButton.addTarget(self, action: #selector(openDeliveryLocation), for: .touchUpInside)
            }
        }
        bottomStackViewComponent.finalStackView.orderDateLabel.text = model.deliveryDate ?? "25 Temmuz 2000"
    }
    @objc func openDeliveryLocation() {
        if let latitude = model?.deliveryAddress?.latitude, let longitude = model?.deliveryAddress?.longitude {
            let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let placemark = MKPlacemark(coordinate: coordinates)
            
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = "Teslimat Konumu"
            
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            mapItem.openInMaps(launchOptions: launchOptions)
        }
    }
}

extension CustomCellComponent {
    private func configureConstraints(){
        baseView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        cardView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().inset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
        topStackViewComponent.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(40)
        }
        lineView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topStackViewComponent.snp.bottom)
            make.height.equalTo(1)
        }
        bottomStackViewComponent.snp.makeConstraints { make in
            make.bottom.right.equalToSuperview()
            make.left.equalToSuperview()
            make.top.equalTo(lineView.snp.bottom)
        }
    }
}
