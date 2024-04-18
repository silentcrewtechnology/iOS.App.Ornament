//  SectionMessageFeature.swift
//  OrnamentApp
//
//  Created by Валерий Васин on 20.12.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Architecture
import DesignSystem
import Components

final class SectionMessageFeature: FeatureProtocol {
    
    deinit {
        print("💀 удалился SectionMessageFeature")
    }
    
    // Указание с каким Энамом мы работаем
    typealias ActionEnum = Action
    
    enum Action {
        case start
        // здесь описываем все экшены, которые могут прилететь от View
    }
    
    var viewUpdater: SectionMessageUpdater?
    
    // нужно заменить Coordinator на твой Coordinator
     var coordinator: Coordinator
    
     init(coordinator: Coordinator) {
        self.coordinator = coordinator
     }
    
    func handle(action: Action) {
        // Здесь обрабатываем все экшены, которые может принять interactor
        switch action {
        case .start:
            start()
        }
    }
    
    private func start() {
        // Здесь пишем код, который нужен пи создании экрана
        let properties = createAllProperties()
        viewUpdater?.handle(state: .create(.init(style: .info, size: .sizeS) ,properties))
    }
    
    private func styleButtonActions(id: Int) {
        switch id {
        case 1:
            viewUpdater?.handle(state: .newState(.init(style: .info, size: .sizeS), createAllProperties()))
        case 2:
            viewUpdater?.handle(state: .newState(.init(style: .warning, size: .sizeS), createAllProperties()))
        case 3:
            viewUpdater?.handle(state: .newState(.init(style: .success, size: .sizeS), createAllProperties()))
        case 4:
            viewUpdater?.handle(state: .newState(.init(style: .error, size: .sizeS), createAllProperties()))
        case 5:
            viewUpdater?.handle(state: .newState(.init(style: .neutral, size: .sizeS), createAllProperties()))
        default:
            break
        }
    }
}


// MARK: Creation

extension SectionMessageFeature {
    
    private func createAllProperties() -> SectionMessageViewController.ViewProperties {
        // Здесь создаем все View Entities, которые входят в экран
        let property = SectionMessageViewController.ViewProperties(
            sectionMessageProperties: createDefaultProperies(),
            styleButtonsAction: { [weak self] id in
                self?.styleButtonActions(id: id)
            })
        return property
    }
    
    private func createDefaultProperies() -> SectionMessageView.ViewProperties {
        let property = SectionMessageView.ViewProperties(
            title: "SWIFT Переводы".attributed,
            subtitle: "Мы единственный банк, который возобновил переводы забугор".attributed,
            bottomButton: .init(
                text: "Да, мы это сделали".attributed,
                action: { print("👀") })
        )
        return property
    }
}
