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
    
    private lazy var buttonIconService: ButtonIconService = .init(
        viewProperties: .init(
            image: .ic24Close,
            onTap: { print("Example") }
        ),
        style: .init(
            variant: .primary,
            size: .large,
            state: .default,
            color: .accent
        )
    )
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonIconService.update(
            newSize: .small,
            newImage: .ic16Close
        )
    }
}
