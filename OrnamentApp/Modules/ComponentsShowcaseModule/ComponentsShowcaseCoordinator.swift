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
    private var badgeFeature: FeatureCoordinatorProtocol?
    private var checkboxFeature: FeatureCoordinatorProtocol?
    private var chipsFeature: FeatureCoordinatorProtocol?
    private var dividerFeature: FeatureCoordinatorProtocol?
    private var inputAmountFeature: FeatureCoordinatorProtocol?
    private var inputOTPFeature: FeatureCoordinatorProtocol?
    private var inputPhoneNumberFeature: FeatureCoordinatorProtocol?
    private var inputSelectFeature: FeatureCoordinatorProtocol?
    private var inputTextFeature: FeatureCoordinatorProtocol?
    private var toggleFeature: FeatureCoordinatorProtocol?
    private var buttonIconFeature: FeatureCoordinatorProtocol?

    // MARK: - Life cycle
    
    init(
        routerService: RouterService,
        componentsShowcaseFeature: ComponentsShowcaseFeature,
        activityIndicatorFeature: CommonDetailFeature? = nil,
        authorizationButtonFeature: CommonDetailFeature? = nil,
        badgeFeature: CommonDetailFeature? = nil,
        checkboxFeature: CommonDetailFeature? = nil,
        chipsFeature: CommonDetailFeature? = nil,
        dividerFeature: CommonDetailFeature? = nil,
        inputAmountFeature: CommonDetailFeature? = nil,
        inputOTPFeature: CommonDetailFeature? = nil,
        inputPhoneNumberFeature: CommonDetailFeature? = nil,
        inputSelectFeature: CommonDetailFeature? = nil,
        inputTextFeature: CommonDetailFeature? = nil,
        toggleFeature: CommonDetailFeature? = nil,
        buttonIconFeature: CommonDetailFeature? = nil
    ) {
        self.routerService = routerService
        self.componentsShowcaseFeature = componentsShowcaseFeature
        self.activityIndicatorFeature = activityIndicatorFeature
        self.authorizationButtonFeature = authorizationButtonFeature
        self.badgeFeature = badgeFeature
        self.checkboxFeature = checkboxFeature
        self.chipsFeature = chipsFeature
        self.dividerFeature = dividerFeature
        self.inputAmountFeature = inputAmountFeature
        self.inputOTPFeature = inputOTPFeature
        self.inputPhoneNumberFeature = inputPhoneNumberFeature
        self.inputSelectFeature = inputSelectFeature
        self.inputTextFeature = inputTextFeature
        self.toggleFeature = toggleFeature
        self.buttonIconFeature = buttonIconFeature
    }
    
    // MARK: - Methods
    
    func setRoot() {
        guard let vc = componentsShowcaseFeature.runFlow(data: nil)?.view as? UIViewController else { return }
        let navigationVC = UINavigationController(rootViewController: vc)
        
        routerService.setRootViewController(viewController: navigationVC)
    }
    
    func setupFlow(completion: @escaping Architecture.Closure<Any?>) {
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
                self?.badgeFeature = CommonDetailFeature(
                    cellBuilder: BadgeModuleBuilder(),
                    screenTitle: Components.badge.rawValue
                )
                guard let builder = self?.badgeFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .button:
                break
            case .buttonIcon:
                self?.buttonIconFeature = CommonDetailFeature(
                    cellBuilder: ButtonIconModuleBuilder(),
                    screenTitle: Components.buttonIcon.rawValue
                )
                guard let builder = self?.buttonIconFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
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
            case .image:
                break
            case .indicator:
                break
            case .inputAmountView:
                self?.inputAmountFeature = CommonDetailFeature(
                    cellBuilder: InputAmountCellBuilder(),
                    screenTitle: Components.inputAmountView.rawValue
                )
                guard let builder = self?.inputAmountFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .inputOTP:
                self?.inputOTPFeature = CommonDetailFeature(
                    cellBuilder: InputOTPCellBuilder(),
                    screenTitle: Components.inputOTP.rawValue
                )
                guard let builder = self?.inputOTPFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .inputPhoneNumber:
                self?.inputPhoneNumberFeature = CommonDetailFeature(
                    cellBuilder: InputPhoneNumberCellBuilder(),
                    screenTitle: Components.inputPhoneNumber.rawValue
                )
                guard let builder = self?.inputPhoneNumberFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .inputSelect:
                self?.inputSelectFeature = CommonDetailFeature(
                    cellBuilder: InputSelectCellBuilder(),
                    screenTitle: Components.inputSelect.rawValue
                )
                guard let builder = self?.inputSelectFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .inputTextView:
                self?.inputTextFeature = CommonDetailFeature(
                    cellBuilder: InputTextCellBuilder(),
                    screenTitle: Components.inputTextView.rawValue
                )
                guard let builder = self?.inputTextFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
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
