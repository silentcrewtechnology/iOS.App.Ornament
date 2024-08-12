//
//  CardViewExample.swift
//  OrnamentApp
//
//  Created by user on 30.07.2024.
//

import UIKit
import SnapKit
import Components
import ImagesService
import DesignSystem

private final class CardViewExampleVC: UIViewController {
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        let vStack = vStack()
        vStack.addArrangedSubview({
            let hStack = hStack()
            hStack.addArrangedSubview({
                let view = CardView()
                let style = CardViewStyle(set: .mir, size: .small, stack: .false)
                var viewProperties = CardView.ViewProperties()
                style.update(viewProperties: &viewProperties, backgroundImage: .ic24Chats)
                view.update(with: viewProperties)
                return view
            }())
            hStack.addArrangedSubview({
                let view = CardView()
                let style = CardViewStyle(set: .visa, size: .small, stack: .false)
                var viewProperties = CardView.ViewProperties()
                style.update(viewProperties: &viewProperties, backgroundImage: .ic24Chats)
                view.update(with: viewProperties)
                return view
            }())
            hStack.addArrangedSubview({
                let view = CardView()
                let style = CardViewStyle(set: .mastercard, size: .small, stack: .false)
                var viewProperties = CardView.ViewProperties()
                style.update(viewProperties: &viewProperties, backgroundImage: .ic24Chats)
                view.update(with: viewProperties)
                return view
            }())
            
            return hStack
        }())
        
        vStack.addArrangedSubview({
            let hStack = hStack()
            hStack.addArrangedSubview({
                let view = CardView()
                let style = CardViewStyle(set: .add, size: .small, stack: .false)
                var viewProperties = CardView.ViewProperties()
                style.update(viewProperties: &viewProperties, backgroundImage: .ic24Chats)
                view.update(with: viewProperties)
                return view
            }())
            hStack.addArrangedSubview({
                let view = CardView()
                let style = CardViewStyle(set: .empty, size: .small, stack: .false)
                var viewProperties = CardView.ViewProperties()
                style.update(viewProperties: &viewProperties, backgroundImage: .ic24Chats)
                view.update(with: viewProperties)
                return view
            }())
            
            return hStack
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
