import UIKit
import DesignSystem
import Components

struct ChipsCreationService {
    
    func createChipsUpdaters(
        chipTitles: [String],
        selectedIndex: Int = 0,
        onChipTap: @escaping (Int) -> Void
    ) -> [ChipsViewService] {
        return chipTitles.enumerated().map { (index, title) -> ChipsViewService in
            let isSelected = selectedIndex == index
            
            let chipsViewProperties = ChipsView.ViewProperties(
                text: .init(string: title),
                onChipsTap: { _ in
                    onChipTap(index)
                }
            )
            
            let selected: ChipsViewStyle.Selected = isSelected ? .on : .off
            let chipsStyle = ChipsViewStyle(selected: selected)
            
            return ChipsViewService(
                viewProperties: chipsViewProperties,
                style: chipsStyle
            )
        }
    }
}
