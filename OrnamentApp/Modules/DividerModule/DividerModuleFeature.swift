import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class DividerModuleFeature: NSObject, FeatureCoordinatorProtocol {
    // MARK: Properties
    
    var runNewFlow: ((Any) -> Void)?
    
    // MARK: Private properties
    
    private var tableViewVCBuilder: TableViewVCBuilder
    private var tableViewBuilder: TableViewBuilder
    private var navigationBarStyle: NavigationBarStyle
    
    private var tableDataSource: TableDataSource
    private var tableDelegate: TableDelegate
    
    private var dividerServise: DividerViewService
    private var variantChipsServices: [ChipsViewService] = []
    private var styleChipsServices: [ChipsViewService] = []
    
    private var chipsCreationService: ChipsCreationService
    private var sectionRowModelService: SectionRowModelService
    
    init(
        screenTitle: String,
        backAction: (() -> Void)?,
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        chipsCreationService: ChipsCreationService = ChipsCreationService(),
        sectionRowModelService: SectionRowModelService = SectionRowModelService()
    ) {
        self.tableDataSource = tableDataSource
        self.tableDelegate = tableDelegate
        self.chipsCreationService = chipsCreationService
        self.sectionRowModelService = sectionRowModelService
        
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
        navigationBarStyle.update(viewProperties: &navigationBarVP, backAction: backAction)
        
        tableViewVCBuilder = .init(with: .init(
            navigationBarViewProperties: navigationBarVP,
            tableView: tableViewBuilder.view,
            confirmButtonView: nil
        ))
        
        // MARK: divider
        let dividerStyle = DividerViewStyle(variant: .horizontal, style: .accent)
        let dividerViewPropertires = DividerView.ViewProperties()
        dividerServise = DividerViewService(
            viewProperties: dividerViewPropertires,
            style: dividerStyle)
        
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
        let dividerView = dividerServise.view
        let dividerCell = CellModel(view: dividerView, height: 72)
        let dividerSection = SectionModel(cells: [dividerCell])
        let chipsSetcions = sectionRowModelService.createSections(
            from: cells,
            rowsHeight: 72)
        let sections = [dividerSection] + chipsSetcions
        
        tableDelegate.update(with: sections)
        tableDataSource.update(with: sections)
    }
    
    private func createUpdaters() {
        variantChipsServices = chipsCreationService.createChipsUpdaters(
            chipTitles: ["horizontal", "vertical"],
            selectedIndex: 0,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.dividerServise.update(variant: [.horizontal, .vertical][index])
                self.updateChipsSelection(for: &self.variantChipsServices, selectedIndex: index)
            })
        
        styleChipsServices = chipsCreationService.createChipsUpdaters(
            chipTitles: ["accent", "main", "secondary"],
            selectedIndex: 0,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.dividerServise.update(style: [.accent, .main, .secondary][index])
                self.updateChipsSelection(for: &self.styleChipsServices, selectedIndex: index)
            })
    }
    
    private func createRowModels() -> [DSRowModel] {
        let variantChip = variantChipsServices.map { updater -> (ChipsView) in updater.view }
        let styleChips = styleChipsServices.map { updater -> (ChipsView) in updater.view }
        let rowModels: [DSRowModel] = [
            DSRowModel(leading: .molecule(.horizontalChipseViews(variantChip))),
            DSRowModel(leading: .molecule(.horizontalChipseViews(styleChips)))
        ]
        
        return rowModels
    }
    
    private func updateChipsSelection(for updaters: inout [ChipsViewService], selectedIndex: Int) {
        for (index, updater) in updaters.enumerated() {
            let selected: ChipsViewStyle.Selected = selectedIndex == index ? .on : .off
            updater.update(selected: selected)
        }
    }
}
