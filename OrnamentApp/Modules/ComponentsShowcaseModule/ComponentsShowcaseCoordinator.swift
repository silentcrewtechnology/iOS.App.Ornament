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
        guard let vc = componentsShowcaseFeature.runFlow(data: "Витрина компонентов")?.view as? UIViewController
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
                self?.nextScreenFeature = ButtonModuleFeature()
                screenTitle = Components.button.rawValue
            case .buttonIcon:
                self?.nextScreenFeature = ButtonIconModuleFeature()
                screenTitle = Components.buttonIcon.rawValue
            case .buttonPay:
                self?.nextScreenFeature = ButtonPayModuleFeature()
                screenTitle = Components.buttonPay.rawValue
            case .buttonAuth:
                self?.nextScreenFeature = ButtonAuthModuleFeature()
                screenTitle = Components.buttonAuth.rawValue
            case .card:
                self?.nextScreenFeature = CardModuleFeature()
                screenTitle = Components.card.rawValue
            case .checkbox:
                self?.nextScreenFeature = CheckboxModuleFeature()
                screenTitle = Components.checkbox.rawValue
            case .chips:
                self?.nextScreenFeature = ChipsModuleFeature()
                screenTitle = Components.chips.rawValue
            case .divider:
                self?.nextScreenFeature = DividerModuleFeature()
                screenTitle = Components.divider.rawValue
            case .hint:
                self?.nextScreenFeature = HintModuleFeature()
                screenTitle = Components.hint.rawValue
            case .label:
                self?.nextScreenFeature = LabelModuleFeature()
                screenTitle = Components.label.rawValue
            case .input:
                self?.nextScreenFeature = InputModuleFeature()
                screenTitle = Components.input.rawValue
            case .inputTextArea:
                self?.nextScreenFeature = InputTextAreaModuleFeature()
                screenTitle = Components.inputTextArea.rawValue
            case .inputSearch:
                self?.nextScreenFeature = InputSearchModuleFeature()
                screenTitle = Components.inputSearch.rawValue
            case .inputContryCode:
                return
            case .inputAmount:
                self?.nextScreenFeature = InputAmountModuleFeature()
                screenTitle = Components.inputAmount.rawValue
            case .inputSelect:
                self?.nextScreenFeature = InputSelectModuleFeature()
                screenTitle = Components.inputSelect.rawValue
            case .inputOTP:
                self?.nextScreenFeature = InputOTPModuleFeature()
                screenTitle = Components.inputOTP.rawValue
            case .inputOTPItem:
                self?.nextScreenFeature = InputOTPItemModuleFeature()
                screenTitle = Components.inputOTPItem.rawValue
            case .inputAddCard:
                return
            case .inputPIN:
                self?.nextScreenFeature = InputPINModuleFeature()
                screenTitle = Components.inputPIN.rawValue
            case .inputPINItem:
                self?.nextScreenFeature = InputPINItemModuleFeature()
                screenTitle = Components.inputPINItem.rawValue
            case .image:
                self?.nextScreenFeature = ImageModuleFeature()
                screenTitle = Components.image.rawValue
            case .loader:
                self?.nextScreenFeature = LoaderModuleFeature()
                screenTitle = Components.loader.rawValue
            case .navigationBar:
                self?.nextScreenFeature = NavigationBarModuleFeature()
                screenTitle = Components.navigationBar.rawValue
            case .pageControl:
                return
            case .radio:
                self?.nextScreenFeature = RadioModuleFeature()
                screenTitle = Components.radio.rawValue
            case .segmentControl:
                self?.nextScreenFeature = SegmentControlModuleFeature()
                screenTitle = Components.segmentControl.rawValue
            case .segmentItem:
                self?.nextScreenFeature = SegmentItemModuleFeature()
                screenTitle = Components.segmentItem.rawValue
            case .snackBar:
                self?.nextScreenFeature = SnackBarModuleFeature()
                screenTitle = Components.snackBar.rawValue
            case .stepper:
                self?.nextScreenFeature = StepperModuleFeature()
                screenTitle = Components.stepper.rawValue
            case .stepperItem:
                self?.nextScreenFeature = StepperItemModuleFeature()
                screenTitle = Components.stepperItem.rawValue
            case .stories:
                self?.nextScreenFeature = StoriesModuleFeature()
                screenTitle = Components.stories.rawValue
            case .tabs:
                break
            case .tile:
                self?.nextScreenFeature = TileModuleFeature()
                screenTitle = Components.tile.rawValue
            case .title:
                self?.nextScreenFeature = TitleModuleFeature()
                screenTitle = Components.title.rawValue
            case .toggle:
                self?.nextScreenFeature = ToggleModuleFeature()
                screenTitle = Components.toggle.rawValue
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
