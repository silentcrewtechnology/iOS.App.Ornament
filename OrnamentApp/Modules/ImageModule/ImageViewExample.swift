//
//  ImageViewExampleVC.swift
//  OrnamentApp
//
//  Created by user on 30.07.2024.
//

import UIKit
import SnapKit
import Components
import ImagesService
import DesignSystem

private final class ImageViewExampleVC: UIViewController {
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        let vStack = vStack()
        
        vStack.addArrangedSubview({
            let hStack = hStack()
            hStack.addArrangedSubview({
                let view = ImageView()
                let style = ImageViewStyle(
                    type: .custom(.ic24Bill, .init(width: 24, height: 24)),
                    color: .primary)
                var viewProperties = ImageView.ViewProperties()
                style.update(viewProperties: &viewProperties)
                view.update(with: viewProperties)
                return view
            }())
            hStack.addArrangedSubview({
                let view = ImageView()
                let style = ImageViewStyle(
                    type: .letter("AB".attributed),
                    color: .primary)
                var viewProperties = ImageView.ViewProperties()
                style.update(viewProperties: &viewProperties)
                view.update(with: viewProperties)
                return view
            }())
            hStack.addArrangedSubview({
                let view = ImageView()
                let style = ImageViewStyle(
                    type: .fillImage(.ic24Euro
                        .withTintColor(.Core.Brand.neutral200)
                        .centered(in:
                                .circle(
                                    backgroundColor: .Core.Brand.neutral50, 
                                    diameter: 40
                                )
                        )
                    ),
                    color: .primary)
                var viewProperties = ImageView.ViewProperties()
                style.update(viewProperties: &viewProperties)
                view.update(with: viewProperties)
                return view
            }())
            return hStack
        }())
        
        vStack.addArrangedSubview({
            let hStack = hStack()
            hStack.addArrangedSubview({
                let view = ImageView()
                let style = ImageViewStyle(
                    type: .icon(.ic24Ban),
                    color: .main)
                var viewProperties = ImageView.ViewProperties()
                style.update(viewProperties: &viewProperties)
                view.update(with: viewProperties)
                return view
            }())
            hStack.addArrangedSubview({
                let view = ImageView()
                let style = ImageViewStyle(
                    type: .letter("CD".attributed),
                    color: .main)
                var viewProperties = ImageView.ViewProperties()
                style.update(viewProperties: &viewProperties)
                view.update(with: viewProperties)
                return view
            }())
            return hStack
        }())
        
        vStack.addArrangedSubview({
            let hStack = hStack()
            hStack.addArrangedSubview({
                let view = ImageView()
                let style = ImageViewStyle(
                    type: .icon(.ic24Globe),
                    color: .mainInverse)
                var viewProperties = ImageView.ViewProperties()
                style.update(viewProperties: &viewProperties)
                view.update(with: viewProperties)
                return view
            }())
            hStack.addArrangedSubview({
                let view = ImageView()
                let style = ImageViewStyle(
                    type: .letter("EF".attributed),
                    color: .mainInverse)
                var viewProperties = ImageView.ViewProperties()
                style.update(viewProperties: &viewProperties)
                view.update(with: viewProperties)
                return view
            }())
            return hStack
        }())
        
        for color in [ImageViewStyle.Color.additional1, .additional2, .additional3, .additional4, .additional5, .additional6, .additional7, .additional8] {
            
            vStack.addArrangedSubview({
                let view = ImageView()
                let style = ImageViewStyle(
                    type: .icon(.ic24Bill),
                    color: color)
                var viewProperties = ImageView.ViewProperties()
                style.update(viewProperties: &viewProperties)
                view.update(with: viewProperties)
                return view
            }())
        }
        
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
        stack.alignment = .center
        
        return stack
    }
    
    private func hStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.alignment = .center
        
        return stack
    }
}
