//
//  SnackBarViewExample.swift
//
//
//  Created by Ilnur Mugaev on 27.03.2024.
//

import UIKit
import Components
import DesignSystem

private class SnackBarViewExampleVC: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var snackBar: SnackBarView = {
        let view = SnackBarView()
        var viewProperties = SnackBarView.ViewProperties(
            title: "Title".attributed,
            content: "Content".attributed,
            closeButton: .init(),
            bottomButton: .init(
                title: "Button".attributed,
                action: { print("Button tapped") }
            )
        )
        
        let style = SnackBarViewStyle(
            color: .light,
            variant: .success,
            delay: .infinite
        )
        style.update(viewProperties: &viewProperties)
        
        view.update(with: viewProperties)
        return view
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .Core.Brand.neutral50
        
        snackBar.show(on: view)
    }
}
