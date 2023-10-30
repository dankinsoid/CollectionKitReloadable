import SwiftUI
import CollectionKitReloadable

class ViewController: UIViewController {

    let collection = UICollectionView(
        frame: .zero,
        collectionViewLayout: LayoutBuilder {
            CompositionalLayout { index, _ in
                Section.horizontal(
                    height: .fractionalHeight(1),
                    itemWidth: .estimated(100)
                )
//                    .orthogonalScrollingBehavior(.continuous)
            }
            .scrollDirection(.horizontal)
            .interSectionSpacing(100)
        }
    )
    lazy var reloader = UICollectionViewReloader(collection)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collection)
        collection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.topAnchor.constraint(equalTo: view.topAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        reloader.reloadSections {
            for i in 0..<4 {
                CellsSection(id: "\(i)") {
                    for j in 0..<25 {
                        ViewCell(id: "\(i)\(j)") {
                            Cell()
                        } render: { cell in
                            cell.label.text = "\(j)"
                        }
                    }
                }
            }
        }
    }
}

final class Cell: UIView {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 29),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError() }
}
