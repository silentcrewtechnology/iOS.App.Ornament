import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class ButtonAuthModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var buttonAuthService: ButtonAuthService
    private var variantUpdaters: [ChipsViewService] = []
    private var stateUpdaters: [ChipsViewService] = []
    private var colorUpdaters: [ChipsViewService] = []
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        buttonAuthService = .init(
            viewProperties: .init(
                text: .init(string: "Войти через Госуслуги"),
                image: UIImage(named: "buttonAuth_gosuslugi") ?? .init()
            ),
            style: .init(
                variant: .gosuslugi,
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
        variantUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Gosuslugi", "ABB"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.buttonAuthService.update(
                    newVariant: [.gosuslugi, .abb][index],
                    newText: [.init(string: "Войти через Госуслуги"), .init(string: "Войти через АББ")][index],
                    newImage: [.init(named: "buttonAuth_gosuslugi"), .init(named: "buttonAuth_abb")][index]
                )
                self.chipsCreationService.updateChipsSelection(for: &self.variantUpdaters, selectedIndex: index)
            }
        )
        
        stateUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Default", "Pressed"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.buttonAuthService.update(newState: [.default, .pressed][index])
                self.chipsCreationService.updateChipsSelection(for: &self.stateUpdaters, selectedIndex: index)
            }
        )
        
        colorUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Accent", "Light"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.buttonAuthService.update(newColor: [.accent, .light][index])
                self.chipsCreationService.updateChipsSelection(for: &self.colorUpdaters, selectedIndex: index)
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let variantChips = variantUpdaters.map { updater -> (ChipsView) in updater.view }
        let stateChips = stateUpdaters.map { updater -> (ChipsView) in updater.view }
        let colorChips = colorUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                leading: .atom(.view(buttonAuthService.view)),
                cellSelectionStyle: .none
            ),
            .init(
                leading: .molecule(.horizontalChipsViews(variantChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                leading: .molecule(.horizontalChipsViews(stateChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                leading: .molecule(.horizontalChipsViews(colorChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            )
        ]
        
        return rowModels
    }
}
