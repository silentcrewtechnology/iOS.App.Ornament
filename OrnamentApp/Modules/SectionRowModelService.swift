import UIKit
import DesignSystem
import ArchitectureTableView

struct SectionRowModelService {
    
    func createSections(from rows: [DSRowModel],
                        rowsHeight: CGFloat? = nil,
                        cellBackgroundColor: UIColor = .white) -> [SectionModel] {
        return rows.map { row in
            let cell = DSCreationRowsViewService().createViewRowWithBlocks(
                leading: row.leading,
                center: row.center,
                trailing: row.trailing,
                centralBlockAlignment: row.centralBlockAlignment
            )
            let cellModel = CellModel(
                view: cell,
                selectionStyle: .none,
                height: rowsHeight,
                didTap: nil,
                backgroundColor: cellBackgroundColor
            )
            return SectionModel(cells: [cellModel])
        }
    }
}
