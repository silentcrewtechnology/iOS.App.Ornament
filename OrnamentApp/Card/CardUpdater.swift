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
            create(with: viewProperties)
            update(with: viewProperties)
        }
    }
    
    // Метод создания View, здесь настраиваем .init() у viewProperties
    private func create(with viewProperties: CardViewController.ViewProperties) {
        self.viewProperties = viewProperties
    }
    
    // Метод, вызывающий обновление у View
    private func update(with viewProperties: CardViewController.ViewProperties) {
        DispatchQueue.main.async {
            self.update(viewProperties)
        }
        self.viewProperties = viewProperties
    }
}
