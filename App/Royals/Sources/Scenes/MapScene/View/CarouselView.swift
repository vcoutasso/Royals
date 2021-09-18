//
//  CarouselView.swift
//  Skatable
//
//  Created by Maria Luiza Amaral on 09/09/21.
//
import UIKit

class CarouselView: UIView, UICollectionViewDelegate {
    struct CarouselData {
        let image: UIImage?
    }

    // MARK: - Subviews

    private lazy var carouselCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.showsHorizontalScrollIndicator = false
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        collection.register(CarouselCell.self, forCellWithReuseIdentifier: CarouselCell.cellId)
        return collection
    }()

    // MARK: - Properties

    private var carouselData = [CarouselData]()

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private enum LayoutMetrics {
        static let leadingCarosel: CGFloat = 15
        static let heightCarosel: CGFloat = 150
    }
}

// MARK: - Setups

private extension CarouselView {
    func setupUI() {
        backgroundColor = .clear
        setupCollectionView()
    }

    func setupCollectionView() {
        backgroundColor = Assets.Colors.darkSystemGray5.color
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.itemSize = .init(width: 150, height: 150)
        carouselLayout.sectionInset = .zero
        carouselCollectionView.collectionViewLayout = carouselLayout
        addSubview(carouselCollectionView)
        carouselCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(LayoutMetrics.heightCarosel)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension CarouselView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carouselData.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.cellId,
                                                            for: indexPath) as? CarouselCell
        else { return UICollectionViewCell() }

        let image = carouselData[indexPath.row].image

        cell.configure(image: image)

        return cell
    }
}

// MARK: - Public

extension CarouselView {
    public func configureView(with data: [CarouselData]) {
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.itemSize = .init(width: 150, height: 150)
        carouselLayout.sectionInset = .zero
        carouselCollectionView.collectionViewLayout = carouselLayout

        carouselData = data
        carouselCollectionView.reloadData()
    }
}
