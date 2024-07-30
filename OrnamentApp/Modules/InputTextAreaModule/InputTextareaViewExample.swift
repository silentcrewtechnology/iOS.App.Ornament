//
//  InputTextareaViewExample.swift
//
//
//  Created by Ilnur Mugaev on 05.04.2024.
//

import UIKit
import Components
import DesignSystem

private final class InputTextareaViewExampleVC: UIViewController {
    
    // MARK: - Private properties
    
    private let maxCount = 15
    
    private lazy var headerViewProperties: LabelView.ViewProperties = {
        var viewProperties = LabelView.ViewProperties(text: .init(string: "Header"))
        let style = LabelViewStyle(variant: .default)
        style.update(viewProperties: &viewProperties)
        return viewProperties
    }()
    
    private lazy var hintViewProperties: HintView.ViewProperties = {
        var viewProperties = HintView.ViewProperties()
        return viewProperties
    }()
    
    private lazy var viewProperties: InputTextareaView.ViewProperties = {
        var viewProperties = InputTextareaView.ViewProperties(
            header: headerViewProperties,
            text: "Content".attributed,
            placeholder: "Placeholder".attributed,
            hint: hintViewProperties,
            textViewHeight: .custom(lines: 4, autoResizeHeight: true)
        )
        
        let style = InputTextareaViewStyle(state: .default)
        style.update(viewProperties: &viewProperties)
        
        viewProperties.delegateAssigningClosure = { [weak self] textView in
            guard let self else { return }
            textView.delegate = self.delegate
        }
        
        return viewProperties
    }()
    
    private lazy var delegate: TextareaViewTextViewDelegate = {
        let delegate = TextareaViewTextViewDelegate(
            onDidChange: { [weak self] text in
                guard let self else { return }
                self.updateViewProperties(for: text, state: .active, viewProperties: &self.viewProperties)
            },
            onDidBeginEditing: { [weak self] text in
                guard let self else { return }
                self.updateViewProperties(for: text, state: .active, viewProperties: &self.viewProperties)
            },
            onDidEndEditing: { [weak self] text in
                guard let self else { return }
                self.updateViewProperties(for: text, state: .default, viewProperties: &self.viewProperties)
            }
        )
        return delegate
    }()
    
    private lazy var inputTextarea: InputTextareaView = {
        let view = InputTextareaView()
        view.update(with: viewProperties)
        return view
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(inputTextarea)
        inputTextarea.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.topMargin.equalToSuperview().inset(20)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Private methods
    
    private func updateViewProperties(
        for text: String?,
        state: InputTextareaViewStyle.State,
        viewProperties: inout InputTextareaView.ViewProperties
    ) {
        let characterCount = text?.count ?? 0
        let currentState: InputTextareaViewStyle.State = characterCount > maxCount ? .error : state
        
        updateHintStyle(
            for: currentState,
            characterCount: characterCount,
            viewProperties: &viewProperties
        )
        
        viewProperties.text = text?.attributed
        viewProperties.hint = hintViewProperties
        
        let style = InputTextareaViewStyle(state: currentState)
        style.update(viewProperties: &viewProperties)
        
        inputTextarea.update(with: viewProperties)
    }
    
    private func updateHintStyle(
        for state: InputTextareaViewStyle.State,
        characterCount: Int,
        viewProperties: inout InputTextareaView.ViewProperties
    ) {
        let hintStyle = HintViewStyle()
        
        switch state {
        case .default, .disabled:
            hintStyle.update(
                variant: .empty,
                viewProperties: &hintViewProperties
            )
        case .active:
            hintStyle.update(
                variant: .right(
                    "\(characterCount)/\(maxCount)".attributed.foregroundColor(.Core.Brand.primary300)
                ),
                viewProperties: &hintViewProperties
            )
        case .error:
            hintStyle.update(
                variant: .both(
                    "Максимум \(maxCount) символов".attributed.foregroundColor(.Core.System.red250),
                    "\(characterCount)/\(maxCount)".attributed.foregroundColor(.Core.System.red250)
                ),
                viewProperties: &hintViewProperties
            )
        }
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - TextareaViewTextViewDelegate

private final class TextareaViewTextViewDelegate: NSObject, UITextViewDelegate {
    
    // MARK: - Private properties
    
    private var onDidChange: (String?) -> Void
    private var onDidBeginEditing: (String?) -> Void
    private var onDidEndEditing: (String?) -> Void
    
    // MARK: - Life cycle
    
    init(
        onDidChange: @escaping (String?) -> Void,
        onDidBeginEditing: @escaping (String?) -> Void,
        onDidEndEditing: @escaping (String?) -> Void
    ) {
        self.onDidChange = onDidChange
        self.onDidBeginEditing = onDidBeginEditing
        self.onDidEndEditing = onDidEndEditing
    }
    
    // MARK: - Methods
    
    func textViewDidChange(_ textView: UITextView) {
        onDidChange(textView.text)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        onDidBeginEditing(textView.text)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        onDidEndEditing(textView.text)
    }
}
