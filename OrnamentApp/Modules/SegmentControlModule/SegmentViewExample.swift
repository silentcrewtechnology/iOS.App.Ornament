//
//  SegmentViewExample.swift
//  OrnamentApp
//
//  Created by user on 30.07.2024.
//

import UIKit
import Colors
import Components
import DesignSystem

private final class SegmentViewExampleVC: UIViewController {
    
    // MARK: - Private properties
    
    private let segmentView = SegmentView()
    private var viewProperties = SegmentView.ViewProperties()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        example()
    }
    
    // MARK: - Private methods
    
    private func example() {
        view.addSubview(segmentView)
        let style = SegmentViewStyle(
            background: .primary,
            size: .sizeL,
            variant: .action)
        viewProperties = .init(
            items: [
                "321".attributed,
                "654".attributed,
                "987".attributed
            ].map { .init(text: $0) },
            selectedSegmentIndex: 2,
            onSelect: { [weak self] index in
                guard let self else { return }
                guard index != self.viewProperties.selectedSegmentIndex else { return }
                self.viewProperties.selectedSegmentIndex = index
                style.update(viewProperties: &self.viewProperties)
                self.segmentView.update(with: self.viewProperties)
            }
        )
        style.update(viewProperties: &viewProperties)
        segmentView.update(with: viewProperties)
    }
}
