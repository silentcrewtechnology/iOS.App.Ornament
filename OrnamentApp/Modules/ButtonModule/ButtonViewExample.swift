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
    
    private lazy var buttonViewService: ButtonViewService = .init(
        viewProperties: .init(onTap: { print("Example") }),
        style: .init(
            size: .large,
            color: .accent,
            variant: .primary,
            state: .default,
            icon: .without
        )
    )
    
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
        buttonViewService.update(
            newState: .loading,
            newIcon: .with(.ic24Book),
            newText: "Example".attributed
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [self] in
            buttonViewService.update(
                newState: .default
            )
        }
    }
}
