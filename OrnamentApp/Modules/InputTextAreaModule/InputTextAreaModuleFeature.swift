import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class InputTextAreaModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var inputTextAreaService: InputTextAreaViewService
    private var stateChipsUpdaters: [ChipsViewService] = []
    private var setChipsUpdaters: [ChipsViewService] = []
    private var labelChipsUpdaters: [ChipsViewService] = []
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        inputTextAreaService = .init(
            viewProperties: .init(
                placeholder: .init(string: "Placeholder"),
                onTextChanged: { text in print(text) }
            ),
            style: .init(
                state: .default,
                label: .on
            )
        )
        inputTextAreaService.labelService.update(newText: .init(string: "Label"))
        inputTextAreaService.hintService.update(newAdditionalText: .init(string: "n/n"))
        
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
                self.inputTextAreaService.update(newState: [.default, .active, .error, .disabled][index])
                self.chipsCreationService.updateChipsSelection(for: &self.stateChipsUpdaters, selectedIndex: index)
            }
        )
        
        labelChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["On", "Off"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.tableViewBuilder.view.beginUpdates()
                self.inputTextAreaService.update(newLabel: [.on, .off][index])
                self.chipsCreationService.updateChipsSelection(for: &self.labelChipsUpdaters, selectedIndex: index)
                self.tableViewBuilder.view.endUpdates()
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let stateChips = stateChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let labelChips = labelChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                center: .atom(.view(inputTextAreaService.view)),
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
                center: .molecule(.horizontalChipsViews(labelChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            )
        ]
        
        return rowModels
    }
}
