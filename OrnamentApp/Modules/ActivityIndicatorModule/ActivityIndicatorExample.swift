//
//  ActivityIndicatorExample.swift
//  OrnamentApp
//
//  Created by user on 29.07.2024.
//

import UIKit
import Components
import ImagesService
import Colors

private final class ActivityIndicatorExampleVC: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var indicator = ActivityIndicatorView()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(indicator)
        var viewProperties: ActivityIndicatorView.ViewProperties = .init(
            icon: .ic24SpinerLoader.withTintColor(.Core.System.green250),
            size: .init(width: 24, height: 24),
            isAnimating: true
        )
        indicator.update(with: viewProperties)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            viewProperties.isAnimating = false
            self.indicator.update(with: viewProperties)
        }
    }
    
}
