//  TrueButtonView.swift
//  OrnamentApp
//
//  Created by Валерий Васин on 20.12.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SnapKit
import Architecture

final class TrueButtonView: UIView, ViewProtocol {
    
    deinit {
        print("💀 удалился TrueButtonView")
    }
    
    struct ViewProperties {
        var accessibilityId = "TrueButtonView"
        // Здесь описываются свойства вью
    }
    
    enum State {
        case create(ViewProperties)
        // Здесь описываются состояния вью
    }
    
    // Здесь хранятся свойства вью, чтобы вызывать экшены
    private var viewProperties: ViewProperties = .init()
    
    // Ниже создаем внутренние вью элементы
    // MARK: UI Elements
    
    // MARK: Initialization
    
    init() {
        super.init(frame: .zero)
        configureViews()
        setupSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Ниже функции от ViewProtocol'а
    // MARK: ViewProtocol
    
    func update(with viewProperties: ViewProperties) {
        accessibilityIdentifier = viewProperties.accessibilityId
        // Здесь обновляем все свойства вью
        self.viewProperties = viewProperties
    }
    
    // MARK: Private funcs
    
    private func configureViews() {
        // Здесь настраиваем внутренние свойства - то, что не будет меняться
    }
    
    private func setupSubview() {
        // Здесь мы добавляем вьюхи и настраиваем констрейнты
    }
}
