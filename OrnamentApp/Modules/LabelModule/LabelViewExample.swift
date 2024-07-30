//
//  LabelViewExample.swift
//
//
//  Created by Ilnur Mugaev on 17.04.2024.
//

import UIKit
import Components
import DesignSystem

private final class LabelViewExampleVC: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var labelView = {
        let view = LabelView()
        var viewProperties = LabelView.ViewProperties(text: .init(string: "Label"))
        let style = LabelViewStyle(variant: .default, alignment: .center)
        style.update(viewProperties: &viewProperties)
        view.update(with: viewProperties)
        
        return view
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(labelView)
        labelView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.topMargin.equalToSuperview().inset(20)
        }
    }
}
