//
//  CheckboxViewExampleVC.swift
//  OrnamentApp
//
//  Created by user on 30.07.2024.
//

import UIKit
import SnapKit
import Components
import DesignSystem

private final class CheckboxViewExampleVC: UIViewController {
    
    // MARK: - Private properties
    
    private var styles: [[CheckboxViewStyle]] = [
        (0..<4).map { _ in .init(selection: .default, state: .default) },
        (0..<4).map { _ in .init(selection: .default, state: .pressed) },
        (0..<4).map { _ in .init(selection: .default, state: .disabled) },
        (0..<4).map { _ in .init(selection: .checked, state: .default) },
        (0..<4).map { _ in .init(selection: .checked, state: .pressed) },
        (0..<4).map { _ in .init(selection: .checked, state: .disabled) }
    ]
    private var updaters: [CheckboxViewUpdater] = []
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vStack = vStack()
        
        for (i, row) in styles.enumerated() {
            let hStack = hStack()
            for j in row.indices {
                let view = CheckboxView()
                hStack.addArrangedSubview(view)
                let updater = CheckboxViewUpdater(
                    view: view,
                    viewProperties: .init(),
                    style: styles[i][j],
                    onActive: { print("active \(i) + \(j)") },
                    onInactive: { print("inactive \(i) + \(j)") }
                )
                updaters.append(updater)
            }
            vStack.addArrangedSubview(hStack)
        }
        
        view.addSubview(vStack)
        vStack.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - Private properties
    
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
        stack.spacing = 8
        stack.alignment = .center
        
        return stack
    }
}
