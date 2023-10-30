import UIKit
@_exported import CellsReloadable
import CompositionalLayoutDSL

extension CellsSection.Values {
    
    public var layout: LayoutSection? {
        self[\.layout] ?? nil
    }
}

public protocol LayoutableSection: CellsSectionConvertible, Identifiable<String> {
    
    var layout: LayoutSection { get }
    var cells: [ViewCell] { get }
}

extension CellsSectionConvertible where Self: LayoutableSection {
    
    public var asCellsSection: CellsSection {
        CellsSection(id: id, cells: cells)
            .with(\.layout, layout)
    }
}

public struct HSection: LayoutableSection {
    
    public var id: String
    public var cells: [ViewCell]
    public var spacing: NSCollectionLayoutSpacing
    public var height: NSCollectionLayoutDimension
    public var itemWidth: NSCollectionLayoutDimension
    
    public init(
        id: String,
        cells: [ViewCell],
        spacing: NSCollectionLayoutSpacing,
        height: NSCollectionLayoutDimension,
        itemWidth: NSCollectionLayoutDimension
    ) {
        self.id = id
        self.cells = cells
        self.spacing = spacing
        self.height = height
        self.itemWidth = itemWidth
    }
    
    public init(
        id: String,
        spacing: NSCollectionLayoutSpacing = .fixed(0),
        height: NSCollectionLayoutDimension,
        itemWidth: NSCollectionLayoutDimension,
        @ViewCellsBuilder _ cells: () -> [ViewCell]
    ) {
        self.init(
            id: id,
            cells: cells(),
            spacing: spacing,
            height: height,
            itemWidth: itemWidth
        )
    }
    
    public var layout: LayoutSection {
        Section {
            HGroup(
                width: itemWidth,
                height: height
            ) {
                Item(
                    width: itemWidth,
                    height: .fractionalHeight(1)
                )
            }
            .interItemSpacing(spacing)
        }
    }
}

extension CellsSection {
    
    public func layout(_ section: LayoutSection) -> CellsSection {
        with(\.layout, section)
    }
    
    public func layout(group: () -> LayoutGroup) -> CellsSection {
        layout(Section(group: group))
    }
    
    public func layout(section: () -> LayoutSection) -> CellsSection {
        layout(section())
    }
}

public extension CompositionalLayout {
    
    init(
        configuration: LayoutConfiguration = Configuration(),
        reloader: UICollectionViewReloader
    ) {
        self.init(configuration: configuration) { [weak reloader] sectionIndex, environment in
            reloader?.sectionValues(forSection: sectionIndex)?.layout
        }
    }
}

extension LayoutSection where Self == Section {
    
    public static func horizontal(
        spacing: NSCollectionLayoutSpacing = .fixed(0),
        height: NSCollectionLayoutDimension,
        itemWidth: NSCollectionLayoutDimension
    ) -> LayoutSection {
        Section {
            HGroup(
                width: itemWidth,
                height: height
            ) {
                Item(
                    width: itemWidth,
                    height: .fractionalHeight(1)
                )
            }
            .interItemSpacing(spacing)
        }
    }
}
