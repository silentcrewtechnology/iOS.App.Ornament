//
//  BannerViewExample.swift
//  OrnamentApp
//
//  Created by user on 29.07.2024.
//

import UIKit
import SnapKit
import Components
import DesignSystem

private final class BannerViewExampleVC: UIViewController {
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vStack = vStack()
        
        vStack.addArrangedSubview({
            let view = BannerView()
            let style = BannerViewStyle(variant: .neutral)
            var viewProperties = BannerView.ViewProperties(
                title: "Label".attributed,
                subtitle: "Content".attributed,
                bottomButton: .init(
                    text: "Label".attributed,
                    action: { print("action") }))
            style.update(with: &viewProperties)
            view.update(with: viewProperties)
            return view
        }())
        
        vStack.addArrangedSubview({
            let view = BannerView()
            let style = BannerViewStyle(variant: .warning)
            var viewProperties = BannerView.ViewProperties(
                title: "Label".attributed)
            style.update(with: &viewProperties)
            view.update(with: viewProperties)
            return view
        }())
        
        vStack.addArrangedSubview({
            let view = BannerView()
            let style = BannerViewStyle(variant: .success)
            var viewProperties = BannerView.ViewProperties(
                subtitle: "Content".attributed)
            style.update(with: &viewProperties)
            view.update(with: viewProperties)
            return view
        }())
        
        vStack.addArrangedSubview({
            let view = BannerView()
            let style = BannerViewStyle(variant: .error)
            var viewProperties = BannerView.ViewProperties(
                bottomButton: .init(
                    text: "Label".attributed,
                    action: { print("action") }))
            style.update(with: &viewProperties)
            view.update(with: viewProperties)
            return view
        }())
        
        view.addSubview(vStack)
        vStack.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Private methods
    
    private func vStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }
}
