//  SectionMessageBuilder.swift
//  OrnamentApp
//
//  Created by Валерий Васин on 20.12.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Architecture
import DesignSystem

final class SectionMessageBuilder: Builder<SectionMessageViewController, SectionMessageUpdater, SectionMessageFeature, Coordinator> {
    
    // нужно заменить Coordinator на твой Coordinator
    
    deinit {
        print("💀 удалился SectionMessageBuilder")
    }
    
    init(coordinator: Coordinator) {
        super.init(coordinator: coordinator)
        
        // Код, который можно спрятать в родителя (на подумать)
        viewUpdater.bind(view: view)
        let feature = SectionMessageFeature.init(coordinator: coordinator)
        feature.viewUpdater = viewUpdater
        self.view.feature = feature
        creating(feature: feature)
        start(feature: feature)
    }
    
    
    override func creating(feature: SectionMessageFeature) {
        
        // нужно заменить some на твои реализации
        
         let sectionMessageView = SectionMessageView()
        
         view.sectionMessageView = sectionMessageView
        
        
        // presenter.bind(
        //    somePresenter: someBuilder.presenter,
        // )
    }
    
    override func start(feature: SectionMessageFeature) {
        feature.handle(action: .start)
    }
}
