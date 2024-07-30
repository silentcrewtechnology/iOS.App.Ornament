//
//  InputTextViewExampleVC.swift
//  OrnamentApp
//
//  Created by user on 29.07.2024.
//

import UIKit
import SnapKit
import DesignSystem
import Components
import ImagesService

private final class InputTextViewExampleVC: UIViewController {
    
    // MARK: - Private properties
    
    private let feature = InputTextViewExampleFeature()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vStack = vStack()
        vStack.addArrangedSubview(feature.view)
        
        view.addSubview(vStack)
        vStack.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.feature.showLeftError(message: "Error")
        }
    }
    
    // MARK: - Private methods
    
    private func vStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        
        return stack
    }
}

// MARK: - InputTextViewExampleFeature

private final class InputTextViewExampleFeature: NSObject, UITextFieldDelegate {
    
    // MARK: - Private properties
    
    private lazy var headerViewProperties: LabelView.ViewProperties = {
        var viewProperties = LabelView.ViewProperties(text: .init(string: "Header"))
        let style = LabelViewStyle(variant: .default)
        style.update(viewProperties: &viewProperties)
        
        return viewProperties
    }()
    
    private let style = InputTextViewStyle()
    private var isEnabled = true
    
    // MARK: - Properties
    
    let view = InputTextView()
    var viewProperties: InputTextView.ViewProperties = .init()
    
    // MARK: - Life cycle
    
    override init() {
        super.init()
        
        setupView()
    }
    
    // MARK: - Methods
    
    func showLeftError(message: String) {
        style.update(state: .error(message.attributed), viewProperties: &viewProperties)
        view.update(with: viewProperties)
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        viewProperties.header = headerViewProperties
        viewProperties.textField.text = "Content".attributed
        viewProperties.textField.placeholder = "Placeholder".attributed
        viewProperties.rightViews = [
            {
                let view = UIImageView(image: .ic24Car)
                view.snp.makeConstraints { $0.size.equalTo(24) }
                view.isUserInteractionEnabled = true
                view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(iconTapped)))
                return view
            }()
        ]
        viewProperties.textField.delegateAssigningClosure = { [weak self] textField in
            guard let self else { return }
            textField.delegate = self
            textField.addTarget(self, action: #selector(self.onTextChange(textField:)), for: .editingChanged)
        }
        style.update(state: .default, viewProperties: &viewProperties)
        view.update(with: viewProperties)
    }
    
    @objc private func onTextChange(textField: UITextField) {
        viewProperties.textField.text = (textField.text ?? "").attributed
        style.update(state: .default, viewProperties: &viewProperties)
    }
    
    @objc private func iconTapped() {
        guard isEnabled else { return }
        
        print("icon tapped")
    }
}
