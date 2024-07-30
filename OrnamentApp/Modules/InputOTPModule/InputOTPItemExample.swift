//
//  InputOTPItemExample.swift
//  OrnamentApp
//
//  Created by user on 30.07.2024.
//

import UIKit
import Components
import DesignSystem

private final class InputOTPItemExampleVC: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var itemView = InputOTPItemView()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let style = InputOTPItemViewStyle()
        var viewProperties = InputOTPItemView.ViewProperties(text: "0".attributed)
        style.update(state: .default, viewProperties: &viewProperties)
        itemView.update(with: viewProperties)
        style.update(state: .active, viewProperties: &viewProperties)
        itemView.update(with: viewProperties)
        style.update(state: .error, viewProperties: &viewProperties)
        itemView.update(with: viewProperties)
        style.update(state: .disabled, viewProperties: &viewProperties)
        itemView.update(with: viewProperties)
    }
}
