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
        var style = ButtonViewStyle(
            context: .action(.contained),
            state: .default,
            size: .sizeM
        )
        viewProperties.attributedText = "Example".attributed
        viewProperties.leftIcon = .ic24Book
        viewProperties.rightIcon = .ic24FilledBook
        viewProperties.onHighlighted = { [weak self] isHighlighted in
            style.state = isHighlighted ? .pressed : .default
            style.update(viewProperties: &viewProperties)
            self?.buttonView.update(with: viewProperties)
        }
        viewProperties.onTap = { print("Example") }
        
        style.state = .disabled
        style.update(viewProperties: &viewProperties)
        buttonView.update(with: viewProperties)
        
        viewProperties.activityIndicator.isAnimating = true
        buttonView.update(with: viewProperties)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            viewProperties.activityIndicator.isAnimating = false
            self.buttonView.update(with: viewProperties)
        }
    }
}
