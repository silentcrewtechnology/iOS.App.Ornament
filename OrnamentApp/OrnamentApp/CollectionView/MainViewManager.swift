//
//  MainViewManager.swift
//  OrnamentApp
//
//  Created by Валерий Васин on 27.07.2023.
//

import UIKit
import DesignSystem
import Architecture

final class MainViewManager: ViewManager<MainCollectionView> {
    
    //MARK: - ViewProperties
    private var viewProperties: MainCollectionView.ViewProperties?
    
    //MARK: - Main state view Manager
    enum State {
        case createViewProperties
    }
    
    public var state: State? {
        didSet { self.stateManager() }
    }
    
    private func stateManager(){
        guard let state = self.state else { return }
        switch state {
            
        case .createViewProperties:
            self.viewProperties = MainCollectionView.ViewProperties(cellsModels: getAllMainCellModels())
            create?(viewProperties)
        }
    }
    
    private func createCollectionView(view: UIView) {
        
    }
    
    private func getAllMainCellModels() -> [MainCellModel] {
        var models: [MainCellModel] = []
        
        let componentsTitle = ComponentsService.getAllComponents()
        for title in componentsTitle {
            models.append(MainCellModel(title: title.attributed,
                                        backgroundColor: .gray,
                                        action: { }))
        }
        return models
    }

}
