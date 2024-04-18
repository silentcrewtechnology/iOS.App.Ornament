//  CardUpdater.swift
//  OrnamentApp
//
//  Created by Валерий Васин on 20.12.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Architecture

final class CardUpdater: ViewUpdater<CardViewController> {
    
    deinit {
        print("💀 удалился CardScreenUpdater")
    }
    
    // нужно заменить SomeUpdater на твои
    // private var someUpdater: SomeUpdater?
    
    // Здесь прописываем все updater'ы вьюх, которые входят в экран
    //func bind(someUpdater: SomeUpdater) {
    //    self.someUpdater = SomeUpdater
    //}
    
    func handle(state: CardViewController.State) {
        // Здесь обрабатываем все состояния, которые может принять View
        switch state {
        case .create(let viewProperties):
            create(properties: viewProperties)
        }
        
        update(properties: viewProperties)
    }
    
    // Метод создания View, здесь настраиваем .init() у viewProperties
    private func create(properties: CardViewController.ViewProperties?) {
        guard let properties else { return }
        
        self.viewProperties = properties
    }
    
    // Метод, вызывающий обновление у View
    private func update(properties: CardViewController.ViewProperties?) {
        DispatchQueue.main.async {
            self.update(properties)
        }
    }
}
