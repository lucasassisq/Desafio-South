//
//  EpisodiosTableViewVC.swift
//  desafiosouth
//
//  Created by Lucas de Assis Siqueira on 14/03/21.
//

import UIKit
import RxSwift
import RxCocoa

class EpisodiosTableViewVC: UIViewController
{
	
	@IBOutlet private weak var episodesTableView: UITableView!
		
	public var episodesList = PublishSubject<[Episodes]>()
	
	private let disposeBag = DisposeBag()
		
	
	//MARK: - View's Cycle
	override func viewDidLoad()
	{
		super.viewDidLoad()
		setupBinding()
	}
	
	
	//MARK: - Bindings
	private func setupBinding()
	{
		episodesTableView.register(UINib(nibName: "EpisodiosTableViewCell", bundle: nil), forCellReuseIdentifier: String(describing: EpisodiosTableViewCell.self))
		
		episodesList.bind(to: episodesTableView.rx.items(cellIdentifier: "EpisodiosTableViewCell", cellType: EpisodiosTableViewCell.self)) {  (row,episodes,cell) in
			cell.cellEpisodes = episodes
			}.disposed(by: disposeBag)
				
		episodesTableView.rx.willDisplayCell
			.subscribe(onNext: ({ (cell,indexPath) in
				cell.alpha = 1
				cell.layer.transform = CATransform3DIdentity
			})).disposed(by: disposeBag)
	}
}





