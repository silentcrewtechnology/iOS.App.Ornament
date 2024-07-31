//
//  DividerViewExampleVC.swift
//  OrnamentApp
//
//  Created by user on 29.07.2024.
//

import UIKit
import Components
import DesignSystem

private final class DividerViewExampleVC: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var dividerView = DividerView()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dividerView = divider(variant: .horizontal, style: .accent)
        
        example1()
        example2()
    }
    
    // MARK: - Private methods

    /// Пример с отступами от границ супервью
    private func example1() {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = .zero
        stack.addArrangedSubview(spacer(width: 16))
        stack.addArrangedSubview(divider(variant: .vertical, style: .main))
    }

    /// Пример с фиксированным размером
    private func example2() {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = .zero
        stack.alignment = .center
        stack.addArrangedSubview(spacer(width: 16, height: 100))
        // divider меньше по высоте, чем другие arranged subviews
        stack.addArrangedSubview(divider(variant: .fixed(.init(width: 1, height: 50)), style: .secondary))
        stack.addArrangedSubview(spacer(width: 16, height: 100))
    }
    
    private func spacer(
        width: CGFloat = 1,
        height: CGFloat = 1
    ) -> UIView {
        let spacer = SpacerView()
        spacer.update(with: .init(size: .init(
            width: width,
            height: height)))
        return spacer
    }

    private func divider(
        variant: DividerViewStyle.Variant,
        style: DividerViewStyle.Style
    ) -> DividerView {
        let divider = DividerView()
        var vp = DividerView.ViewProperties()
        DividerViewStyle(variant: variant, style: style).update( viewProperties: &vp)
        divider.update(with: vp)
        
        return divider
    }
}
