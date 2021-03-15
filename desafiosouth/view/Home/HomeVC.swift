//
//  FeedViewController.swift
//  desafiosouth
//
//  Created by Lucas de Assis Siqueira on 14/03/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeVC: UIViewController
{
	
	// MARK: - SubViews
	@IBOutlet weak var episodesView: UIView!
	@IBOutlet weak var personView: UIView!
	
	private lazy var personCollectionVC: PersonagensCollectionViewVC =
	{
		// Load Storyboard
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		
		// Instantiate View Controller
		var viewController = storyboard.instantiateViewController(withIdentifier: "PersonagensCollectionViewVC") as! PersonagensCollectionViewVC
		
		// Add View Controller as Child View Controller
		self.add(asChildViewController: viewController, to: personView)
		
		return viewController
	}()
	
	
	private lazy var episodiosVC: EpisodiosTableViewVC = {
		// Load Storyboard
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		
		// Instantiate View Controller
		var viewController = storyboard.instantiateViewController(withIdentifier: "EpisodiosTableViewVC") as! EpisodiosTableViewVC
		// Add View Controller as Child View Controller
		self.add(asChildViewController: viewController, to: episodesView)
		
		return viewController
	}()
	
	var homeViewModel = HomeViewModel()
	
	let disposeBag = DisposeBag()
	
	// MARK: - View's Cycle
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		setupBindings()
		homeViewModel.requestCharacters()
		homeViewModel.requestEpisodes()
	}
	
	override func viewWillAppear(_ animated: Bool)
	{
		self.navigationController?.isNavigationBarHidden = false
		self.navigationItem.title = "Página Inicial" // colocou nome no título da viewcontrolller
	}
	
	// MARK: - Bindings
	
	private func setupBindings()
	{
		// binding carregando screen to vc
		
		homeViewModel.loading
			.bind(to: self.rx.isAnimating).disposed(by: disposeBag)
				
		//  observer errors
		
		homeViewModel
			.error
			.observeOn(MainScheduler.instance)
			.subscribe(onNext: { (error) in
				switch error {
				case .internetError(let message):
					MessageView.sharedInstance.showOnView(message: message, theme: .error)
				case .serverMessage(let message):
					MessageView.sharedInstance.showOnView(message: message, theme: .warning)
				case.allList(let message):
					MessageView.sharedInstance.showOnView(message: message, theme: .success)
				}
			})
			.disposed(by: disposeBag)
		
		
		// binding characters / personagens
		
		homeViewModel
			.charactersList
			.observeOn(MainScheduler.instance)
			.bind(to: personCollectionVC.personList)
			.disposed(by: disposeBag)
		
		// binding episodes / episódios
		
		homeViewModel
			.episodesList
			.observe(on: MainScheduler.instance)
			.bind(to: episodiosVC.episodesList)
			.disposed(by: disposeBag)
			
	   
	}
}

