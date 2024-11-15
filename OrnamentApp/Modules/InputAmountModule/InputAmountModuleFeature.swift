import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class InputAmountModuleFeature: NSObject, FeatureCoordinatorProtocol {
    
    // MARK: Properties
    
    var runNewFlow: ((Any) -> Void)?
    
    // MARK: Private properties
    
    private var tableViewVCBuilder: TableViewVCBuilder
    private var tableViewBuilder: TableViewBuilder
    private var navigationBarStyle: NavigationBarStyle
    
    private var tableDataSource: TableDataSource
    private var tableDelegate: TableDelegate
    
    private var inputAmountService: InputAmountViewService
    
    private var stateChipsService: [ChipsViewService] = []
    private var hintVariantChipsService: [ChipsViewService] = []
    private var labelVariantChipsService: [ChipsViewService] = []
    
    private var chipsCreationService: ChipsCreationService
    private var sectionModelService: SectionRowModelService
    
    init(
        screenTitle: String,
        backAction: (() -> Void)?,
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init()
    ) {
        self.tableDataSource = tableDataSource
        self.tableDelegate = tableDelegate
        self.sectionModelService = SectionRowModelService()
        self.chipsCreationService = ChipsCreationService()
        
        tableViewBuilder = .init(with: .init(
            backgroundColor: .white,
            dataSources: self.tableDataSource,
            delegate: self.tableDelegate
        ))
        
        var navigationBarVP = NavigationBar.ViewProperties()
        navigationBarStyle = NavigationBarStyle(
            variant: .basic(
                title: screenTitle,
                subtitle: nil,
                margins: nil
            ),
            color: .primary
        )
        
        navigationBarStyle.update(
            viewProperties: &navigationBarVP,
            backAction: backAction
        )
        
        tableViewVCBuilder = .init(with: .init(
            navigationBarViewProperties: navigationBarVP,
            tableView: tableViewBuilder.view,
            confirmButtonView: nil
        ))

        let hintViewProperties = HintView.ViewProperties(
            text: "Hint".attributed,
            textIsHidden: false,
            additionalText: "Hint".attributed,
            additionalTextIsHidden: true
        )
        
        let labelViewProperties = LabelView.ViewProperties(
            text: "Header amount view".attributed
        )
        
        let inputAmountViewProperties = InputAmountView.ViewProperties(
            headerViewProperties: labelViewProperties,
            textFieldProperties: .init(placeholder: .init(string: "0")),
            amountSymbol: .init(string: "₽"),
            hintViewProperties: hintViewProperties
        )
        
        inputAmountService = InputAmountViewService(
            viewProperties: inputAmountViewProperties
        )
        
        super.init()
    }
    
    // MARK: Methods
    
    func runFlow(data: Any?) -> (any Architecture.BuilderProtocol)? {
        setCell()
        return tableViewVCBuilder
    }
    
    // MARK: Private methods
    
    private func setCell() {
        createStateUpdaters()
        createHintVariantUpdaters()
        createLabelVariantUpdaters()
        
        let sections = inputAmountSection() + stateSection() + hintSection() + labelSection()

        tableDelegate.update(with: sections)
        tableDataSource.update(with: sections)
    }
    
    private func inputAmountSection() -> [SectionModel] {
        let inputAmount = inputAmountService.view
        let inputAmountCell = CellModel(
            view: inputAmount,
            height: nil,
            insets: .init(top: 0, left: 16, bottom: 0, right: 16)
        )
        
        let inputAmountSection = SectionModel(
            headerView: makeHeaderSection(title: Constants.componentTitle),
            headerHeight: 24,
            cells: [inputAmountCell]
        )
        
        return [inputAmountSection]
    }
    
    private func stateSection() -> [SectionModel] {
        let headerStateCell = CellModel(
            view: makeHeaderSection(title: Constants.componentState),
            height: nil
        )
        
        let headerStateSection = SectionModel(cells: [headerStateCell])
        
        let stateCells = createStateRowModels()
        let stateChipsSection = sectionModelService.createSection(from: stateCells)
        
        return [headerStateSection, stateChipsSection]
    }
    
    private func hintSection() -> [SectionModel] {
        let headerHintCell = CellModel(
            view: makeHeaderSection(title: Constants.hintVariant),
            height: nil
        )
        
        let headerHintSection = SectionModel(cells: [headerHintCell])
        
        let hintCells = createHintVariantRowModels()
        let hintChipsSection = sectionModelService.createSection(from: hintCells)
        
        return [headerHintSection, hintChipsSection]
    }
    
    private func labelSection() -> [SectionModel] {
        let headerLabelCell = CellModel(
            view: makeHeaderSection(title: Constants.labelVariant),
            height: nil
        )
        
        let headerLabelSection = SectionModel(cells: [headerLabelCell])
        
        let labelCells = createLabelVariantRowModels()
        let labelChipsSection = sectionModelService.createSection(from: labelCells)
        
        return [headerLabelSection, labelChipsSection]
    }
    
    private func makeHeaderSection(
        title: String
    ) -> TableHeaderView {
        let header = TableHeaderView()
        header.update(with: .init(text: title))
        return header
    }
}

// MARK: Create Rows

extension InputAmountModuleFeature {
    private func createStateUpdaters() {
        stateChipsService = chipsCreationService.createChipsUpdaters(
            chipTitles: ["default", "active", "error", "disabled"],
            selectedIndex: 0,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.inputAmountService.update(state: [.default, .active, .error, .disabled][index])
                self.chipsCreationService.updateChipsSelection(
                    for: &self.stateChipsService,
                    selectedIndex: index
                )
            }
        )
    }
    
    private func createHintVariantUpdaters() {
        hintVariantChipsService = chipsCreationService.createChipsUpdaters(
            chipTitles: ["left", "right", "empty", "both", "center"],
            selectedIndex: 0,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.inputAmountService.update(hintVariant: [.left, .right, .empty, .both, .center][index])
                self.chipsCreationService.updateChipsSelection(
                    for: &self.hintVariantChipsService,
                    selectedIndex: index
                )
            }
        )
    }
    
    private func createLabelVariantUpdaters() {
        labelVariantChipsService = chipsCreationService.createChipsUpdaters(
            chipTitles: ["default", "disabled", "rowTitle", "rowSubtitle", "rowIndex", "rowAmount"],
            selectedIndex: 0,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.inputAmountService.update(headerVariant: [.default(customColor: nil), .disabled(customColor: nil), .rowTitle(recognizer: nil), .rowSubtitle, .rowIndex, .rowAmount][index])
                self.chipsCreationService.updateChipsSelection(
                    for: &self.labelVariantChipsService,
                    selectedIndex: index
                )
            }
        )
    }
    
    private func createStateRowModels() -> [DSRowModel] {
        let stateChips = stateChipsService.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            DSRowModel(leading: .molecule(.horizontalChipsViews(stateChips))),
        ]
        
        return rowModels
    }
    
    private func createHintVariantRowModels() -> [DSRowModel] {
        let hintVariantChips = hintVariantChipsService.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            DSRowModel(leading: .molecule(.horizontalChipsViews(hintVariantChips))),
        ]
        
        return rowModels
    }
    
    private func createLabelVariantRowModels() -> [DSRowModel] {
        let labelVariantChips = labelVariantChipsService.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            DSRowModel(leading: .molecule(.horizontalChipsViews(labelVariantChips))),
        ]
        
        return rowModels
    }
}
