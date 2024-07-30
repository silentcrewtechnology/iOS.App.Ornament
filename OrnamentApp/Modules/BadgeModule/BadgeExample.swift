//
//  BadgeExample.swift
//  OrnamentApp
//
//  Created by user on 29.07.2024.
//

import UIKit
import Components
import DesignSystem
import ImagesService

private final class BadgeExampleVC: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var badgeView = BadgeView()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let style = BadgeStyle(
            color: .accent,
            size: .large,
            set: .full
        )
        var viewProperties = BadgeView.ViewProperties(text: .init(string: "Example"), image: .ic16Tick)
        style.update(viewProperties: &viewProperties)
        badgeView.update(with: viewProperties)
    }
}
