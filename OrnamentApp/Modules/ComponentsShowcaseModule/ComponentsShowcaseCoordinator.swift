//
//  ComponentsShowcaseCoordinator.swift
//  OrnamentApp
//
//  Created by user on 04.07.2024.
//

import Architecture
import Router
import UIKit

final class ComponentsShowcaseCoordinator: RootCoordinatorProtocol {
    
    // MARK: - Private properties
    
    private let routerService: RouterService
    private var componentsShowcaseFeature: FeatureCoordinatorProtocol
    private var activityIndicatorFeature: FeatureCoordinatorProtocol?

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
        guard let vc = componentsShowcaseFeature.runFlow(data: nil)?.view as? UIViewController else { return }
        
        routerService.setupMainNavigationVC(title: "")
        routerService.pushMainNavigation(to: vc, animated: true)
    }
    
    func setupFlow() {
        componentsShowcaseFeature.runNewFlow = { [weak self] flow in
            guard let component = flow as? Components else { return }
            
            var viewController: UIViewController = .init()
            
            switch component {
            case .activityIndicator:
                self?.activityIndicatorFeature = ActivityIndicatorFeature()
                guard let builder = self?.activityIndicatorFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .authorizationButton:
                break
            case .badge:
                break
            case .button:
                break
            case .cardImage:
                break
            case .checkbox:
                break
            case .chips:
                break
            case .divider:
                break
            case .dot:
                break
            case .hint:
                break
            case .iconButton:
                break
            case .image:
                break
            case .indicator:
                break
            case .inputAmountTextField:
                break
            case .inputAmountView:
                break
            case .inputMessage:
                break
            case .inputOTPItem:
                break
            case .inputOTP:
                break
            case .inputPhoneNumber:
                break
            case .inputSelect:
                break
            case .inputTextField:
                break
            case .inputTextarea:
                break
            case .label:
                break
            case .pageControl:
                break
            case .paper:
                break
            case .payCell:
                break
            case .paymentButton:
                break
            case .pressableView:
                break
            case .radio:
                break
            case .sectionMessage:
                break
            case .segmentItem:
                break
            case .segmentSlider:
                break
            case .segment:
                break
            case .snackBar:
                break
            case .spacer:
                break
            case .stepperItem:
                break
            case .stepper:
                break
            case .tabItem:
                break
            case .tabs:
                break
            case .tag:
                break
            case .tapInset:
                break
            case .textBlock:
                break
            case .tile:
                break
            case .title:
                break
            case .toggle:
                break
            }
            
            self?.routerService.pushMainNavigation(to: viewController, animated: true)
        }
    }
}
