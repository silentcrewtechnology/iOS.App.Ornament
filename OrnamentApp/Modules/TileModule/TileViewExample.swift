//
//  TileViewExample.swift
//  OrnamentApp
//
//  Created by user on 29.07.2024.
//

import UIKit
import SnapKit
import Components
import ImagesService
import Colors
import DesignSystem

private final class TileViewExampleVC: UIViewController {
    
    // MARK: - Private properties
    
    private let tileView = TileView()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        let vStack = vStack()
        vStack.addArrangedSubview({
            let view = TileView()
            let style = TileViewStyle(
                size: .sizeL,
                style: .action)
            var viewProperties = TileView.ViewProperties(
                icon: style.centeredIcon(.ic24Book.withTintColor(.Core.Brand.primary150)),
                text: .init(string: "Example"),
                action: { print("Example") })
            style.update(viewProperties: &viewProperties)
            view.update(with: viewProperties)
            return view
        }())
        
        vStack.addArrangedSubview({
            let view = TileView()
            let style = TileViewStyle(
                size: .sizeL,
                style: .main)
            var viewProperties = TileView.ViewProperties(
                icon: style.styledCenteredIcon(.ic24Car),
                text: .init(string: "Example"),
                action: { print("Example") })
            style.update(viewProperties: &viewProperties)
            view.update(with: viewProperties)
            return view
        }())
        
        vStack.addArrangedSubview({
            let view = TileView()
            let style = TileViewStyle(
                size: .sizeL,
                style: .primary)
            var viewProperties = TileView.ViewProperties(
                icon: style.styledCenteredIcon(.ic24Call),
                text: .init(string: "Example"),
                action: { print("Example") })
            style.update(viewProperties: &viewProperties)
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
        stack.alignment = .center
        
        return stack
    }
}
