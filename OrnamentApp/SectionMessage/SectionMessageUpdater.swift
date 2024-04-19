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
    
    // нужно заменить SomeUpdater на твои
//     private var sectionMessageStyle = SectionMessageStyle()
    
    // Здесь прописываем все updater'ы вьюх, которые входят в экран
    //func bind(someUpdater: SomeUpdater) {
    //    self.someUpdater = SomeUpdater
    //}
    
    func handle(state: SectionMessageViewController.State) {
        // Здесь обрабатываем все состояния, которые может принять View
        switch state {
        case .create(let style, let viewProperties):
            var viewProperties = viewProperties
            style.update(with: &viewProperties.sectionMessageProperties)
            update(with: viewProperties)
        case .newState(let style, let viewProperties):
            var viewProperties = viewProperties
            style.update(with: &viewProperties.sectionMessageProperties)
            update(with: viewProperties)
        }
    }
    
    // Метод, вызывающий обновление у View
    private func update(with viewProperties: SectionMessageViewController.ViewProperties) {
        DispatchQueue.main.async {
            self.update(viewProperties)
        }
        self.viewProperties = viewProperties
    }
}
