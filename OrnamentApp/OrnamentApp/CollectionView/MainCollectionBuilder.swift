//
//  MainCollectionBuilder.swift
//  OrnamentApp
//
//  Created by Валерий Васин on 27.07.2023.
//

import UIKit
import Architecture

final class MainCollectionBuilder: BuilderProtocol {
    
    typealias V  = MainCollectionView
    typealias VM = MainViewManager
    
    public var view       : MainCollectionView
    public var viewManager: MainViewManager
    
    public static func build() -> MainCollectionBuilder {
        let view = MainCollectionView()
        let viewManager = MainViewManager()
//        view.loadViewIfNeeded()
        viewManager.bind(with: view)
        let selfBuilder = MainCollectionBuilder(
            with: view,
            with: viewManager
        )
        return selfBuilder
    }
    
    private init(
        with view: MainCollectionView,
        with viewManager: MainViewManager
    ) {
        self.view        = view
        self.viewManager = viewManager
    }
    
}
