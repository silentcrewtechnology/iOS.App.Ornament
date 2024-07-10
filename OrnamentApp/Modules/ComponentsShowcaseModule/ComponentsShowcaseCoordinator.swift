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
    private var authorizationButtonFeature: FeatureCoordinatorProtocol?
    private var checkboxFeature: FeatureCoordinatorProtocol?
    private var chipsFeature: FeatureCoordinatorProtocol?
    private var dividerFeature: FeatureCoordinatorProtocol?
    private var toggleFeature: FeatureCoordinatorProtocol?

    // MARK: - Life cycle
    
    init(
        routerService: RouterService,
        componentsShowcaseFeature: ComponentsShowcaseFeature,
        activityIndicatorFeature: CommonDetailFeature? = nil,
        authorizationButtonFeature: CommonDetailFeature? = nil,
        checkboxFeature: CommonDetailFeature? = nil,
        chipsFeature: CommonDetailFeature? = nil,
        dividerFeature: CommonDetailFeature? = nil,
        toggleFeature: CommonDetailFeature? = nil
    ) {
        self.routerService = routerService
        self.componentsShowcaseFeature = componentsShowcaseFeature
        self.activityIndicatorFeature = activityIndicatorFeature
        self.authorizationButtonFeature = authorizationButtonFeature
        self.checkboxFeature = checkboxFeature
        self.chipsFeature = chipsFeature
        self.dividerFeature = dividerFeature
        self.toggleFeature = toggleFeature
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
                self?.activityIndicatorFeature = CommonDetailFeature(
                    cellBuilder: ActivityIndicatorCellBuilder(),
                    screenTitle: Components.activityIndicator.rawValue
                )
                guard let builder = self?.activityIndicatorFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .authorizationButton:
                self?.authorizationButtonFeature = CommonDetailFeature(
                    cellBuilder: AuthorizationButtonCellBuilder(),
                    screenTitle: Components.authorizationButton.rawValue
                )
                guard let builder = self?.authorizationButtonFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .badge:
                break
            case .button:
                break
            case .cardImage:
                break
            case .checkbox:
                self?.checkboxFeature = CommonDetailFeature(
                    cellBuilder: CheckboxCellBuilder(),
                    screenTitle: Components.checkbox.rawValue
                )
                guard let builder = self?.checkboxFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .chips:
                self?.chipsFeature = CommonDetailFeature(
                    cellBuilder: ChipsCellBuilder(),
                    screenTitle: Components.chips.rawValue
                )
                guard let builder = self?.chipsFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .divider:
                self?.dividerFeature = CommonDetailFeature(
                    cellBuilder: DividerCellBuilder(),
                    screenTitle: Components.divider.rawValue
                )
                guard let builder = self?.dividerFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
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
            case .inputTextView:
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
                self?.toggleFeature = CommonDetailFeature(
                    cellBuilder: ToggleCellBuilder(),
                    screenTitle: Components.toggle.rawValue
                )
                guard let builder = self?.toggleFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            }
            
            self?.routerService.pushMainNavigation(to: viewController, animated: true)
        }
    }
}
