//
//  CheckboxViewUpdater.swift
//  OrnamentApp
//
//  Created by user on 04.07.2024.
//

import UIKit
import DesignSystem
import Components

final class CheckboxViewUpdater {
    
    // MARK: - Properties
    
    enum State {
        case tap(CheckboxView.State)
    }
    
    // MARK: - Private properties
    
    private var view: CheckboxView
    private var viewProperties: CheckboxView.ViewProperties
    private var style: CheckboxViewStyle
    private let onActive: () -> Void
    private let onInactive: () -> Void
    
    // MARK: - Life cycle
    
    init(
        view: CheckboxView,
        viewProperties: CheckboxView.ViewProperties,
        style: CheckboxViewStyle,
        onActive: @escaping () -> Void,
        onInactive: @escaping () -> Void
    ) {
        self.view = view
        self.style = style
        self.onActive = onActive
        self.onInactive = onInactive
        self.viewProperties = viewProperties
        
        updateView()
    }
    
    // MARK: - Methods
    
    func handle(state: State) {
        switch state {
        case .tap(let state):
            handleTap(state: state)
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
        state: CheckboxView.State
    ) {
        switch (style.state, state) {
        case (.default, .pressed):
            style.state = .pressed
        case (.pressed, .unpressed):
            switch style.selection {
            case .default:
                style.selection = .checked
                onActive()
            case .checked:
                style.selection = .default
                onInactive()
            }
            style.state = .default
        case (.pressed, .cancelled):
            style.state = .default
        default: return
        }
        
        style.update(viewProperties: &viewProperties)
        view.update(with: viewProperties)
    }
}
