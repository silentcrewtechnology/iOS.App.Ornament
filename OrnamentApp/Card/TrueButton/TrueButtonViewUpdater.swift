//  TrueButtonViewUpdater.swift
//  OrnamentApp
//
//  Created by Валерий Васин on 20.12.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Architecture

final class TrueButtonViewUpdater: ViewUpdater<TrueButtonView> {
    
    deinit {
        print("💀 удалился TrueButtonViewUpdater")
    }
    
    func handle(state: TrueButtonView.State) {
        // Здесь обрабатываем все состояния, которые может принять View
         switch state {
         case .create(let viewProperty):
             create(viewProperty)
         }
        
        DispatchQueue.main.async {
            self.update(properties: self.viewProperties)
        }
    }
    
    // Метод создания View, здесь настраиваем .init() у viewProperties
    private func create(_ properties: TrueButtonView.ViewProperties?) {
        guard let properties else { return }
        
        self.viewProperties = properties
    }
    
    // Метод, вызывающий обновление у View
    private func update(properties: TrueButtonView.ViewProperties?) {
        DispatchQueue.main.async {
            self.update(properties)
        }
    }
}
