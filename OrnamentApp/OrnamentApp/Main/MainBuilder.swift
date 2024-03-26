//  MainBuilder.swift
//  OrnamentApp
//
//  Created by Валерий Васин on 19.12.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Architecture

final class MainBuilder: Builder<MainViewController, MainUpdater, MainFeature, MainScreenCoordinator> {
    
    // нужно заменить Coordinator на твой Coordinator
    
    deinit {
        print("💀 удалился MainBuilder")
    }
    
    init(coordinator: MainScreenCoordinator) {
        super.init(coordinator: coordinator)
        
        // Код, который можно спрятать в родителя (на подумать)
        viewUpdater.bind(view: view)
        let feature = MainFeature.init(coordinator: coordinator)
        feature.viewUpdater = viewUpdater
        self.view.feature = feature
        creating(feature: feature)
        start(feature: feature)
    }
    
    override func creating(feature: MainFeature) {
        let mainViewCollectionBuilder = MainCollectionViewBuilder()
        
        view.mainCollectionView = mainViewCollectionBuilder.view
        
        viewUpdater.bind(mainCollectionViewUpdater: mainViewCollectionBuilder.viewUpdater)
    }
    
    override func start(feature: MainFeature) {
        feature.handle(action: .start)
    }
}
