//
//  InfoMapViewControlller.swift
//  Skatable
//
//  Created by Maria Luiza Amaral on 08/09/21.
//

import UIKit

final class InfoMapViewController: UIViewController {
    // MARK: - Private variables

    private var carouselData = [CarouselView.CarouselData]()
    private var carouselView: CarouselView = .init()
    // private var carouselData2 = SpotInfoMapView.carouselData
    private var separator: SeparatorView = .init(frame: CGRect(x: .zero, y: .zero, width: 347, height: 2))

    private lazy var spotInfo: SpotInfoMapView =
        .init(type: .skateSpot,
              title: "Ambiental",
              distance: "150 m",
              rating: 4.5,
              descriptionStopper: "Skate stopper causado por reformas no local, que atrapalham a possibilidade de skatar no espaço.",
              quantityRating: 4,
              address: "Rua Sei Lá Meu, s/n Bairro Alto da Quinze, Curitiba - PR",
              images: [
                  UIImage(asset: Assets.Images.picoAmbiental)!,
                  UIImage(asset: Assets.Images.picoAmbiental)!,
                  UIImage(asset: Assets.Images.picoAmbiental)!,
              ])

    private var listImages: [UIImage] = SpotInfoMapView.imagesList

    // MARK: - Public methods

    // MARK: - Overridden methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()

        carouselData.append(.init(image: UIImage(asset: Assets.Images.picoAmbiental)!))
        carouselData.append(.init(image: UIImage(asset: Assets.Images.picoAmbiental)!))
        carouselData.append(.init(image: UIImage(asset: Assets.Images.picoAmbiental)!))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        carouselView.configureView(with: carouselData)
    }

    // MARK: - Private methods

    private func setupHierarchy() {
        view.addSubview(spotInfo)
        view.addSubview(separator)
        view.addSubview(carouselView)
        // view.addSubview(tableView.view)
    }

    private func setupConstraints() {
        spotInfo.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(LayoutMetrics.heightSpotInfo)
        }

        separator.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(LayoutMetrics.leadingHorizontal)
            make.trailing.equalToSuperview().offset(-LayoutMetrics.leadingHorizontal)
            make.top.equalTo(spotInfo.snp.bottom).offset(LayoutMetrics.topSeparator)
            make.bottom.equalTo(carouselView.snp.top).offset(LayoutMetrics.bottomSeparator)
        }

        carouselView.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(LayoutMetrics.topCarosel)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
//        tableView.view.snp.makeConstraints { make in
//            make.top.equalTo(carouselView.snp.bottom).offset(LayoutMetrics.topCarosel)
//            make.leading.trailing.equalToSuperview()
//            make.bottom.equalToSuperview()
//        }

        view.backgroundColor = Assets.Colors.darkSystemGray5.color
    }

    private enum LayoutMetrics {
        static let topCarosel: CGFloat = 28
        static let heightSpotInfo: CGFloat = 270
        static let leadingHorizontal: CGFloat = 15
        static let topSeparator: CGFloat = 23
        static let bottomSeparator: CGFloat = -26
    }
}

#if DEBUG
    import SwiftUI
    struct SpotInfoViewControllerPreview: PreviewProvider {
        static var previews: some View {
            ContentView()
                .previewDevice("iPhone 12")
                .preferredColorScheme(.dark)
        }

        struct ContentView: UIViewControllerRepresentable {
            func makeUIViewController(context: Context) -> UIViewController {
                return InfoMapViewController()
            }

            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
        }
    }
#endif
