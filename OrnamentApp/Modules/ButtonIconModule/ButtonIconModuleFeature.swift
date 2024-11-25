import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class ButtonIconModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var buttonIconService: ButtonIconService
    private var variantChipsUpdaters: [ChipsViewService] = []
    private var sizeChipsUpdaters: [ChipsViewService] = []
    private var stateChipsUpdaters: [ChipsViewService] = []
    private var colorChipsUpdaters: [ChipsViewService] = []
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        buttonIconService = .init(
            viewProperties: .init(
                image: .ic16Close,
                onTap: { print("ButtonIcon tapped!") }
            ),
            style: .init(
                variant: .primary,
                size: .small,
                state: .default,
                color: .accent
            )
        )
            
        super.init(
            tableDataSource: tableDataSource,
            tableDelegate: tableDelegate,
            navigationBarViewPropertiesService: navigationBarViewPropertiesService
        )
    }
    
    // MARK: Methods
 
    override func createUpdaters() {
        variantChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Primary", "Secondary"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.buttonIconService.update(newVariant: [.primary, .secondary][index])
                self.chipsCreationService.updateChipsSelection(for: &self.variantChipsUpdaters, selectedIndex: index)
            }
        )
    
        sizeChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Small", "Large"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.tableViewBuilder.view.beginUpdates()
                self.buttonIconService.update(
                    newSize: [.small, .large][index],
                    newImage: [.ic16Close, .ic24PlayFilled][index]
                )
                self.chipsCreationService.updateChipsSelection(for: &self.sizeChipsUpdaters, selectedIndex: index)
                self.tableViewBuilder.view.endUpdates()
            }
        )
        
        stateChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Default", "Pressed", "Loading", "Disabled"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.buttonIconService.update(newState: [.default, .pressed, .loading, .disabled][index])
                self.chipsCreationService.updateChipsSelection(for: &self.stateChipsUpdaters, selectedIndex: index)
            }
        )
        
        colorChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Accent", "Light"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.buttonIconService.update(newColor: [.accent, .light][index])
                self.chipsCreationService.updateChipsSelection(for: &self.colorChipsUpdaters, selectedIndex: index)
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let variantChips = variantChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let sizeChips = sizeChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let stateChips = stateChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let colorChips = colorChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                leading: .atom(.view(buttonIconService.view)),
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(variantChips)),
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
                center: .molecule(.horizontalChipsViews(colorChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            )
        ]
        
        return rowModels
    }
}
