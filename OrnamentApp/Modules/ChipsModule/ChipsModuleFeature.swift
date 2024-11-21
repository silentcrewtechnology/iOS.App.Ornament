import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class ChipsModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var chipsService: ChipsViewService
    private var setChipsUpdaters: [ChipsViewService] = []
    private var sizeChipsUpdaters: [ChipsViewService] = []
    private var stateChipsUpdaters: [ChipsViewService] = []
    private var selectedChipsUpdaters: [ChipsViewService] = []
    private var labelChipsUpdaters: [ChipsViewService] = []
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        chipsService = .init(
            viewProperties: .init(
                leftImage: .ic16Tick,
                text: .init(string: "Label"),
                rightImage: .ic16ChevronDown,
                onChipsTap: { _ in print("Chips tapped!") },
                onIconTap: { print("Icon tapped!") }
            ),
            style: .init(size: .small, selected: .on)
        )
        
        super.init(
            tableDataSource: tableDataSource,
            tableDelegate: tableDelegate,
            navigationBarViewPropertiesService: navigationBarViewPropertiesService
        )
    }
    
    // MARK: Methods
 
    override func createUpdaters() {
        setChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Left icon", "Right icon", "None"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.chipsService.update(set: [.leftIcon, .rightIcon, ChipsViewStyle.Set.none][index])
                self.chipsCreationService.updateChipsSelection(for: &self.setChipsUpdaters, selectedIndex: index)
            }
        )
        
        sizeChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Small", "Large"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.tableViewBuilder.view.beginUpdates()
                self.chipsService.update(size: [.small, .large][index])
                self.chipsCreationService.updateChipsSelection(for: &self.sizeChipsUpdaters, selectedIndex: index)
                self.tableViewBuilder.view.endUpdates()
            }
        )
        
        stateChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Default", "Pressed", "Disabled"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.chipsService.update(state: [.default, .pressed, .disabled][index])
                self.chipsCreationService.updateChipsSelection(for: &self.stateChipsUpdaters, selectedIndex: index)
            }
        )
        
        selectedChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["On", "Off"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.chipsService.update(selected: [.on, .off][index])
                self.chipsCreationService.updateChipsSelection(for: &self.selectedChipsUpdaters, selectedIndex: index)
            }
        )
        
        labelChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["True", "False"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.chipsService.update(label: [.true, .false][index])
                self.chipsCreationService.updateChipsSelection(for: &self.labelChipsUpdaters, selectedIndex: index)
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let setChips = setChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let sizeChips = sizeChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let stateChips = stateChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let selectedChips = selectedChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let labelChips = labelChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                leading: .atom(.view(chipsService.view)),
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(setChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(sizeChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(stateChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(selectedChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(labelChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            )
        ]
        
        return rowModels
    }
}
