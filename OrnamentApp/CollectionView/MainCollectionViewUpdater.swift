//  MainCollectionViewUpdater.swift
//  OrnamentApp
//
//  Created by Валерий Васин on 19.12.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Architecture

final class MainCollectionViewUpdater: ViewUpdater<MainCollectionView> {
    
    deinit {
        print("💀 удалился MainCollectionViewUpdater")
    }
    
    func handle(state: MainCollectionView.State) {
        // Здесь обрабатываем все состояния, которые может принять View
        switch state {
        case .create(let viewProperties):
            create(with: viewProperties)
            update(with: viewProperties)
        }
    }
    
    // Метод создания View, здесь настраиваем .init() у viewProperties
    private func create(with viewProperties: MainCollectionView.ViewProperties) {
        self.viewProperties = viewProperties
    }
    
    // Метод, вызывающий обновление у View
    private func update(with viewProperties: MainCollectionView.ViewProperties) {
        DispatchQueue.main.async {
            self.update(viewProperties)
        }
    }
}
