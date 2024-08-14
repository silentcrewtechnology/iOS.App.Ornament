//
//  RowViewExampleVC.swift
//  OrnamentApp
//
//  Created by user on 29.07.2024.
//

import UIKit
import SnapKit
import Components
import DesignSystem

private final class RowViewExampleVC: UIViewController {
    
    // MARK: - Private properties
    
    private var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        
        return scroll
    }()
    
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.isLayoutMarginsRelativeArrangement = true
        
        return stack
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        addStackView()
        createRows()
    }
    
    // MARK: - Private methods
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func addStackView() {
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }
    
    private func createRows() {
        let row1 = createTitleRow()
        let row2 = createImageWithTitleRow()
        let row3 = createImageWithTitleSubtitleRow()
        let row4 = createImageWithButtonRow()
        let row5 = createImageWithToggleRow()
        let row6 = createImageWithCheckboxRow()
        let row7 = createImageWithIndexRow()
        let row8 = createImageWithIndexIcons20Row()
        let row9 = createCardWithTitleButtonRow()
        let row10 = createCopiedTitleRow()
        
        let row = createWithRowsService()

        stackView.addArrangedSubview(row1)
        stackView.addArrangedSubview(row2)
        stackView.addArrangedSubview(row3)
        stackView.addArrangedSubview(row4)
        stackView.addArrangedSubview(row5)
        stackView.addArrangedSubview(row6)
        stackView.addArrangedSubview(row7)
        stackView.addArrangedSubview(row8)
        stackView.addArrangedSubview(row9)
        stackView.addArrangedSubview(row10)
        
        stackView.addArrangedSubview(row)
    }
    
    private func createTitleRow() -> UIView {
        let titleStyle = LabelViewStyle(variant: .rowTitle(recognizer: nil))
        return DSCreationRowsViewService().createViewRowWithBlocks(
            leading: .atom(.title("Title", titleStyle, nil))
        )
    }
    
    private func createImageWithTitleRow() -> UIView {
        return DSCreationRowsViewService().createViewRowWithBlocks(
            leading: .atom(.image40(.ic24UserFilled, nil)),
            center: .atom(.title("Title", nil, nil))
        )
    }
    
    private func createImageWithTitleSubtitleRow() -> UIView {
        return DSCreationRowsViewService().createViewRowWithBlocks(
            leading: .atom(.image40(.ic24UserFilled, nil)),
            center: .molecule(.titleWithSubtitle(("Title", nil, nil), ("Subtitle", nil)))
        )
    }
    
    private func createImageWithButtonRow() -> UIView {
        return DSCreationRowsViewService().createViewRowWithBlocks(
            leading: .atom(.image40(.ic24UserFilled, nil)),
            center: .molecule(.subtitleWithTitle(("Subtitle", nil), ("Title", nil, nil))),
            trailing: .atom(.button("Label", { }, nil))
        )
    }
    
    private func createImageWithToggleRow() -> UIView {
        return DSCreationRowsViewService().createViewRowWithBlocks(
            leading: .atom(.image40(.ic24UserFilled, nil)),
            center: .molecule(.subtitleWithTitle(("Subtitle", nil), ("Title", nil, nil))),
            trailing: .atom(.toggle(true, { _ in }, nil))
        )
    }
    
    private func createImageWithCheckboxRow() -> UIView {
        return DSCreationRowsViewService().createViewRowWithBlocks(
            leading: .atom(.image40(.ic24UserFilled, nil)),
            center: .molecule(.subtitleWithTitle(("Subtitle", nil), ("Title", nil, nil))),
            trailing: .atom(.checkbox(true, { _ in }, nil))
        )
    }
    
    private func createImageWithIndexRow() -> UIView {
        return DSCreationRowsViewService().createViewRowWithBlocks(
            leading: .atom(.image40(.ic24UserFilled, nil)),
            center: .molecule(.subtitleWithTitle(("Subtitle", nil), ("Title", nil, nil))),
            trailing: .molecule(.indexWithIcon24(("Index", nil), (.ic24ChevronSmallRight, nil)))
        )
    }
    
    private func createImageWithIndexIcons20Row() -> UIView {
        return DSCreationRowsViewService().createViewRowWithBlocks(
            leading: .atom(.image40(.ic24UserFilled, nil)),
            center: .molecule(.subtitleWithTitle(("Subtitle", nil), ("Title", nil, nil))),
            trailing: .molecule(.indexWithIcons20(("Index", nil), [(.ic24BoxFilled, nil), (.ic24BoxFilled, nil)]))
        )
    }
    
    private func createCardWithTitleButtonRow() -> UIView {
        return DSCreationRowsViewService().createViewRowWithBlocks(
            leading: .atom(.card(.ic24CardMirLight, nil)),
            center: .atom(.title("Title", nil, nil)),
            trailing: .atom(.button("Label", { }, nil))
        )
    }
    
    private func createCopiedTitleRow() -> UIView {
        let titleStyle = LabelViewStyle(variant: .rowTitle(recognizer: nil))
        return DSCreationRowsViewService().createViewRowWithBlocks(
            leading: .atom(.title("Title", titleStyle, nil))
        )
    }
    
    // пример с ручной настройкой
    private func createWithRowsService() -> UIView {
        var radioViewProperties = RadioView.ViewProperties()
        let radioViewStyle = RadioViewStyle(
            state: .default, 
            selection: .checked
        )
        radioViewStyle.update(viewProperties: &radioViewProperties)
        
        var titleViewProperties = LabelView.ViewProperties(text: "Title".attributed)
        let titleViewStyle = LabelViewStyle(variant: .rowTitle(recognizer: nil))
        titleViewStyle.update(viewProperties: &titleViewProperties)
        
        
        var buttonViewProperties = ButtonView.ViewProperties()
        buttonViewProperties.attributedText = "Button".attributed
        let buttonViewStyle = ButtonViewStyle(
            size: .small,
            color: .light,
            variant: .primary,
            state: .default,
            icon: .without
        )
        buttonViewStyle.update(viewProperties: &buttonViewProperties)
        
        let row = CreationRowsViewService().createViewRowWithBlocks(
            leading: .atom(.radio(radioViewProperties)),
            center: .atom(.title(titleViewProperties)),
            trailing: .atom(.button(buttonViewProperties))
        )
        return row
    }
}
