import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class SegmentItemFeature: NSObject, FeatureCoordinatorProtocol {
    
    // MARK: Properties
    
    var runNewFlow: ((Any) -> Void)?
    
    // MARK: Private properties
    
    private var tableViewVCBuilder: TableViewVCBuilder?
    private var tableViewBuilder: TableViewBuilder?
    private var navigationBarStyle: NavigationBarStyle?
    
    private var tableDataSource: TableDataSource
    private var tableDelegate: TableDelegate
    
    private var segmentItemService: SegmentItemViewService
    private var sizeChipsServices: [ChipsViewService] = []
    private var stateChipsServices: [ChipsViewService] = []
    private var selectedChipsServices: [ChipsViewService] = []
    private var showDividerChipsServices: [ChipsViewService] = []
    
    private var chipsCreationService: ChipsCreationService
    private var sectionRowModelService: SectionRowModelService
    private var navigationBarVP = NavigationBar.ViewProperties()
    
    init(
        screenTitle: String,
        backAction: (() -> Void)?,
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init()
    ) {
        self.tableDataSource = tableDataSource
        self.tableDelegate = tableDelegate
        self.sectionRowModelService = SectionRowModelService()
        self.chipsCreationService = ChipsCreationService()
        
        
        // MARK: segmentItem
        
        let segmentItemViewProperties = SegmentItemView.ViewProperties(
            text: "Item".attributed,
            onItemTap: { isSelected in
                print("selected")
            })
        
        segmentItemService = SegmentItemViewService(
            viewProperties: segmentItemViewProperties,
            size: .sizeS,
            selected: .false,
            showDivider: .false
        )
        
        
        super.init()
        self.setupTableViewBuilder()
        self.setupNavigation(screenTitle: screenTitle, backAction: backAction)
        self.setupTableViewVCBuilder()
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
        let section = sectionRowModelService.createSection(
            from: cells,
            rowsHeight: 72,
            cellBackgroundColor: .lightGray
        )
        tableDelegate.update(with: [section])
        tableDataSource.update(with: [section])
    }
    
    private func createUpdaters() {
        sizeChipsServices = chipsCreationService.createChipsUpdaters(
            chipTitles: ["sizeS", "sizeL"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.segmentItemService.update(size: [.sizeS, .sizeL][index])
                self.updateChipsSelection(for: &self.sizeChipsServices, selectedIndex: index)
            }
        )
        
        
        stateChipsServices = chipsCreationService.createChipsUpdaters(
            chipTitles: ["default", "pressed"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.segmentItemService.update(state: [.default, .pressed][index])
                self.updateChipsSelection(for: &self.stateChipsServices, selectedIndex: index)
            }
        )
        
        
        selectedChipsServices = chipsCreationService.createChipsUpdaters(
            chipTitles: ["false", "true"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.segmentItemService.update(selected: [.false, .true][index])
                self.updateChipsSelection(for: &self.selectedChipsServices, selectedIndex: index)
            }
        )
        
        
        showDividerChipsServices = chipsCreationService.createChipsUpdaters(
            chipTitles: ["false", "true"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.segmentItemService.update(showDivider: [.false, .true][index])
                self.updateChipsSelection(for: &self.showDividerChipsServices, selectedIndex: index)
            }
        )
    }
    
    private func createRowModels() -> [DSRowModel] {
        let sizeChips = sizeChipsServices.map { updater -> (ChipsView) in updater.view }
        let stateChips = stateChipsServices.map { updater -> (ChipsView) in updater.view }
        let selectedChips = selectedChipsServices.map { updater -> (ChipsView) in updater.view }
        let showDividerChips = showDividerChipsServices.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            DSRowModel(leading: .atom(.view(segmentItemService.view))),
            DSRowModel(leading: .molecule(.horizontalChipsViews(sizeChips))),
            DSRowModel(leading: .molecule(.horizontalChipsViews(stateChips))),
            DSRowModel(leading: .molecule(.horizontalChipsViews(selectedChips))),
            DSRowModel(leading: .molecule(.horizontalChipsViews(showDividerChips))),

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

// MARK: Init
extension SegmentItemFeature {
    private func setupTableViewVCBuilder() {
        if let tableView = tableViewBuilder?.view {
            tableViewVCBuilder = .init(with: .init(
                navigationBarViewProperties: navigationBarVP,
                tableView: tableView,
                confirmButtonView: nil
            ))
        }
    }
    
    private func setupTableViewBuilder() {
        tableViewBuilder = .init(with: .init(
            backgroundColor: .lightGray,
            dataSources: self.tableDataSource,
            delegate: self.tableDelegate
        ))
    }
    
    private func setupNavigation(screenTitle: String,
                                 backAction: (() -> Void)?) {
        navigationBarStyle = NavigationBarStyle(
            variant: .basic(
                title: screenTitle,
                subtitle: nil,
                margins: nil
            ),
            color: .primary
        )
        navigationBarStyle?.update(viewProperties: &navigationBarVP, backAction: backAction)
    }
}
