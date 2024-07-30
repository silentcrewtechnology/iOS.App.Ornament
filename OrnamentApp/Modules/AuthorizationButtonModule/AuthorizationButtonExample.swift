//
//  AuthorizationButtonExample.swift
//
//
//  Created by Ilnur Mugaev on 21.03.2024.
//

import UIKit
import Components
import DesignSystem

private final class AuthorizationButtonExampleVC: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var buttonView = AuthorizationButton()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let style = AuthorizationButtonStyle(
            variant: .gosuslugi,
            isInversed: true
        )
        var viewProperties = AuthorizationButton.ViewProperties(
            image: .ic24Book,
            title: "Войти через Госуслуги".attributed,
            onTap: { print("tapped") }
        )
        style.update(viewProperties: &viewProperties)
        buttonView.update(with: viewProperties)
    }
}
