import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class NavigationBarModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var navigationBarService: NavigationBarService?
    private var variantChipsUpdaters: [ChipsViewService] = []
    private var colorChipsUpdaters: [ChipsViewService] = []
    private var rightItemsUpdaters: [ChipsViewService] = []
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        super.init(
            tableDataSource: tableDataSource,
            tableDelegate: tableDelegate,
            navigationBarViewPropertiesService: navigationBarViewPropertiesService
        )
        
        // Без задержки не успевает проставиться navigationController в tableViewVCBuilder.view
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.createNavigationBarService()
        }
    }
    
    // MARK: Methods
 
    override func createUpdaters() {
        variantChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["None", "Collapsed", "Basic", "Search", "Basic amount", "Main screen"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.navigationBarService?.update(
                    newVariant: [
                        NavigationBarStyle.Variant.none,
                        .collapsed(title: "Title"),
                        .basic(
                            title: "Title",
                            subtitle: "Subtitle"
                        ),
                        .search(
                            title: "Title",
                            subtitle: "Subtitle"
                        ),
                        .basicAmount(
                            title: "Title",
                            subtitle: "Subtitle"
                        ),
                        .mainScreen(
                            name: "Name",
                            icon: .ic24User,
                            onProfile: { }
                        )
                    ][index],
                    newBackAction: { self.runNewFlow?(ModuleFlow.back) }
                )
                self.chipsCreationService.updateChipsSelection(for: &self.variantChipsUpdaters, selectedIndex: index)
            }
        )
        
        colorChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Main", "Primary"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.navigationBarService?.update(
                    newColor: [.main, .primary][index],
                    newBackAction: { self.runNewFlow?(ModuleFlow.back) }
                )
                self.chipsCreationService.updateChipsSelection(for: &self.colorChipsUpdaters, selectedIndex: index)
            }
        )
        
        rightItemsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["0", "1", "2", "3"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.navigationBarService?.update(
                    newRightBarButtonItems: self.createBarButtonItems(count: index),
                    newBackAction: { self.runNewFlow?(ModuleFlow.back) }
                )
                self.chipsCreationService.updateChipsSelection(for: &self.rightItemsUpdaters, selectedIndex: index)
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let variantChis = variantChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let colorChips = colorChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let rightItemsChips = rightItemsUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                center: .molecule(.horizontalChipsViews(variantChis)),
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(colorChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(rightItemsChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            )
        ]
        
        return rowModels
    }
    
    // MARK: - Private methods
    
    private func createNavigationBarService() {
        navigationBarService = .init(
            rootVC: tableViewVCBuilder.view,
            view: tableViewVCBuilder.view.navigationController as? NavigationBar,
            style: .init(
                variant: .none,
                color: .main
            )
        )
    }
    
    private func createBarButtonItems(count: Int) -> [UIBarButtonItem] {
        var items = [UIBarButtonItem]()
        for _ in 0..<count {
            items.append(
                .init(
                    image: .ic24Frame
                        .withTintColor(.Semantic.LightTheme.Content.Base.primary)
                        .withRenderingMode(.alwaysOriginal),
                    style: .plain,
                    target: nil,
                    action: nil
                )
            )
        }
        
        return items
    }
}
