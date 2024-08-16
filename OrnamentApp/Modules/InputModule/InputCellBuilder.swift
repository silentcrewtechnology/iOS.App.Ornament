//
//  InputTextCellBuilder.swift
//  OrnamentApp
//
//  Created by user on 12.07.2024.
//

import UIKit
import ArchitectureTableView
import Components
import DesignSystem
import ImagesService
import Extensions

final class InputCellBuilder: NSObject, UITextFieldDelegate, CellBuilder {
    
    public class Input: UIView, Reusable {
        
        // MARK: - Properties
        
        public struct ViewProperties {
            public var labelViewProperties: LabelView.ViewProperties?
            public var hintViewProperties: HintView.ViewProperties
            public var textFieldViewProperties: InputTextField.ViewProperties
            public var textFieldBackgroundColor: UIColor
            public var textFieldCornerRadius: CGFloat
            public var textFieldBorderColor: UIColor
            public var textFieldBorderWidth: CGFloat
            public var textFieldHeight: CGFloat
            public var textFieldInsets: UIEdgeInsets
            public var minHeight: CGFloat
            public var rightView: UIView
            public var isEnabled: Bool
            public var stackViewInsets: UIEdgeInsets
            public var stackViewSpacing: CGFloat
           
            public init(
                labelViewProperties: LabelView.ViewProperties? = nil,
                hintViewProperties: HintView.ViewProperties = .init(),
                textFieldViewProperties: InputTextField.ViewProperties = .init(),
                textFieldBackgroundColor: UIColor = .clear,
                textFieldCornerRadius: CGFloat = .zero,
                textFieldBorderColor: UIColor = .clear,
                textFieldBorderWidth: CGFloat = .zero,
                textFieldHeight: CGFloat = .zero,
                textFieldInsets: UIEdgeInsets = .zero,
                minHeight: CGFloat = .zero,
                rightView: UIView = .init(),
                isEnabled: Bool = true,
                stackViewInsets: UIEdgeInsets = .zero,
                stackViewSpacing: CGFloat = .zero
            ) {
                self.labelViewProperties = labelViewProperties
                self.hintViewProperties = hintViewProperties
                self.textFieldViewProperties = textFieldViewProperties
                self.textFieldBackgroundColor = textFieldBackgroundColor
                self.textFieldCornerRadius = textFieldCornerRadius
                self.textFieldBorderColor = textFieldBorderColor
                self.textFieldBorderWidth = textFieldBorderWidth
                self.textFieldHeight = textFieldHeight
                self.textFieldInsets = textFieldInsets
                self.minHeight = minHeight
                self.rightView = rightView
                self.isEnabled = isEnabled
                self.stackViewInsets = stackViewInsets
                self.stackViewSpacing = stackViewSpacing
            }
        }
        
        // MARK: - Private properties
        
        private lazy var verticalStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical

            return stack
        }()
        
        private lazy var textFieldContainer = UIView()
        private lazy var labelView = LabelView()
        private lazy var textField = InputTextField()
        private lazy var hintView = HintView()
        
        private var viewProperties: ViewProperties = .init()
        
        public func prepareForReuse() {
        }
        
        // MARK: - Public methods
        
        public func update(with viewProperties: ViewProperties) {
            DispatchQueue.main.async {
                self.viewProperties = viewProperties
                
                self.setupView(viewProperties: viewProperties)
                self.updateLabelView(with: viewProperties.labelViewProperties)
                self.updateTextField(with: viewProperties)
                self.hintView.update(with: viewProperties.hintViewProperties)
            }
        }
        
        // MARK: - Private methods
        
        private func setupView(viewProperties: ViewProperties) {
            removeConstraintsAndSubviews()
            
            addSubview(verticalStack)
            verticalStack.spacing = viewProperties.stackViewSpacing
            verticalStack.isUserInteractionEnabled = true
            verticalStack.addArrangedSubview(labelView)
            verticalStack.addArrangedSubview(textFieldContainer)
            verticalStack.addArrangedSubview(hintView)
            verticalStack.distribution = .fill
            verticalStack.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(viewProperties.stackViewInsets)
                make.height.greaterThanOrEqualTo(viewProperties.minHeight)
            }
            
            textFieldContainer.clipsToBounds = true
            textFieldContainer.snp.makeConstraints { make in
                make.height.equalTo(viewProperties.textFieldHeight)
            }
            
            textFieldContainer.addSubview(textField)
            textField.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(viewProperties.textFieldInsets)
            }
        }
        
        private func updateLabelView(with labelViewProperties: LabelView.ViewProperties?) {
            if let labelViewProperties {
                labelView.update(with: labelViewProperties)
                labelView.isHidden = false
            } else {
                labelView.isHidden = true
            }
        }
        
        private func updateTextField(with viewProperties: ViewProperties) {
            textFieldContainer.backgroundColor = viewProperties.textFieldBackgroundColor
            textFieldContainer.layer.borderColor = viewProperties.textFieldBorderColor.cgColor
            textFieldContainer.layer.borderWidth = viewProperties.textFieldBorderWidth
            textFieldContainer.layer.cornerRadius = viewProperties.textFieldCornerRadius
            textFieldContainer.isUserInteractionEnabled = viewProperties.isEnabled
            textFieldContainer.addGestureRecognizer(UITapGestureRecognizer(
                target: self,
                action: #selector(textFieldTapped))
            )
            
            textField.rightViewMode = .always
            textField.rightView = viewProperties.rightView
            textField.update(with: viewProperties.textFieldViewProperties)
        }
        
        private func removeConstraintsAndSubviews() {
            verticalStack.arrangedSubviews.forEach { subview in
                subview.snp.removeConstraints()
                subview.removeFromSuperview()
            }
            
            subviews.forEach { subview in
                subview.snp.removeConstraints()
                subview.removeFromSuperview()
            }
        }
        
        @objc private func textFieldTapped() {
            guard textFieldContainer.isUserInteractionEnabled else { return }
            
            textField.becomeFirstResponder()
        }
    }
    
    
    public struct InputStyle {
        
        // MARK: - Properties
        
        public enum State {
            case `default`
            case active
            case error(HintView.ViewProperties)
            case disabled
            
            func textColor() -> UIColor {
                switch self {
                case .default: .Components.Input.Content.Color.default
                case .active: .Components.Input.Content.Color.active
                case .error: .Components.Input.Content.Color.error
                case .disabled: .Components.Input.Content.Color.disabled
                }
            }
            
            func placeholderColor() -> UIColor {
                switch self {
                case .default: .Components.Input.Placeholder.Color.default
                case .active: .Components.Input.Placeholder.Color.active
                case .error: .Components.Input.Placeholder.Color.error
                case .disabled: .Components.Input.Placeholder.Color.disabled
                }
            }
            
            func labelColor() -> UIColor {
                switch self {
                case .default: .Components.Input.Label.Color.default
                case .active: .Components.Input.Label.Color.active
                case .error: .Components.Input.Label.Color.error
                case .disabled: .Components.Input.Label.Color.disabled
                }
            }
            
            func iconColor() -> UIColor {
                switch self {
                case .default: .Components.Input.Icon.Color.default
                case .active: .Components.Input.Icon.Color.active
                case .error: .Components.Input.Icon.Color.error
                case .disabled: .Components.Input.Icon.Color.disabled
                }
            }
            
            func prefixColor() -> UIColor {
                switch self {
                case .default: .Components.Input.Prefix.Color.default
                case .active: .Components.Input.Prefix.Color.active
                case .error: .Components.Input.Prefix.Color.error
                case .disabled: .Components.Input.Prefix.Color.disabled
                }
            }
            
            func fieldBackgroundColor() -> UIColor {
                switch self {
                case .default: .Components.Input.Background.Color.default
                case .active: .Components.Input.Background.Color.active
                case .error: .Components.Input.Background.Color.error
                case .disabled: .Components.Input.Background.Color.disabled
                }
            }
            
            func borderColor() -> UIColor {
                switch self {
                case .default: .Components.Input.Border.Color.default
                case .active: .Components.Input.Border.Color.active
                case .error: .Components.Input.Border.Color.error
                case .disabled: .Components.Input.Border.Color.disabled
                }
            }
        
            func cursorColor() -> UIColor {
                .Components.Input.Content.Color.default
            }
            
            func borderWidth() -> CGFloat {
                switch self {
                case .default, .disabled: .zero
                case .active, .error: 2
                }
            }
            
            func isEnabled() -> Bool {
                switch self {
                case .disabled: false
                default: true
                }
            }
        }
        
        public enum Set {
            case simple
            case icon(UIImage)
            case prefix(NSMutableAttributedString)
        }
        
        // MARK: - Private properties
        
        private let state: State
        private let set: Set
        
        // MARK: - Life cycle
        
        public init(state: State, set: Set) {
            self.state = state
            self.set = set
        }
        
        // MARK: - Public methods
        
        public func update(
            viewProperties: inout Input.ViewProperties
        ) {
            updateTextFieldViewProperties(viewProperties: &viewProperties.textFieldViewProperties)
            
            viewProperties.textFieldBackgroundColor = state.fieldBackgroundColor()
            viewProperties.textFieldBorderColor = state.borderColor()
            viewProperties.textFieldBorderWidth = state.borderWidth()
            viewProperties.isEnabled = state.isEnabled()
            viewProperties.textFieldCornerRadius = 8
            viewProperties.textFieldHeight = 56
            viewProperties.minHeight = 80
            viewProperties.textFieldInsets = .init(inset: 16)
            viewProperties.stackViewInsets = .init(top: .zero, left: 16, bottom: .zero, right: 16)
            
            if var labelViewProperties = viewProperties.labelViewProperties {
                updatewLabelViewProperties(viewProperties: &labelViewProperties)
            }
            
            var rightView = UIView()
            switch set {
            case .simple:
                break
            case .icon(let image):
                rightView = UIImageView(image: image.withTintColor(state.iconColor()))
            case .prefix(let text):
                let label = UILabel()
                label.attributedText = text
                rightView = label
            }
            
            viewProperties.rightView = rightView
        }
        
        // MARK: - Private methods
        
        private func updateTextFieldViewProperties(
            viewProperties: inout InputTextField.ViewProperties
        ) {
            viewProperties.text = viewProperties.text
                .fontStyle(.textM)
                .foregroundColor(state.textColor())
            viewProperties.placeholder = viewProperties.placeholder
                .fontStyle(.textM)
                .foregroundColor(state.placeholderColor())
            viewProperties.cursorColor = state.cursorColor()
        }
        
        private func updatewLabelViewProperties(
            viewProperties: inout LabelView.ViewProperties
        ) {
            viewProperties.text = viewProperties.text
                .foregroundColor(state.labelColor())
        }
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    
    // MARK: - Private properties
    
    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    private var inputView: Input?
    private var viewProperties = Input.ViewProperties()
    private var style = InputStyle.init(state: .default, set: .simple)
    private var state: InputStyle.State = .default
    private var set: InputStyle.Set = .simple
    private var hintViewProperties = HintView.ViewProperties()
    private var labelViewProperties: LabelView.ViewProperties? = .init()
    
    // MARK: - Methods
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createInputTextSection(),
            createHintInputTextSection(),
            createStateSection(),
            createSetSection(),
            createLabelSection()
        ]
    }
    
    // MARK: - Private methods
    
    private func createInputTextSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<Input>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                self.viewProperties.textFieldViewProperties = .init(placeholder: .init(string: "Placeholder"))
                self.style.update(viewProperties: &self.viewProperties)
                cell.containedView.update(with: self.viewProperties)

                cell.contentInset = .init(top: .zero, left: 16, bottom: 16, right: 16)
                cell.selectionStyle = .none
                self.inputView = cell.containedView
                
                cell.containedView.snp.remakeConstraints { make in
                    make.top.leading.trailing.equalToSuperview()
                    make.height.greaterThanOrEqualTo(80)
                }
            },
            initializesFromNib: false
        )
        row.rowHeight = 104
        
        let section = GenericTableViewSectionModel(with: [row])
        section.makeHeader(title: Constants.componentTitle)
        
        return section
    }
    
    private func createHintInputTextSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<InputView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                var vp: InputView.ViewProperties = .init()
                vp.textField.text = self.hintViewProperties.text ?? .init(string: "")
                vp.textField.delegateAssigningClosure = { textField in
                    textField.delegate = self
                    textField.addTarget(self, action: #selector(self.onHintTextChange(textField:)), for: .editingChanged)
                }
                let inputTextStyle = InputViewStyle()
                inputTextStyle.update(state: .default, viewProperties: &vp)
                cell.containedView.update(with: vp)

                cell.contentInset = .init(top: .zero, left: 16, bottom: 16, right: 16)
                cell.selectionStyle = .none
            },
            initializesFromNib: false
        )
        row.rowHeight = 72
        
        let section = GenericTableViewSectionModel(with: [row])
        section.makeHeader(title: Constants.componentHintText)
        return section
    }
    
    private func createStateSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["Default", "Active" ,"Error", "Disabled"],
            actions: [
                { [weak self] in self?.updateInputViewStyle(state: .default, labelViewProperties: self?.labelViewProperties) },
                { [weak self] in self?.updateInputViewStyle(state: .active, labelViewProperties: self?.labelViewProperties) },
                { [weak self] in
                    guard let self = self else { return }
                    self.updateInputViewStyle(state: .error(self.hintViewProperties), labelViewProperties: self.labelViewProperties)
                },
                { [weak self] in self?.updateInputViewStyle(state: .disabled, labelViewProperties: self?.labelViewProperties) }
            ],
            headerTitle: Constants.componentState
        )
    }
    
    private func createSetSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["Simple", "Icon", "Prefix"],
            actions: [
                { [weak self] in self?.updateInputViewStyle(set: .simple, labelViewProperties: self?.labelViewProperties)},
                { [weak self] in self?.updateInputViewStyle(set: .icon(.ic24Frame), labelViewProperties: self?.labelViewProperties)},
                { [weak self] in self?.updateInputViewStyle(set: .prefix(.init(string: "Prefix")), labelViewProperties: self?.labelViewProperties)}
            ],
            headerTitle: Constants.componentSet
        )
    }
    
    private func createLabelSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["Off", "On"],
            actions: [
                { [weak self] in self?.updateInputViewStyle(labelViewProperties: nil)},
                { [weak self] in
                    var viewProperties = LabelView.ViewProperties(text: .init(string: "Label"))
                    let style = LabelViewStyle(variant: .default(customColor: nil), alignment: .left)
                    style.update(viewProperties: &viewProperties)
                    
                    self?.updateInputViewStyle(labelViewProperties: viewProperties)
                }
            ],
            headerTitle: Constants.componentLabel
        )
    }

    private func updateInputViewStyle(
        state: InputStyle.State? = nil,
        set: InputStyle.Set? = nil,
        labelViewProperties: LabelView.ViewProperties? = nil
    ) {
        if let state {
            self.state = state
        }
        
        if let set {
            self.set = set
        }
        
        if let labelViewProperties {
            self.labelViewProperties = labelViewProperties
        } else {
            self.labelViewProperties = nil
        }
        
        viewProperties.labelViewProperties = self.labelViewProperties
        style = .init(state: self.state, set: self.set)
        style.update(viewProperties: &viewProperties)
        inputView?.update(with: viewProperties)
    }

    @objc private func onTextChange(textField: UITextField) {
        viewProperties.textFieldViewProperties.text = .init(string: textField.text ?? "")
        style.update(viewProperties: &viewProperties)
        inputView?.update(with: viewProperties)
    }
    
    @objc private func onHintTextChange(textField: UITextField) {
        hintViewProperties.text = .init(string: textField.text ?? "")
        
        switch state {
        case .error(_):
            let hintStyle = HintViewStyle(variant: .left, color: .error)
            hintStyle.update(viewProperties: &hintViewProperties)
            updateInputViewStyle(state: .error(hintViewProperties))
        default:
            break
        }
    }
}
