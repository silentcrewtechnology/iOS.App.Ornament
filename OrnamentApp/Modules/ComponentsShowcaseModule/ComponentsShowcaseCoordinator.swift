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
    
    private var badgeFeature: BadgeModuleFeature?
    private var bannerFeature: BannerModuleFeature?
    private var buttonFeature: FeatureCoordinatorProtocol?
    private var buttonIconFeature: FeatureCoordinatorProtocol?
    private var buttonPayFeature: ButtonPayModuleFeature?
    private var buttonAuthFeature: FeatureCoordinatorProtocol?
    private var cardFeature: FeatureCoordinatorProtocol?
    private var checkboxFeature: FeatureCoordinatorProtocol?
    private var chipsFeature: FeatureCoordinatorProtocol?
    private var dividerFeature: DividerModuleFeature?
    private var hintFeature: HintModuleFeature?
    private var labelFeature: FeatureCoordinatorProtocol?
    private var inputFeature: FeatureCoordinatorProtocol?
    private var inputTextareaFeature: FeatureCoordinatorProtocol?
    private var inputSearchFeature: FeatureCoordinatorProtocol?
    private var inputCountryCodeFeature: FeatureCoordinatorProtocol?
    private var inputAmountFeature: InputAmountModuleFeature?
    private var inputSelectFeature: FeatureCoordinatorProtocol?
    private var inputOTPFeature: FeatureCoordinatorProtocol?
    private var inputAddCardFeature: FeatureCoordinatorProtocol?
    private var inputPINFeature: FeatureCoordinatorProtocol?
    private var imageFeature: FeatureCoordinatorProtocol?
    private var loaderFeature: LoaderModuleFeature?
    private var navigationBarFeature: NavigationBarModuleFeature?
    private var pageControlFeature: FeatureCoordinatorProtocol?
    private var radioFeature: FeatureCoordinatorProtocol?
    private var segmentControlFeature: SegmentControlModuleFeature?
    private var segmentItemFeature: SegmentItemModuleFeature?
    private var snackBarFeature: FeatureCoordinatorProtocol?
    private var stepperFeature: FeatureCoordinatorProtocol?
    private var storiesFeature: FeatureCoordinatorProtocol?
    private var tabsFeature: FeatureCoordinatorProtocol?
    private var tileFeature: FeatureCoordinatorProtocol?
    private var titleFeature: FeatureCoordinatorProtocol?
    private var toggleFeature: FeatureCoordinatorProtocol?

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
            
            var featureToPush: FeatureCoordinatorProtocol?
            var screenTitle = String()
            switch component {
            case .badge:
                self?.badgeFeature = .init()
                featureToPush = self?.badgeFeature
                screenTitle = Components.badge.rawValue
            case .banner:
                self?.bannerFeature = .init()
                featureToPush = self?.bannerFeature
                screenTitle = Components.banner.rawValue
            case .button:
                break
            case .buttonIcon:
                break
            case .buttonPay:
                self?.buttonPayFeature = .init()
                featureToPush = self?.buttonPayFeature
                screenTitle = Components.buttonPay.rawValue
            case .buttonAuth:
                break
            case .card:
                break
            case .checkbox:
                break
            case .chips:
                break
            case .divider:
                self?.dividerFeature = .init()
                featureToPush = self?.dividerFeature
                screenTitle = Components.divider.rawValue
            case .hint:
                self?.hintFeature = .init()
                featureToPush = self?.hintFeature
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
                self?.inputAmountFeature = .init()
                featureToPush = self?.inputAmountFeature
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
                self?.loaderFeature = .init()
                featureToPush = self?.loaderFeature
                screenTitle = Components.loader.rawValue
            case .navigationBar:
                self?.navigationBarFeature = .init()
                featureToPush = self?.navigationBarFeature
                screenTitle = Components.navigationBar.rawValue
            case .pageControl:
                break
            case .radio:
                break
            case .segmentControl:
                self?.segmentControlFeature = .init()
                featureToPush = self?.segmentControlFeature
                screenTitle = Components.segmentControl.rawValue
            case .segmentItem:
                self?.segmentItemFeature = .init()
                featureToPush = self?.segmentItemFeature
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
            
            featureToPush?.runNewFlow = moduleRunNewFlow
            guard let builder = featureToPush?.runFlow(data: screenTitle) else { return }
            self?.routerService.pushMainNavigation(
                to: (builder.view as! UIViewController),
                animated: true
            )
        }
    }
}
