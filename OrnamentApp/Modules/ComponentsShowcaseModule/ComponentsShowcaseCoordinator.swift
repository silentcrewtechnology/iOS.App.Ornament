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
            switch component {
            case .badge:
                self?.nextScreenFeature = BadgeModuleFeature()
                screenTitle = Components.badge.rawValue
            case .banner:
                self?.nextScreenFeature = BannerModuleFeature()
                screenTitle = Components.banner.rawValue
            case .button:
                break
            case .buttonIcon:
                break
            case .buttonPay:
                self?.nextScreenFeature = ButtonPayModuleFeature()
                screenTitle = Components.buttonPay.rawValue
            case .buttonAuth:
                self?.nextScreenFeature = ButtonAuthModuleFeature()
                screenTitle = Components.buttonAuth.rawValue
            case .card:
                break
            case .checkbox:
                break
            case .chips:
                break
            case .divider:
                self?.nextScreenFeature = DividerModuleFeature()
                screenTitle = Components.divider.rawValue
            case .hint:
                self?.nextScreenFeature = HintModuleFeature()
                screenTitle = Components.hint.rawValue
            case .label:
                break
            case .input:
                break
            case .inputTextarea:
                break
            case .inputSearch:
                break
            case .inputContryCode:
                break
            case .inputAmount:
                self?.nextScreenFeature = InputAmountModuleFeature()
                screenTitle = Components.inputAmount.rawValue
            case .inputSelect:
                break
            case .inputOTP:
                break
            case .inputAddCard:
                break
            case .inputPIN:
                break
            case .image:
                break
            case .loader:
                self?.nextScreenFeature = LoaderModuleFeature()
                screenTitle = Components.loader.rawValue
            case .navigationBar:
                self?.nextScreenFeature = NavigationBarModuleFeature()
                screenTitle = Components.navigationBar.rawValue
            case .pageControl:
                break
            case .radio:
                break
            case .segmentControl:
                self?.nextScreenFeature = SegmentControlModuleFeature()
                screenTitle = Components.segmentControl.rawValue
            case .segmentItem:
                self?.nextScreenFeature = SegmentItemModuleFeature()
                screenTitle = Components.segmentItem.rawValue
            case .snackBar:
                break
            case .stepper:
                break
            case .stories:
                break
            case .tabs:
                break
            case .tile:
                break
            case .title:
                break
            case .toggle:
                break
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
