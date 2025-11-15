import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class InputModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var inputService: InputViewService
    private var stateChipsUpdaters: [ChipsViewService] = []
    private var setChipsUpdaters: [ChipsViewService] = []
    private var labelChipsUpdaters: [ChipsViewService] = []
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        inputService = .init(
            viewProperties: .init(
                textFieldViewProperties: .init(
                    placeholder: .init(string: "Placeholder")
                ),
                onTextChanged: { text in print(text) }
            ),
            style: .init(
                state: .default,
                set: .simple,
                label: .on
            )
        )
        inputService.labelService.update(newText: .init(string: "Label"))
        inputService.hintService.update(newText: .init(string: "Hint"))
        
        super.init(
            tableDataSource: tableDataSource,
            tableDelegate: tableDelegate,
            navigationBarViewPropertiesService: navigationBarViewPropertiesService
        )
    }
    
    // MARK: Methods
 
    override func createUpdaters() {
        stateChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Default", "Active", "Error", "Disabled"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.inputService.update(state: [.default, .active, .error, .disabled][index])
                self.chipsCreationService.updateChipsSelection(for: &self.stateChipsUpdaters, selectedIndex: index)
            }
        )
        
        setChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Simple", "Icon", "Prefix"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.inputService.update(set: [.simple, .icon(.ic24Frame), .prefix(.init(string: "Prefix"))][index])
                self.chipsCreationService.updateChipsSelection(for: &self.setChipsUpdaters, selectedIndex: index)
            }
        )
        
        labelChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["On", "Off"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.tableViewBuilder.view.beginUpdates()
                self.inputService.update(label: [.on, .off][index])
                self.chipsCreationService.updateChipsSelection(for: &self.labelChipsUpdaters, selectedIndex: index)
                self.tableViewBuilder.view.endUpdates()
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let stateChips = stateChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let setChips = setChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let labelChips = labelChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                center: .atom(.view(inputService.view)),
                centralBlockAlignment: .fill,
                margings: .init(),
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(stateChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(setChips)),
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
