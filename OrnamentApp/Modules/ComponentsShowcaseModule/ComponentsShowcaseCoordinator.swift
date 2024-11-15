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
    private var activityIndicatorFeature: FeatureCoordinatorProtocol?
    private var authorizationButtonFeature: FeatureCoordinatorProtocol?
    private var badgeFeature: BadgeModuleFeature?
    private var bannerFeature: BannerModuleFeature?
    private var checkboxFeature: FeatureCoordinatorProtocol?
    private var chipsFeature: FeatureCoordinatorProtocol?
    private var dividerFeature: FeatureCoordinatorProtocol?
    private var inputAmountFeature: FeatureCoordinatorProtocol?
    private var inputOTPFeature: FeatureCoordinatorProtocol?
    private var inputPhoneNumberFeature: FeatureCoordinatorProtocol?
    private var inputSelectFeature: FeatureCoordinatorProtocol?
    private var inputTextFeature: FeatureCoordinatorProtocol?
    private var imageFeature: FeatureCoordinatorProtocol?
    private var buttonIconFeature: FeatureCoordinatorProtocol?
    private var navigationBarFeature: NavigationBarFeature?
    private var titleFeature: FeatureCoordinatorProtocol?
    private var toggleFeature: FeatureCoordinatorProtocol?
    private var navigationBar: NavigationBar?
    private var tileFeature: FeatureCoordinatorProtocol?
    private var radioFeature: FeatureCoordinatorProtocol?
    private var segmentControlFeature: FeatureCoordinatorProtocol?
    private var segmentItemFeature: FeatureCoordinatorProtocol?
    private var stepperFeature: FeatureCoordinatorProtocol?
    private var snackBarFeature: FeatureCoordinatorProtocol?
    private var buttonFeature: FeatureCoordinatorProtocol?
    private var buttonPayFeature: FeatureCoordinatorProtocol?
    private var cardFeature: FeatureCoordinatorProtocol?
    private var hintFeature: FeatureCoordinatorProtocol?
    private var labelFeature: FeatureCoordinatorProtocol?

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
            
            var viewController: UIViewController = .init()
            
            switch component {
            case .activityIndicator:
                self?.activityIndicatorFeature = CommonDetailFeature(
                    cellBuilder: ActivityIndicatorCellBuilder(),
                    screenTitle: Components.activityIndicator.rawValue, 
                    backAction: self?.popVC
                )
                guard let builder = self?.activityIndicatorFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .buttonAuth:
                self?.authorizationButtonFeature = CommonDetailFeature(
                    cellBuilder: ButtonAuthCellBuilder(),
                    screenTitle: Components.buttonAuth.rawValue,
                    backAction: self?.popVC
                )
                guard let builder = self?.authorizationButtonFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .badge:
                self?.badgeFeature = .init()
                self?.badgeFeature?.runNewFlow = moduleRunNewFlow
                guard let builder = self?.badgeFeature?.runFlow(data: Components.badge.rawValue) else { return }
                
                viewController = (builder.view as! UIViewController)
            case .banner:
                self?.bannerFeature = .init()
                self?.bannerFeature?.runNewFlow = moduleRunNewFlow
                guard let builder = self?.bannerFeature?.runFlow(data: Components.banner.rawValue) else { return }
                
                viewController = (builder.view as! UIViewController)
            case .button:
                self?.buttonFeature = CommonDetailFeature(
                    cellBuilder: ButtonModuleBuilder(),
                    screenTitle: Components.button.rawValue,
                    backAction: self?.popVC
                )
                guard let builder = self?.buttonFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .buttonIcon:
                self?.buttonIconFeature = CommonDetailFeature(
                    cellBuilder: ButtonIconModuleBuilder(),
                    screenTitle: Components.buttonIcon.rawValue,
                    backAction: self?.popVC
                )
                guard let builder = self?.buttonIconFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .card:
                self?.cardFeature = CommonDetailFeature(
                    cellBuilder: CardCellBuilder(),
                    screenTitle: Components.card.rawValue,
                    backAction: self?.popVC
                )
                guard let builder = self?.cardFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .checkbox:
                self?.checkboxFeature = CommonDetailFeature(
                    cellBuilder: CheckboxCellBuilder(),
                    screenTitle: Components.checkbox.rawValue,
                    backAction: self?.popVC
                )
                guard let builder = self?.checkboxFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .chips:
                break
                // TODO Восстановить chipsView
//                self?.chipsFeature = CommonDetailFeature(
//                    cellBuilder: ChipsCellBuilder(),
//                    screenTitle: Components.chips.rawValue,
//                    backAction: self?.popVC
//                )
//                guard let builder = self?.chipsFeature?.runFlow(data: nil) else { return }
//                viewController = (builder.view as! UIViewController)
            case .divider:
                self?.dividerFeature = DividerModuleFeature(
                    screenTitle: Components.divider.rawValue,
                    backAction: self?.popVC)
                guard let builder = self?.dividerFeature?.runFlow(data: nil) else { return }
                
                viewController = (builder.view as! UIViewController)
            case .hint:
                self?.hintFeature = HintModuleFeature.init(
                    screenTitle: Components.hint.rawValue,
                    backAction: self?.popVC
                )
                guard let builder = self?.hintFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .image:
                self?.imageFeature = CommonDetailFeature(
                    cellBuilder: ImageModuleBuilder(),
                    screenTitle: Components.image.rawValue, 
                    backAction: self?.popVC
                )
                guard let builder = self?.imageFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .inputAmount:
                self?.inputAmountFeature = InputAmountModuleFeature.init(screenTitle: Components.badge.rawValue, backAction: self?.popVC)
                guard let builder = self?.inputAmountFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .inputOTP:
                self?.inputOTPFeature = CommonDetailFeature(
                    cellBuilder: InputOTPCellBuilder(),
                    screenTitle: Components.inputOTP.rawValue,
                    backAction: self?.popVC
                )
                guard let builder = self?.inputOTPFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .inputContryCode:
                self?.inputPhoneNumberFeature = CommonDetailFeature(
                    cellBuilder: InputPhoneNumberCellBuilder(),
                    screenTitle: Components.inputContryCode.rawValue,
                    backAction: self?.popVC
                )
                guard let builder = self?.inputPhoneNumberFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .inputSelect:
                self?.inputSelectFeature = CommonDetailFeature(
                    cellBuilder: InputSelectCellBuilder(),
                    screenTitle: Components.inputSelect.rawValue,
                    backAction: self?.popVC
                )
                guard let builder = self?.inputSelectFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .input:
                self?.inputTextFeature = CommonDetailFeature(
                    cellBuilder: InputCellBuilder(),
                    screenTitle: Components.input.rawValue,
                    backAction: self?.popVC
                )
                guard let builder = self?.inputTextFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .inputTextarea:
                break
            case .inputAddCard:
                break
            case .inputPIN:
                break
            case .label:
                self?.labelFeature = CommonDetailFeature(
                    cellBuilder: LabelCellBuilder(),
                    screenTitle: Components.label.rawValue,
                    backAction: self?.popVC
                )
                guard let builder = self?.labelFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .pageControl:
                break
            case .buttonPay:
                self?.buttonPayFeature = CommonDetailFeature(
                    cellBuilder: ButtonPayCellBuilder(),
                    screenTitle: Components.buttonPay.rawValue,
                    backAction: self?.popVC
                )
                guard let builder = self?.buttonPayFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .navigationBar:
                self?.navigationBarFeature = NavigationBarFeature()
                guard let builder = self?.navigationBarFeature?.runFlow(data: nil) else { return }
                self?.navigationBarFeature?.setNavigationBar(navigationBar: self?.navigationBar)
                viewController = (builder.view as! UIViewController)
            case .radio:
                self?.radioFeature = CommonDetailFeature(
                    cellBuilder: RadioModuleBuilder(),
                    screenTitle: Components.radio.rawValue,
                    backAction: self?.popVC
                )
                guard let builder = self?.radioFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .segmentControl:
                self?.segmentControlFeature = SegmentControlModuleFeature.init(screenTitle: Components.segmentControl.rawValue, backAction: self?.popVC)
                guard let builder = self?.segmentControlFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .segmentItem:
                self?.segmentItemFeature = SegmentItemFeature.init(screenTitle: Components.segmentItem.rawValue, backAction: self?.popVC)
                guard let builder = self?.segmentItemFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .snackBar:
                self?.snackBarFeature = CommonDetailFeature(
                    cellBuilder: SnackBarCellBuilder(),
                    screenTitle: Components.snackBar.rawValue,
                    backAction: self?.popVC
                )
                guard let builder = self?.snackBarFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .stepper:
                self?.stepperFeature = CommonDetailFeature(
                    cellBuilder: StepperModuleBuilder(),
                    screenTitle: Components.stepper.rawValue,
                    backAction: self?.popVC
                )
                guard let builder = self?.stepperFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .stories:
                break
            case .tabs:
                break
            case .tile:
                self?.tileFeature = CommonDetailFeature(
                    cellBuilder: TileModuleBuilder(),
                    screenTitle: Components.tile.rawValue,
                    backAction: self?.popVC
                )
                guard let builder = self?.tileFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .title:
                self?.titleFeature = CommonDetailFeature(
                    cellBuilder: TitleCellBuilder(),
                    screenTitle: Components.title.rawValue,
                    backAction: self?.popVC
                )
                guard let builder = self?.titleFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .toggle:
                self?.toggleFeature = CommonDetailFeature(
                    cellBuilder: ToggleCellBuilder(),
                    screenTitle: Components.toggle.rawValue,
                    backAction: self?.popVC
                )
                guard let builder = self?.toggleFeature?.runFlow(data: nil) else { return }
                viewController = (builder.view as! UIViewController)
            case .inputSearch:
                break
            case .loader:
                break
            }
            
            self?.routerService.pushMainNavigation(to: viewController, animated: true)
        }
    }
    
    private func popVC() {
        routerService.popMainNavigation(animated: true)
    }
}
