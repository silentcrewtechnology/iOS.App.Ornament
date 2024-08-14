//
//  ButtonAuthExample.swift
//
//
//  Created by Ilnur Mugaev on 21.03.2024.
//

import UIKit
import Components
import DesignSystem

private final class ButtonAuthExampleVC: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var buttonView = ButtonAuth()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let style = ButtonAuthStyle(
            variant: .gosuslugi,
            state: .default,
            color: .accent
        )
        var viewProperties = ButtonAuth.ViewProperties(
            image: .ic24Book,
            title: "Войти через Госуслуги".attributed,
            onTap: { print("tapped") }
        )
        style.update(viewProperties: &viewProperties)
        buttonView.update(with: viewProperties)
    }
}
