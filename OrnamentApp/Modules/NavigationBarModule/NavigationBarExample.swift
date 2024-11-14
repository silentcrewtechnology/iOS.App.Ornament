//
//  NavigationBarExample.swift
//
//
//  Created by user on 22.07.2024.
//

import UIKit
import Components
import ImagesService
import DesignSystem

private final class NavigationBarExampleVC: UIViewController {
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let vc = UINavigationController()
        var navVP = NavigationBar.ViewProperties()
        let navVCStyle = NavigationBarStyle(
            variant: .mainScreen(
                name: "Алиса",
                icon: .ic24UserFilled.centered(in: .circle(backgroundColor: .clear, diameter: 40)),
                margins: nil,
                onProfile: profileTapped
            ),
            color: .primary
        )
        navVCStyle.update(viewProperties: &navVP)
        navVP.rightBarButtonItems = [.init(
            image: .ic24QrCode
                .withTintColor(.Core.Brand.primary500)
                .withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(qrCodeTapped)
        )]
        let navVC = NavigationBar(rootViewController: vc)
        navVC.update(with: navVP)
        vc.hidesBottomBarWhenPushed = false
        
        navVC.pushViewController(vc, animated: true)
    }
    
    // MARK: - Private properties
    
    private func profileTapped() {
        // Profile action
    }
    
    @objc private func qrCodeTapped() {
        // QR-code action
    }
}
