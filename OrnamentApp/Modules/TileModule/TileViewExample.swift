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
            let style = TileViewStyle(background: .primary,
                                      widthType: .s)
            let imageViewProperties = ImageView.ViewProperties()
            
            var viewProperties = TileView.ViewProperties(
                imageViewProperties: imageViewProperties,
                text: "Example".attributed)
            style.update(viewProperties: &viewProperties)
            view.update(with: viewProperties)
            return view
        }())
        
        vStack.addArrangedSubview({
            let view = TileView()
            let style = TileViewStyle(background: .main,
                                      widthType: .s)
            let imageViewProperties = ImageView.ViewProperties()
            
            var viewProperties = TileView.ViewProperties(
                imageViewProperties: imageViewProperties,
                text: "Example".attributed,
                onTap: { print("Example") })
            style.update(viewProperties: &viewProperties)
            view.update(with: viewProperties)
            return view
        }())
        
        vStack.addArrangedSubview({
            let view = TileView()
            let style = TileViewStyle(background: .primary,
                                      widthType: .m)
            let imageViewProperties = ImageView.ViewProperties()
            
            var viewProperties = TileView.ViewProperties(
                imageViewProperties: imageViewProperties,
                text: "Example".attributed,
                onTap: { print("Example") })
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
