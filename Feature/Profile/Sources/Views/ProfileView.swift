//
//  ProfileView.swift
//  Profile
//
//  Created by 구본의 on 2024/03/01.
//

import UIKit

import DesignSystem
import ResourceKit
import UtilityKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class ProfileView: UIView {
	// MARK: - Typealias
	private typealias DataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>
	private typealias SnapShot = NSDiffableDataSourceSnapshot<Section, AnyHashable>
	
	// MARK: - Section
	private enum Section {
		case userInfo
		case userInfoSeparator
		case userActivity
		case serviceManagement
	}
	
  // MARK: - Metric
	private enum Metric {
		static let userInfoSeparatorHeight: CGFloat = 4.0
	}
  
  // MARK: - TextSet
	private enum TextSet {
		static let navigationTitle: String = "마이페이지"
		static let userActivityHeaderTitle: String = "내 활동"
		static let serviceManagermentHeaderTitle: String = "서비스 관리"
	}
  
  // MARK: - UI Property
	private let navigationBar: NavigationBar = .init(title: TextSet.navigationTitle)
	private lazy var collectionView: UICollectionView = .init(
		frame: .zero,
		collectionViewLayout: makeCollectionViewLayout()
	).then {
		$0.register(
			UserInfoCollectionViewCell.self,
			forCellWithReuseIdentifier: UserInfoCollectionViewCell.identifier
		)
		$0.register(
			CollectionViewSeparateLineCell.self,
			forCellWithReuseIdentifier: CollectionViewSeparateLineCell.identifier
		)
		$0.register(
			UserActivityCollectionViewCell.self,
			forCellWithReuseIdentifier: UserActivityCollectionViewCell.identifier
		)
		$0.register(
			ServiceManagementCollectionViewCell.self,
			forCellWithReuseIdentifier: ServiceManagementCollectionViewCell.identifier
		)
		$0.register(
			ProfileHeaderCell.self,
			forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
			withReuseIdentifier: ProfileHeaderCell.identifier
		)
		$0.bounces = false
		$0.backgroundColor = AppTheme.Color.white
	}
  
  // MARK: - Property
	private lazy var dataSource: DataSource = makeDataSource()
	private var currentSection: [Section] {
		dataSource.snapshot().sectionIdentifiers as [Section]
	}
	
  // MARK: - Initialize
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupConfigures()
    setupViews()
    setupBinds()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Public Method
	
	/// ProfileView의 CollectionView DataSource의 변경을 감지해 CollectionView를 업데이트 합니다.
	public func setupSnapShot(with viewModel: ProfileViewModel ) {
		var snapShot: SnapShot = .init()
		
		if let userInfo: [UserInfoCellectionViewCellViewModel] = viewModel.userInfo {
			snapShot.appendSections([.userInfo])
			snapShot.appendItems(
				userInfo,
				toSection: .userInfo
			)
			
			snapShot.appendSections([.userInfoSeparator])
			snapShot.appendItems(
				viewModel.userInfoSeparateLine,
				toSection: .userInfoSeparator
			)
		}
		
		if let userActivity: [UserActivityCollectionViewCellViewModel] = viewModel.userActivity {
			snapShot.appendSections([.userActivity])
			snapShot.appendItems(
				userActivity,
				toSection: .userActivity
			)
		}

		if let serviceManagement: [ServiceManagementCollectionViewCelViewModel] = viewModel.serviceManagement {
			snapShot.appendSections([.serviceManagement])
			snapShot.appendItems(
				serviceManagement,
				toSection: .serviceManagement
			)
		}
		
		dataSource.apply(snapShot)
	}
}

// MARK: - Viewable
extension ProfileView: Viewable {
  func setupConfigures() {
		backgroundColor = AppTheme.Color.white
  }
  
  func setupViews() {
		addSubview(navigationBar)
		addSubview(collectionView)
    setupConstraints()
  }
  
  func setupConstraints() {
		navigationBar.snp.makeConstraints { make in
			make.top.equalTo(safeAreaLayoutGuide)
			make.horizontalEdges.equalToSuperview()
		}
		
		collectionView.snp.makeConstraints { make in
			make.top.equalTo(navigationBar.snp.bottom)
			make.horizontalEdges.equalToSuperview()
			make.bottom.equalToSuperview()
		}
  }
  
  func setupBinds() {
    
  }
}

// MARK: - CollectionView
extension ProfileView {
	/// ProfileView의 CollectionView Compositional Layout을 생성합니다.
	private func makeCollectionViewLayout() -> UICollectionViewCompositionalLayout {
		UICollectionViewCompositionalLayout { [weak self] section, _ in
			switch self?.currentSection[section] {
			case .userInfo:
				return UserInfoCollectionViewCell.cellLayout()
			case .userInfoSeparator:
				return CollectionViewSeparateLineCell.cellLayout(height: Metric.userInfoSeparatorHeight)
			case .userActivity:
				return UserActivityCollectionViewCell.cellLayout()
			case .serviceManagement:
				return ServiceManagementCollectionViewCell.cellLayout()
			case .none:
				return nil
			}
		}
	}
	
	/// ProfileView의 CollectionView DiffableDataSource를 생성합니다.
	private func makeDataSource() -> DataSource {
		let dataSource: DataSource = .init(
			collectionView: collectionView,
			cellProvider: { [weak self] collectionView, indexPath, viewModel in
				guard let self else { return UICollectionViewCell() }
				switch self.currentSection[indexPath.section] {
				case .userInfo:
					return self.makeUserInfoCell(collectionView, indexPath, viewModel)
				case .userInfoSeparator:
					return self.makeUserInfoSeparatorCell(collectionView, indexPath, viewModel)
				case .userActivity:
					return self.makeUserActivityCell(collectionView, indexPath, viewModel)
				case .serviceManagement:
					return self.makeServiceManagementCell(collectionView, indexPath, viewModel)
				}
			}
		)
		
		dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
			guard
				let self,
				kind == UICollectionView.elementKindSectionHeader,
				let headerView: ProfileHeaderCell = collectionView.dequeueReusableSupplementaryView(
					ofKind: kind,
					withReuseIdentifier: ProfileHeaderCell.identifier,
					for: indexPath
				) as? ProfileHeaderCell
			else {
				return .init()
			}
			
			switch self.currentSection[indexPath.section] {
			case .userActivity:
				headerView.setupTitle(with: TextSet.userActivityHeaderTitle)
			case .serviceManagement:
				headerView.setupTitle(with: TextSet.serviceManagermentHeaderTitle)
			default:
				return nil
			}
			return headerView
		}
		
		return dataSource
	}
	
	private func makeUserInfoCell(
		_ collectionView: UICollectionView,
		_ indexPath: IndexPath,
		_ viewModel: AnyHashable
	) -> UICollectionViewCell {
		guard 
			let cell: UserInfoCollectionViewCell = collectionView.dequeueReusableCell(
				withReuseIdentifier: UserInfoCollectionViewCell.identifier,
				for: indexPath
			) as? UserInfoCollectionViewCell
		else {
			return .init()
		}
		return cell
	}
	
	private func makeUserInfoSeparatorCell(
		_ collectionView: UICollectionView,
		_ indexPath: IndexPath,
		_ viewModel: AnyHashable
	) -> UICollectionViewCell {
		guard
			let cell: CollectionViewSeparateLineCell = collectionView.dequeueReusableCell(
				withReuseIdentifier: CollectionViewSeparateLineCell.identifier,
				for: indexPath
			) as? CollectionViewSeparateLineCell
		else {
			return .init()
		}
		return cell
	}
	
	private func makeUserActivityCell(
		_ collectionView: UICollectionView,
		_ indexPath: IndexPath,
		_ viewModel: AnyHashable
	) -> UICollectionViewCell {
		guard
			let viewModel: UserActivityCollectionViewCellViewModel = viewModel
				as? UserActivityCollectionViewCellViewModel,
			let cell: UserActivityCollectionViewCell = collectionView.dequeueReusableCell(
				withReuseIdentifier: UserActivityCollectionViewCell.identifier,
				for: indexPath
			) as? UserActivityCollectionViewCell
		else {
			return .init()
		}
		cell.setupCellData(with: viewModel)
		return cell
	}
	
	private func makeServiceManagementCell(
		_ collectionView: UICollectionView,
		_ indexPath: IndexPath,
		_ viewModel: AnyHashable
	) -> UICollectionViewCell {
		guard
			let viewModel: ServiceManagementCollectionViewCelViewModel = viewModel
				as? ServiceManagementCollectionViewCelViewModel,
			let cell: ServiceManagementCollectionViewCell = collectionView.dequeueReusableCell(
				withReuseIdentifier: ServiceManagementCollectionViewCell.identifier,
				for: indexPath
			) as? ServiceManagementCollectionViewCell
		else {
			return .init()
		}
		cell.setupCellData(with: viewModel)
		return cell
	}
}
