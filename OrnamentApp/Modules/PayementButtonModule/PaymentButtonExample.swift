//
//  PaymentButtonExample.swift
//  OrnamentApp
//
//  Created by user on 30.07.2024.
//

import UIKit
import Components
import DesignSystem

private final class PaymentButtonExampleVC: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var paymentButton = PaymentButton()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(paymentButton)
        let style = PaymentButtonStyle()
        var viewProperties = PaymentButton.ViewProperties(
            text: "Добавить в".attributed,
            image: .ic24Bill.withTintColor(style.tintColor()),
            onTap: { print("tapped") })
        style.update(viewProperties: &viewProperties)
        paymentButton.update(with: viewProperties)
    }
}
