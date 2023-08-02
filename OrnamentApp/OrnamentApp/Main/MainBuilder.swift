//
//  MainBuilder.swift
//  OrnamentApp
//
//  Created by Валерий Васин on 27.07.2023.
//

import UIKit
import Architecture

final class MainBuilder: BuilderProtocol {
    
    typealias V  = MainViewController
    typealias VM = MainViewControllerManager
    
    public var view       : MainViewController
    public var viewManager: MainViewControllerManager
    
    public static func build() -> MainBuilder {
        let view = MainViewController()
        let viewManager = MainViewControllerManager()
        view.loadViewIfNeeded()
        viewManager.bind(with: view)
        let selfBuilder = MainBuilder(
            with: view,
            with: viewManager
        )
        return selfBuilder
    }
    
    private init(
        with view: MainViewController,
        with viewManager: MainViewControllerManager
    ) {
        self.view        = view
        self.viewManager = viewManager
    }
}
