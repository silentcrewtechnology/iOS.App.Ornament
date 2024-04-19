//  CardViewController.swift
//  OrnamentApp
//
//  Created by Валерий Васин on 20.12.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SnapKit
import Architecture

final class CardViewController: ViewController<CardFeature>, ViewProtocol {
    
    deinit {
        print("💀 удалился CardScreenController")
    }
    
    struct ViewProperties {
        var accessibilityId = "CardScreenController"
        // var someView: SomeView.ViewProperties?
        // Здесь описываются свойства вью
        // нужно заменить SomeView на твою View
    }
    
    enum State {
        case create(ViewProperties)
        // Здесь описываются состояния вью
    }
    
    // Здесь хранятся свойства вью, чтобы вызывать экшены
    private var viewProperties: ViewProperties = .init()
    
    // Ниже создаем внутренние вью элементы
    // MARK: UI Elements
    
    // нужно заменить SomeView на твою View
    // var someView: SomeView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setupSubview()
    }
    
    // Ниже функции от ViewProtocol'а
    // MARK: ViewProtocol
    
    func update(with viewProperties: ViewProperties) {
        view.accessibilityIdentifier = viewProperties.accessibilityId
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
