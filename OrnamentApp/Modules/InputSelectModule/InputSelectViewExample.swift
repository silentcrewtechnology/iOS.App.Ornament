//
//  InputSelectViewExampleVC.swift
//
//
//  Created by Ilnur Mugaev on 16.04.2024.
//

import UIKit
import Components
import DesignSystem

private final class InputSelectViewExampleVC: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var headerViewProperties: LabelView.ViewProperties = {
        var viewProperties = LabelView.ViewProperties(text: .init(string: "Header"))
        let style = LabelViewStyle(variant: .default(customColor: nil))
        style.update(viewProperties: &viewProperties)
        return viewProperties
    }()
    
    private lazy var hintViewProperties: OldHintView.ViewProperties = {
        var viewProperties = OldHintView.ViewProperties()
        let style = OldHintViewStyle()
        style.update(
            variant: .empty,
            viewProperties: &viewProperties
        )
        return viewProperties
    }()
    
    private lazy var viewProperties: InputSelectView.ViewProperties = {
        var viewProperties = InputSelectView.ViewProperties(
            header: headerViewProperties,
            placeholder: "Placeholder".attributed,
            hint: hintViewProperties
        )
        
        viewProperties.inputTapAction = { [weak self] in
            guard let self else { return }
            self.selectText()
        }
        
        viewProperties.clearButtonAction = { [weak self] in
            guard let self else { return }
            self.clearText()
        }
        
        style = .init(state: .default)
        style.update(viewProperties: &viewProperties)
        
        return viewProperties
    }()
    
    private lazy var inputSelectView: InputSelectView = {
        let view = InputSelectView()
        view.update(with: viewProperties)
        return view
    }()
    
    private lazy var style: InputSelectViewStyle = .init(state: .default)
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(inputSelectView)
        inputSelectView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.topMargin.equalToSuperview().inset(20)
        }
    }
    
    // MARK: - Private methods
    
    private func clearText() {
        viewProperties.text = "".attributed
        style.update(viewProperties: &viewProperties)
        inputSelectView.update(with: viewProperties)
    }
    
    private func selectText() {
        style = .init(state: .active)
        style.update(viewProperties: &viewProperties)
        inputSelectView.update(with: viewProperties)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            self.viewProperties.text = "Content".attributed
            self.style = .init(state: .default)
            self.style.update(viewProperties: &self.viewProperties)
            self.inputSelectView.update(with: self.viewProperties)
        }
    }
}
