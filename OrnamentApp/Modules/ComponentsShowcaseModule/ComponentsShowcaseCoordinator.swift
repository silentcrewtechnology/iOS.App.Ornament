//
//  ComponentsShowcaseCoordinator.swift
//  OrnamentApp
//
//  Created by user on 04.07.2024.
//

import Architecture
import Router
import UIKit
import Components

final class ComponentsShowcaseCoordinator: RootCoordinatorProtocol {
    
    // MARK: - Private properties
    
    private let routerService: RouterService
    private var componentsShowcaseFeature: FeatureCoordinatorProtocol
    private var navigationBar: NavigationBar?
    private var nextScreenFeature: FeatureCoordinatorProtocol?

    // MARK: - Life cycle
    
    init(
        routerService: RouterService,
        componentsShowcaseFeature: ComponentsShowcaseFeature
    ) {
        self.routerService = routerService
        self.componentsShowcaseFeature = componentsShowcaseFeature
    }
    
    // MARK: - Methods
    
    func setRoot() {
        guard let vc = componentsShowcaseFeature.runFlow(data: Constants.componentsShowcaseTitle)?.view as? UIViewController
        else { return }
        
        navigationBar = NavigationBar(rootViewController: vc)
        if let navigationBar {
            routerService.setRootViewController(viewController: navigationBar)
        }
    }
    
    func setupFlow(completion: @escaping Architecture.Closure<Any?>) {
        let moduleRunNewFlow: ((Any) -> Void)? = { [weak self] flow in
            guard let moduleFlow = flow as? ModuleFlow else { return }
            
            switch moduleFlow {
            case .back: self?.routerService.popMainNavigation(animated: true)
            }
        }
        
        componentsShowcaseFeature.runNewFlow = { [weak self] flow in
            guard let component = flow as? Components else { return }
            
            var screenTitle = String()
            self?.nextScreenFeature = nil
            switch component {
            case .badge:
                self?.nextScreenFeature = BadgeModuleFeature()
                screenTitle = Components.badge.rawValue
            case .banner:
                self?.nextScreenFeature = BannerModuleFeature()
                screenTitle = Components.banner.rawValue
            case .button:
                return
            case .buttonIcon:
                return
            case .buttonPay:
                self?.nextScreenFeature = ButtonPayModuleFeature()
                screenTitle = Components.buttonPay.rawValue
            case .buttonAuth:
                self?.nextScreenFeature = ButtonAuthModuleFeature()
                screenTitle = Components.buttonAuth.rawValue
            case .card:
                return
            case .checkbox:
                return
            case .chips:
                return
            case .divider:
                self?.nextScreenFeature = DividerModuleFeature()
                screenTitle = Components.divider.rawValue
            case .hint:
                self?.nextScreenFeature = HintModuleFeature()
                screenTitle = Components.hint.rawValue
            case .label:
                return
            case .input:
                return
            case .inputTextarea:
                break
            case .inputSearch:
                return
            case .inputContryCode:
                return
            case .inputAmount:
                self?.nextScreenFeature = InputAmountModuleFeature()
                screenTitle = Components.inputAmount.rawValue
            case .inputSelect:
                return
            case .inputOTP:
                return
            case .inputAddCard:
                return
            case .inputPIN:
                return
            case .image:
                return
            case .loader:
                self?.nextScreenFeature = LoaderModuleFeature()
                screenTitle = Components.loader.rawValue
            case .navigationBar:
                self?.nextScreenFeature = NavigationBarModuleFeature()
                screenTitle = Components.navigationBar.rawValue
            case .pageControl:
                return
            case .radio:
                return
            case .segmentControl:
                self?.nextScreenFeature = SegmentControlModuleFeature()
                screenTitle = Components.segmentControl.rawValue
            case .segmentItem:
                self?.nextScreenFeature = SegmentItemModuleFeature()
                screenTitle = Components.segmentItem.rawValue
            case .snackBar:
                return
            case .stepper:
                return
            case .stories:
                return
            case .tabs:
                break
            case .tile:
                return
            case .title:
                return
            case .toggle:
                return
            }
            
            self?.nextScreenFeature?.runNewFlow = moduleRunNewFlow
            guard let builder = self?.nextScreenFeature?.runFlow(data: screenTitle) else { return }
            self?.routerService.pushMainNavigation(
                to: (builder.view as! UIViewController),
                animated: true
            )
        }
    }
}
