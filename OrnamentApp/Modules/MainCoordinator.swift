//
//  MainCoordinator.swift
//  OrnamentApp
//
//  Created by user on 04.07.2024.
//

import Architecture
import Foundation

struct MainCoordinator: MainCoordinatorProtocol {
    
    // MARK: - Private properties
    
    private let componentsShowcaseCoordinator: RootCoordinatorProtocol
    
    // MARK: - Life cycle
    
    init(
        componentsShowcaseCoordinator: RootCoordinatorProtocol
    ) {
        self.componentsShowcaseCoordinator = componentsShowcaseCoordinator
    }
    
    // MARK: - Methods
    
    func setRoot() {
        componentsShowcaseCoordinator.setRoot()
    }
    
    func setupCoordinatorsFlow() {
        componentsShowcaseCoordinator.setupFlow(completion: { _ in })
    }
}
