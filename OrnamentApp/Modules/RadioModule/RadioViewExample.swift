//
//  RadiViewExample.swift
//  OrnamentApp
//
//  Created by user on 30.07.2024.
//

import UIKit
import SnapKit
import Components
import DesignSystem

private final class RadiViewExampleVC: UIViewController {
    
    // MARK: - Private properties
    
    private var features: [RadioViewFeature] = []
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vStack = vStack()
        
        for _ in 0..<4 {
            let hStack = hStack()
            let feature = RadioViewFeature(range: 0..<4)
            for view in feature.views {
                hStack.addArrangedSubview(view)
            }
            features.append(feature)
            vStack.addArrangedSubview(hStack)
        }
        
        view.addSubview(vStack)
        vStack.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - Private methods
    
    private func vStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        
        return stack
    }
    
    private func hStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        
        return stack
    }
}

// MARK: - RadioViewFeature

private final class RadioViewFeature {
    
    // MARK: - Properties
    
    let views: [RadioView]
    
    // MARK: - Private properties
    
    private let updaters: [RadioViewUpdater]
    
    // MARK: - Life cycle
    
    init(
        range: Range<Int>
    ) {
        self.views = range.map { _ in .init() }
        self.updaters = views.map { view in
            .init(
                view: view,
                viewProperties: .init(),
                style: .init(state: .default, selection: .default))
        }
        setupActions()
    }
    
    // MARK: - Private methods
    
    private func setupActions() {
        for (i, updater) in updaters.enumerated() {
            updater.onActive = { [weak self] in
                self?.handleRadioTapped(index: i)
            }
        }
    }
    
    private func handleRadioTapped(index: Int) {
        for (i, updater) in updaters.enumerated() {
            updater.handle(state: i == index ? .select : .deselect)
        }
    }
}

// MARK: - RadioViewUpdater

private final class RadioViewUpdater {
    
    // MARK: - Private properties
    
    private var view: RadioView
    private var viewProperties: RadioView.ViewProperties
    private var style: RadioViewStyle
    
    // MARK: - Properties
    
    var onActive: () -> Void = { }
    
    enum State {
        case tap(RadioView.State)
        case select
        case deselect
    }
    
    // MARK: - Life cycle
    
    init(
        view: RadioView,
        viewProperties: RadioView.ViewProperties,
        style: RadioViewStyle
    ) {
        self.view = view
        self.viewProperties = viewProperties
        self.style = style
        updateView()
    }
    
    // MARK: - Methods
    
    func handle(state: State) {
        switch state {
        case .tap(let state):
            handleTap(state: state)
        case .select:
            handleSelect()
        case .deselect:
            handleDeselect()
        }
    }
    
    // MARK: - Private methods
    
    private func updateView() {
        viewProperties.onPressChange = { [weak self] state in
            guard let self else { return }
            self.handle(state: .tap(state))
        }
        style.update(viewProperties: &viewProperties)
        view.update(with: viewProperties)
    }
    
    private func handleTap(
        state: RadioView.State
    ) {
        switch (style.state, state) {
        case (.default, .pressed):
            style.state = .pressed
        case (.pressed, .unpressed):
            switch style.selection {
            case .default:
                style.selection = .checked
                onActive()
            case .checked: break // already checked
            }
            style.state = .default
        case (.pressed, .cancelled):
            style.state = .default
        default: return
        }
        style.update(viewProperties: &viewProperties)
        view.update(with: viewProperties)
    }
    
    private func handleSelect() {
        style.selection = .checked
        style.state = .default
        style.update(viewProperties: &viewProperties)
        view.update(with: viewProperties)
    }
    
    private func handleDeselect() {
        style.selection = .default
        style.state = .default
        style.update(viewProperties: &viewProperties)
        view.update(with: viewProperties)
    }
}
