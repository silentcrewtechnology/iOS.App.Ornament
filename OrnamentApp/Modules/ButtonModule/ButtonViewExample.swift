//
//  ButtonViewExample.swift
//  OrnamentApp
//
//  Created by user on 30.07.2024.
//

import UIKit
import ImagesService
import Colors
import Components
import DesignSystem

private final class ButtonViewExampleVC: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var buttonView = ButtonView()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var viewProperties = ButtonView.ViewProperties()
        let style = ButtonViewStyle(
            size: .large,
            color: .accent,
            variant: .primary,
            state: .default,
            icon: .without
        )
        viewProperties.attributedText = "Example".attributed
        viewProperties.leftIcon = .ic24Book
        style.update(viewProperties: &viewProperties)
        buttonView.update(with: viewProperties)
        viewProperties.onTap = { print("Example") }
        style.update(color: .accent,
                     state: .disabled,
                     viewProperties: &viewProperties)
        viewProperties.activityIndicator.isAnimating = true
        buttonView.update(with: viewProperties)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            viewProperties.activityIndicator.isAnimating = false
            self.buttonView.update(with: viewProperties)
        }
    }
}
