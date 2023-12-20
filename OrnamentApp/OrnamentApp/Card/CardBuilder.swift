//  CardBuilder.swift
//  OrnamentApp
//
//  Created by Валерий Васин on 20.12.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Architecture

final class CardBuilder: Builder<CardViewController, CardUpdater, CardFeature, Coordinator> {
    
    // нужно заменить Coordinator на твой Coordinator
    
    deinit {
        print("💀 удалился CardBuilder")
    }
    
    init(coordinator: Coordinator) {
        super.init(coordinator: coordinator)
        
        // Код, который можно спрятать в родителя (на подумать)
        viewUpdater.bind(view: view)
        let feature = CardFeature.init(coordinator: coordinator)
        feature.viewUpdater = viewUpdater
        self.view.feature = feature
        creating(feature: feature)
        start(feature: feature)
    }
    
    
    override func creating(feature: CardFeature) {
        
        // нужно заменить some на твои реализации
        
        // let someBuilder = SomeBuilder()
        
        // view.someView = someBuilder.view
        
        
        // updater.bind(
        //    someUpdater: someBuilder.updater,
        // )
    }
    
    override func start(feature: CardFeature) {
        feature.handle(action: .start)
    }
}
