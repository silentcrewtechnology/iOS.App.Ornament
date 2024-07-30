//
//  HintViewExample.swift
//  OrnamentApp
//
//  Created by user on 29.07.2024.
//

import UIKit
import Components
import Colors
import DesignSystem

private final class HintViewExampleVC: UIViewController {
    
    // MARK: - Private propertes
    
    private lazy var hintView = HintView()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(hintView)
        var viewProperties = HintView.ViewProperties()
        let style = HintViewStyle()
        
        style.update(
            variant: .empty,
            viewProperties: &viewProperties)
        hintView.update(with: viewProperties)
        style.update(
            variant: .left("Left".attributed.foregroundColor(.Core.System.yellow200)),
            viewProperties: &viewProperties)
        hintView.update(with: viewProperties)
        style.update(
            variant: .right("Right".attributed.foregroundColor(.Core.System.red300)),
            viewProperties: &viewProperties)
        hintView.update(with: viewProperties)
        style.update(
            variant: .both("Left".attributed, "Right".attributed),
            viewProperties: &viewProperties)
        hintView.update(with: viewProperties)
    }
}
