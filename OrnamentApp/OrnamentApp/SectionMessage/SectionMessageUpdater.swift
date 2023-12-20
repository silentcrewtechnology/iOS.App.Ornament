//  SectionMessageUpdater.swift
//  OrnamentApp
//
//  Created by Валерий Васин on 20.12.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Architecture

final class SectionMessageUpdater: ViewUpdater<SectionMessageViewController> {
    
    deinit {
        print("💀 удалился SectionMessageUpdater")
    }
    
    // нужно заменить SomePresenter на твои
//     private var sectionMessageStyle = SectionMessageStyle()
    
    // Здесь прописываем все presenter'ы вьюх, которые входят в экран
    //func bind(somePresenter: SomePresenter) {
    //    self.somePresenter = SomePresenter
    //}
    
    func handle(state: SectionMessageViewController.State) {
        // Здесь обрабатываем все состояния, которые может принять View
        switch state {
        case .create(let state, let viewProperties):
            self.viewProperties = viewProperties
            let sectionProperties = state.applay(with: viewProperties?.sectionMessageProperties)
            self.viewProperties?.sectionMessageProperties = sectionProperties
//            create(properties: self.viewProperties)
        case .newState(let state, let viewProperties):
            let sectionProperties = state.applay(with: viewProperties.sectionMessageProperties)
            self.viewProperties?.sectionMessageProperties = sectionProperties
        }
        
        update(properties: viewProperties)
    }
    
    // Метод создания View, здесь настраиваем .init() у viewEntity
//    priva`te func create(properties: SectionMessageViewController.ViewProperties?) {
//        guard let properties else { return }
//
//        self.viewProperties = properties
//    }`
    
    // Метод, вызывающий обновление у View
    private func update(properties: SectionMessageViewController.ViewProperties?) {
        DispatchQueue.main.async {
            self.update(properties)
        }
    }
}
