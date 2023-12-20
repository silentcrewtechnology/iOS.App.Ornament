//  MainFeature.swift
//  OrnamentApp
//
//  Created by Валерий Васин on 19.12.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Architecture
import DesignSystem

final class MainFeature: FeatureProtocol {
    
    deinit {
        print("💀 удалился MainFeature")
    }
    
    // Указание с каким Энамом мы работаем
    typealias ActionEnum = Action
    
    enum Action {
        case start
        // здесь описываем все экшены, которые могут прилететь от View
    }
    
    var viewUpdater: MainUpdater?
    
    // нужно заменить Coordinator на твой Coordinator
    var coordinator: MainScreenCoordinator
    
    init(coordinator: MainScreenCoordinator) {
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

extension MainFeature {
    
    private func createAllProperties() -> MainViewController.ViewProperties {
        // Здесь создаем все View Entities, которые входят в экран
        
        let mainCollectionViewProperty = createMainCollectionViewProperty()
        
        let entity = MainViewController.ViewProperties(
            mainCollectionViewProperty: mainCollectionViewProperty)
        return entity
    }
    
    private func createMainCollectionViewProperty() -> MainCollectionView.ViewProperties {
        
        let property = MainCollectionView.ViewProperties(cellsModels: getAllMainCellModels())
        
        return property
    }
    
    private func getAllMainCellModels() -> [MainCellModel] {
        var models: [MainCellModel] = []
        
        let componentsTitle = ComponentsService.getAllComponents()
        for title in componentsTitle {
            models.append(MainCellModel(title: title.attributed,
                                        backgroundColor: .gray,
                                        action: { [weak self] in
                self?.cellAction(title)
            }))
        }
        return models
    }
    
    private func cellAction(_ title: String) {
        switch title {
        case "Section message":
            coordinator.goToSectionMessageController()
        default:
            break
        }
    }
}

extension MainFeature {
}
