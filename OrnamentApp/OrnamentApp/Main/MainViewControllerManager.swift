//
//  MainViewControllerManager.swift
//  OrnamentApp
//
//  Created by Валерий Васин on 26.07.2023.
//

import UIKit
import SnapKit
import Architecture

final class MainViewControllerManager: ViewManager<MainViewController> {
    
    //MARK: - ViewProperties
    private var viewProperties: MainViewController.ViewProperties?
    
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
            self.viewProperties = MainViewController.ViewProperties(
                addedSectionMessageView: createCollectionView
            )
            create?(viewProperties)
        }
    }
    
    private func createCollectionView(view: UIView){
        
        let mainCollectionBuilder = MainCollectionBuilder.build()
        let mainCollectionView = mainCollectionBuilder.view
//        let action: ClosureEmpty = {
//            sectionMessageViewBuilder.viewManager.state = .setStyle
//        }
        view.addSubview(mainCollectionView)
        mainCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
//        let viewProperties = MainCollectionView.ViewProperties(
//            cellsModels:
//        )
//        sectionMessageViewBuilder.viewManager.state = .createViewProperties(viewProperties)
        
        mainCollectionBuilder.viewManager.state = .createViewProperties
        
//        let sectionMessageViewBuilder = SectionMessageViewBuilder.build()
//        let sectionMessageView = sectionMessageViewBuilder.view
//        let action: ClosureEmpty = {
//            sectionMessageViewBuilder.viewManager.state = .setStyle
//        }
//        view.addSubview(sectionMessageView)
//        sectionMessageView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//        let viewProperties = SectionMessageView.ViewProperties(
//            title: "Create label".textL(color: .white),
//            content: "Create content".textM(color: .white),
//            subtitle: "Create subtitle".textS(color: .white),
//            iconImage: ImagesService.warningCircleOutline,
//            backgroundColor: .purple,
//            action: action
//        )
//        sectionMessageViewBuilder.viewManager.state = .createViewProperties(viewProperties)
    }
}
