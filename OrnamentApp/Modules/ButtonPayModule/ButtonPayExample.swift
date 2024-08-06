//
//  ButtonPayExample.swift
//  OrnamentApp
//
//  Created by user on 30.07.2024.
//

import UIKit
import Components
import DesignSystem

private final class ButtonPayExampleVC: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var buttonPay = ButtonPay()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(buttonPay)
        let style = ButtonPayStyle(type: .apple)
        var viewProperties = ButtonPay.ViewProperties(
            onTap: { print("tapped") }
        )
        style.update(viewProperties: &viewProperties)
        buttonPay.update(with: viewProperties)
    }
}
