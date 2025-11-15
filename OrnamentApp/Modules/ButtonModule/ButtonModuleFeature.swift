import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class ButtonModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var buttonService: ButtonViewService
    private var sizeChipsUpdaters: [ChipsViewService] = []
    private var colorChipsUpdaters: [ChipsViewService] = []
    private var variantChipsUpdaters: [ChipsViewService] = []
    private var stateChipsUpdaters: [ChipsViewService] = []
    private var iconChipsUpdaters: [ChipsViewService] = []
    private var size: ButtonViewStyle.Size
    private var icon: ButtonViewStyle.Icon
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        size = .small
        icon = .without
        buttonService = .init(
            viewProperties: .init(
                attributedText: .init(string: "Label"),
                onTap: { print("Button tapped!") }
            ),
            style: .init(
                size: size,
                color: .accent,
                variant: .primary,
                state: .default,
                icon: icon
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
        sizeChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Small", "Large"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.tableViewBuilder.view.beginUpdates()
                size = [.small, .large][index]
                if case .with = icon { icon = remakeIcon() }
                self.buttonService.update(newSize: size, newIcon: icon)
                self.chipsCreationService.updateChipsSelection(for: &self.sizeChipsUpdaters, selectedIndex: index)
                self.tableViewBuilder.view.endUpdates()
            }
        )
        
        colorChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Accent", "Light"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.buttonService.update(newColor: [.accent, .light][index])
                self.chipsCreationService.updateChipsSelection(for: &self.colorChipsUpdaters, selectedIndex: index)
            }
        )
        
        variantChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Primary", "Secondary", "Tertiary", "Function"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.buttonService.update(newVariant: [.primary, .secondary, .tertiary, .function][index])
                self.chipsCreationService.updateChipsSelection(for: &self.variantChipsUpdaters, selectedIndex: index)
            }
        )
        
        stateChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Default", "Pressed", "Loading", "Disabled"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.buttonService.update(newState: [.default, .pressed, .loading, .disabled][index])
                self.chipsCreationService.updateChipsSelection(for: &self.stateChipsUpdaters, selectedIndex: index)
            }
        )
        
        iconChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Without icon", "With icon"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                icon = [.without, remakeIcon()][index]
                self.buttonService.update(newIcon: icon)
                self.chipsCreationService.updateChipsSelection(for: &self.iconChipsUpdaters, selectedIndex: index)
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let sizeChips = sizeChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let colorChips = colorChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let variantChips = variantChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let stateChips = stateChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let iconChips = iconChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                leading: .atom(.view(buttonService.view)),
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(sizeChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(colorChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(variantChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(stateChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(iconChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            )
        ]
        
        return rowModels
    }
    
    private func remakeIcon() -> ButtonViewStyle.Icon {
        switch size {
        case .large: .with(.ic24Refresh)
        case .small: .with(.ic16Refresh)
        }
    }
}
