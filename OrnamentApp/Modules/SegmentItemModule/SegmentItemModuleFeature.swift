import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class SegmentItemModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var segmentItemService: SegmentItemViewService
    private var sizeChipsUpdaters: [ChipsViewService] = []
    private var stateChipsUpdaters: [ChipsViewService] = []
    private var selectedChipsUpdaters: [ChipsViewService] = []
    private var showDividerChipsUpdaters: [ChipsViewService] = []
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        segmentItemService = .init(
            viewProperties: .init(text: .init(string: "Tab")),
            style: .init()
        )
        
        super.init(
            tableDataSource: tableDataSource,
            tableDelegate: tableDelegate,
            navigationBarViewPropertiesService: navigationBarViewPropertiesService
        )
    }
    
    // MARK: Methods
 
    override func createUpdaters() {
        sizeChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["S", "L"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.tableViewBuilder.view.beginUpdates()
                self.segmentItemService.update(newSize: [.sizeS, .sizeL][index])
                self.chipsCreationService.updateChipsSelection(for: &self.sizeChipsUpdaters, selectedIndex: index)
                self.tableViewBuilder.view.endUpdates()
            }
        )
        
        stateChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Default", "Pressed"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.segmentItemService.update(newState: [.default, .pressed][index])
                self.chipsCreationService.updateChipsSelection(for: &self.stateChipsUpdaters, selectedIndex: index)
            }
        )
        
        selectedChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["False", "True"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.segmentItemService.update(newSelected: [.false, .true][index])
                self.chipsCreationService.updateChipsSelection(for: &self.selectedChipsUpdaters, selectedIndex: index)
            }
        )
        
        showDividerChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["False", "True"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.segmentItemService.update(newShowDivider: [.false, .true][index])
                self.chipsCreationService.updateChipsSelection(
                    for: &self.showDividerChipsUpdaters,
                    selectedIndex: index
                )
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let sizeChips = sizeChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let stateChips = stateChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let selectedChips = selectedChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let showDividerChips = showDividerChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                leading: .atom(.view(segmentItemService.view)),
                margings: .init(leading: 16),
                cellSelectionStyle: .none
            ),
            .init(
                leading: .molecule(.horizontalChipsViews(sizeChips)),
                cellSelectionStyle: .none
            ),
            .init(
                leading: .molecule(.horizontalChipsViews(stateChips)),
                cellSelectionStyle: .none
            ),
            .init(
                leading: .molecule(.horizontalChipsViews(selectedChips)),
                cellSelectionStyle: .none
            ),
            .init(
                leading: .molecule(.horizontalChipsViews(showDividerChips)),
                cellSelectionStyle: .none
            )
        ]
        
        return rowModels
    }
}
