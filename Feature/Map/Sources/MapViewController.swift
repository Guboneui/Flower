//
//  MapViewController.swift
//  Map
//
//  Created by 구본의 on 2023/12/28.
//

import UIKit

import ResourceKit

import NMapsMap
import RxSwift

public final class MapViewController: UIViewController {
	
	// MARK: - UI Property
	private let rootView: MapView = MapView()
	private var mapView: NMFMapView { rootView.mapView }
	private var mapCollectionView: UICollectionView { rootView.mapCollectionView }
	private var houseListButtonView: UIView { rootView.houseListButtonView }
	private var houseListLabel: UILabel { rootView.houseListLabel }
	
	// MARK: LifeCycle
	public override func loadView() {
		view = rootView
	}
	
	private let disposeBag = DisposeBag()
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		setupGestures()
		
		mapCollectionView.dataSource = self
		mapCollectionView.delegate = self
		
		mapCollectionView.register(MapCollectionViewCell.self, forCellWithReuseIdentifier: "MapCollectionViewCell")
		mapCollectionView.decelerationRate = .fast
		mapCollectionView.isPagingEnabled = false

		
		//TODO: 리스트 형태로 넣을 수 있도록 변경해야함
		let marker = NMFMarker()
		marker.position = NMGLatLng(lat: 37.3591784, lng: 127.1048319)
		marker.mapView = mapView
		marker.iconImage = NMFOverlayImage(image: AppTheme.Image.locationMarker)
		marker.width = 32
		marker.height = 32
	}
}

extension MapViewController: UICollectionViewDelegate,
														 UICollectionViewDataSource,
														 UICollectionViewDelegateFlowLayout,
														 UIScrollViewDelegate {
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 10
	}
	
	public func collectionView(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
			guard let cell = collectionView.dequeueReusableCell(
				withReuseIdentifier: "MapCollectionViewCell",
				for: indexPath) as? MapCollectionViewCell else {
				return UICollectionViewCell()
			}
			return cell
		}
	
	public func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		return CGSize(width: 320, height: 141)
	}
	
	public func scrollViewWillEndDragging(
		_ scrollView: UIScrollView,
		withVelocity velocity: CGPoint,
		targetContentOffset: UnsafeMutablePointer<CGPoint>) {
			guard let layout = self.mapCollectionView.collectionViewLayout as?UICollectionViewFlowLayout else { return }
			
			var cellWidthIncludingSpacing: CGFloat = 328
			var offset = targetContentOffset.pointee
			let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
			var roundedIndex = round(index)
			
			offset = CGPoint(
				x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left,
				y: scrollView.contentInset.top)
			targetContentOffset.pointee = offset
		}
}

private extension MapViewController {
	func setupGestures() {
		houseListButtonView.rx.tapGesture()
					.when(.recognized)
					.throttle(.milliseconds(300),
										latest: false,
										scheduler: MainScheduler.instance)
					.bind { [weak self] _ in
						guard let self else { return }
						if mapCollectionView.isHidden {
							mapCollectionView.isHidden = false
							houseListLabel.text = "목록닫기"
							mapCollectionView.snp.updateConstraints({ make in
								make.height.equalTo(141)
								make.bottom.equalToSuperview().offset(-106)
							})
						} else {
							houseListLabel.text = "목록보기"
							mapCollectionView.isHidden = true
							mapCollectionView.snp.updateConstraints({ make in
								make.bottom.equalToSuperview().offset(0)
							})
						}
						
					}.disposed(by: disposeBag)
	}
}
