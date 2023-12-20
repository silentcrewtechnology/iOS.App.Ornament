//
//  MainScreenCoordinator.swift
//  OrnamentApp
//
//  Created by Валерий Васин on 19.12.2023.
//

import UIKit
import Architecture
import DesignSystem

final class MainScreenCoordinator: Coordinator {
    
    deinit {
        print("💀 удалился MainScreenCoordinator")
    }
    
    func goToSectionMessageController() {
        let builder = SectionMessageBuilder(coordinator: self)
        next(builder.view)
    }
}
