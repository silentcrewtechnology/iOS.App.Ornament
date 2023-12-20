//  SectionMessageUpdater.swift
//  OrnamentApp
//
//  Created by Валерий Васин on 20.12.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

final class SectionMessageUpdater: ViewUpdater<SectionMessageViewController> {
    
    deinit {
        print("💀 удалился SectionMessageScreenPresenter")
    }
    
    // нужно заменить SomePresenter на твои
    // private var somePresenter: SomePresenter?
    
    // Здесь прописываем все presenter'ы вьюх, которые входят в экран
    //func bind(somePresenter: SomePresenter) {
    //    self.somePresenter = SomePresenter
    //}
    
    func handle(state: SectionMessageViewController.State) {
        // Здесь обрабатываем все состояния, которые может принять View
        switch state {
        case .create(let viewProperties):
            create(properties: viewProperties)
        }
        
        update(properties: viewProperties)
    }
    
    // Метод создания View, здесь настраиваем .init() у viewEntity
    private func create(properties: SectionMessageViewController.ViewProperties?) {
        guard let properties else { return }
        
        self.viewProperties = properties
    }
    
    // Метод, вызывающий обновление у View
    private func update(properties: SectionMessageViewController.ViewProperties?) {
        DispatchQueue.main.async {
            self.update(properties)
        }
    }
}
