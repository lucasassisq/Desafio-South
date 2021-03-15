//
//  PersonagensCollectionViewVC.swift
//  desafiosouth
//
//  Created by Lucas de Assis Siqueira on 14/03/21.
//

import UIKit
import RxSwift
import RxCocoa

class PersonagensCollectionViewVC: UIViewController, episodiosDelegate
{
				
	@IBOutlet private weak var personCollectionView: UICollectionView!
	
	public var personList = PublishSubject<[CharacterModel]>()
	
	private let disposeBag = DisposeBag()
	
	//MARK: - Interface delegate
	func onClick(character: CharacterModel)
	{
		//open web view screen
		let viewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PersonagemVC") as! QuotesVC
		viewController.characterModel = character
		viewController.modalPresentationStyle = .automatic
		self.present(viewController, animated: true, completion: nil)
	}
	
	//MARK: - View's Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupBinding()
		personCollectionView.backgroundColor = .clear
	}
	
	
	//MARK: - Bindings
	private func setupBinding()
	{
		personCollectionView.register(UINib(nibName: "PersonagensCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: String(describing: PersonagensCollectionViewCell.self))
				
		personList.bind(to: personCollectionView.rx.items(cellIdentifier: "PersonagensCollectionViewCell", cellType: PersonagensCollectionViewCell.self)) {  (row, person,cell) in
			cell.personModel = person
			cell.withBackView = true
			cell.delegate = self
			}.disposed(by: disposeBag)
		
		personCollectionView.rx.willDisplayCell
			.subscribe(onNext: ({ (cell,indexPath) in
				cell.alpha = 1
				cell.layer.transform = CATransform3DIdentity
			})).disposed(by: disposeBag)
	}
	
}

