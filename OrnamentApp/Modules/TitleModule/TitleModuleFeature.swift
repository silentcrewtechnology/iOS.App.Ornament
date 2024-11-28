import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class TitleModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var titleService: TitleViewService
    private var sizeChipsService: [ChipsViewService] = []
    private var colorChipsService: [ChipsViewService] = []
    private var componentsChipsService: [ChipsViewService] = []
    private var buttonChipsService: [ChipsViewService] = []
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        titleService = .init(
            viewProperties: .init(
                title: .init(string: "Title")
            ),
            style: .init(size: .small, color: .primary),
            buttonIconService: .init(
                viewProperties: .init(
                    image: .ic16Close,
                    onTap: { print("Close button tapped!") }
                ),
                style: .init(variant: .secondary, size: .small, state: .default, color: .accent)
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
        sizeChipsService = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Small", "Medium", "Large", "Extra large"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.tableViewBuilder.view.beginUpdates()
                self.titleService.update(newSize: [.small, .medium, .large, .extraLarge][index])
                self.chipsCreationService.updateChipsSelection(for: &self.sizeChipsService, selectedIndex: index)
                self.tableViewBuilder.view.endUpdates()
            }
        )

        colorChipsService = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Primary", "Secondary"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.titleService.update(newTitleColor: [.primary, .secondary][index])
                self.chipsCreationService.updateChipsSelection(for: &self.colorChipsService, selectedIndex: index)
            }
        )
        
        componentsChipsService = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Title", "Title and description", "Description", "Empty"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.tableViewBuilder.view.beginUpdates()
                self.titleService.update(
                    newTitle: [
                        .init(string: "Title"),
                        .init(string: "Title"),
                        .init(string: ""),
                        .init(string: "")
                    ][index],
                    newDescription: [
                        .init(string: ""),
                        .init(string: "Description"),
                        .init(string: "Description"),
                        .init(string: "")
                    ][index]
                )
                self.chipsCreationService.updateChipsSelection(for: &self.componentsChipsService, selectedIndex: index)
                self.tableViewBuilder.view.endUpdates()
            }
        )
        
        buttonChipsService = chipsCreationService.createChipsUpdaters(
            chipTitles: ["True", "False"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.titleService.update(showButton: [true, false][index])
                self.chipsCreationService.updateChipsSelection(for: &self.buttonChipsService, selectedIndex: index)
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let sizeChips = sizeChipsService.map { updater -> (ChipsView) in updater.view }
        let colorChips = colorChipsService.map { updater -> (ChipsView) in updater.view }
        let componentsChips = componentsChipsService.map { updater -> (ChipsView) in updater.view }
        let buttonChips = buttonChipsService.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                center: .atom(.view(titleService.view)),
                centralBlockAlignment: .fill,
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
                center: .molecule(.horizontalChipsViews(componentsChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(buttonChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            )
        ]
        
        return rowModels
    }
}
