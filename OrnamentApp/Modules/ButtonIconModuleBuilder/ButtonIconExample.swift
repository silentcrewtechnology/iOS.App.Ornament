//
//  ButtonIconExample.swift
//  OrnamentApp
//
//  Created by user on 29.07.2024.
//

import UIKit
import Components
import DesignSystem
import ImagesService

private final class ButtonIconExampleVC: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var buttonIcon = ButtonIcon()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let style = ButtonIconStyle(
            variant: .primary, 
            size: .large,
            state: .loading,
            color: .accent
        )
        var viewProperties = ButtonIcon.ViewProperties()
        style.update(viewProperties: &viewProperties)
        buttonIcon.update(with: viewProperties)
    }
}
