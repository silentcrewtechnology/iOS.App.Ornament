import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class HintModuleFeature: NSObject, FeatureCoordinatorProtocol {
    
    // MARK: Properties
    
    var runNewFlow: ((Any) -> Void)?
    
    // MARK: Private properties
    
    private var tableViewVCBuilder: TableViewVCBuilder
    private var tableViewBuilder: TableViewBuilder
    private var navigationBarStyle: NavigationBarStyle
    
    private var tableDataSource: TableDataSource
    private var tableDelegate: TableDelegate
    
    private var hintService: HintViewService
    private var variantChipsService: [ChipsViewService] = []
    private var colorChipsService: [ChipsViewService] = []
    
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
        
        // MARK: HintView
        
        let hintViewStyle = HintViewStyle(
            variant: .both,
            color: .default
        )
        
        let hintViewProperties = HintView.ViewProperties(
            text: "Hint".attributed,
            additionalText: "Hint".attributed
        )
        
        hintService = HintViewService(
            viewProperties: hintViewProperties,
            style: hintViewStyle
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
        
        createUpdaters()
        
        let cells = createRowModels()
        
        let hintCell = CellModel(
            view: hintService.view,
            height: 72,
            insets: .init(top: 0, left: 16, bottom: 0, right: 16)
        )
        
        let hintSection = SectionModel(cells: [hintCell])
        
        let chipsSections = sectionModelService.createSections(
            from: cells,
            rowsHeight: 72
        )
        
        let sections = [hintSection] + chipsSections
        
        tableDelegate.update(with: sections)
        tableDataSource.update(with: sections)
    }
    
    private func createUpdaters() {
        variantChipsService = chipsCreationService.createChipsUpdaters(
            chipTitles: ["both", "center", "left", "right", "empty"],
            selectedIndex: 0,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.hintService.update(newVariant: [.both, .center, .left, .right, .empty][index])
                self.chipsCreationService.updateChipsSelection(
                    for: &self.variantChipsService,
                    selectedIndex: index
                )
            }
        )
        
        colorChipsService = chipsCreationService.createChipsUpdaters(
            chipTitles: ["default", "active", "error", "disabled"],
            selectedIndex: 0,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.hintService.update(newColor: [.default, .active, .error, .disabled][index])
                self.chipsCreationService.updateChipsSelection(
                    for: &self.colorChipsService,
                    selectedIndex: index
                )
            }
        )
    }
    
    private func createRowModels() -> [DSRowModel] {
        let variantChips = variantChipsService.map { updater -> (ChipsView) in updater.view }
        let colorChips = colorChipsService.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            DSRowModel(leading: .molecule(.horizontalChipseViews(variantChips))),
            DSRowModel(leading: .molecule(.horizontalChipseViews(colorChips))),
        ]
        
        return rowModels
    }
}
