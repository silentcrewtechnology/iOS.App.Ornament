//
//  InputAmountViewExample.swift
//  OrnamentApp
//
//  Created by user on 29.07.2024.
//

import UIKit
import Components
import DesignSystem

private final class InputAmountViewExampleVC: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var amountView = InputAmountView()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let delegate = CustomTextFieldDelegate()
        let style = InputAmountViewStyle()
        
        lazy var headerViewProperties: LabelView.ViewProperties = {
            var viewProperties = LabelView.ViewProperties(text: .init(string: "Header"))
            let style = LabelViewStyle(variant: .default(customColor: nil))
            style.update(viewProperties: &viewProperties)
            
            return viewProperties
        }()
        
        var viewProperties = InputAmountView.ViewProperties(
            header: headerViewProperties,
            textFieldProperties: .init(
                text: "123".attributed,
                placeholder: "0".attributed,
                delegateAssigningClosure: { textField in
                    textField.delegate = delegate
                }),
            amountSymbol: "₽".attributed,
            isUserInteractionEnabled: true)
        style.update(state: .default,
                     viewProperties: &viewProperties)
        amountView.update(with: viewProperties)
        
        style.update(state: .error("Error".attributed),
                     viewProperties: &viewProperties)
        amountView.update(with: viewProperties)
        
        style.update(state: .disabled,
                     viewProperties: &viewProperties)
        amountView.update(with: viewProperties)
    }
}

// MARK: - CustomTextFieldDelegate

private final class CustomTextFieldDelegate: NSObject, UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        if string.isEmpty { return true}
        
        guard string.allSatisfy({ "0123456789".contains($0) }) else { return false }
        
        return true
    }
}
