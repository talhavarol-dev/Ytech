//
//  NavigationBarCustomizer.swift
//  YTech
//
//  Created by Muhammet  on 6.11.2023.
//


import UIKit
import SnapKit

struct NavigationBarCustomizer {
    static func customizeNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "primaryYellow")
        
        let boldFont = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "primaryBlue"), NSAttributedString.Key.font: boldFont]
        appearance.titlePositionAdjustment = UIOffset(horizontal: -100, vertical: 0)
 
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}


