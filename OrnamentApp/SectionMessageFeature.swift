//  SectionMessageFeature.swift
//  OrnamentApp
//
//  Created by Валерий Васин on 20.12.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

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
        viewUpdater?.handle(state: .create(properties))
    }
}


// MARK: Creation

extension SectionMessageFeature {
    
    private func createAllProperties() -> SectionMessageViewController.ViewProperties {
        // Здесь создаем все View Entities, которые входят в экран
        let entity = SectionMessageViewController.ViewProperties()
        return entity
    }
}
