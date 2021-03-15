//
//  QuotesVC.swift
//  desafiosouth
//
//  Created by Lucas de Assis Siqueira on 14/03/21.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa

class QuotesVC : UIViewController, WKNavigationDelegate
{
	var webView: WKWebView!
	var characterModel : CharacterModel!
	var quotesViewModel = QuotesViewModel()
	var quotesList = PublishSubject<[Quotes]>()
	var episodesTableView =  UITableView()
	private let disposeBag = DisposeBag()
	
	//MARK: - View's cycle
	override func viewDidLoad()
	{
		super.viewDidLoad()
		setViews()
		setBindings()
		quotesViewModel.requestQuotes(author: characterModel.name!)
	}
	
	//MARK: - Set bindings
	fileprivate func setBindings()
	{
		quotesViewModel
			.quotesList
			.observeOn(MainScheduler.instance)
			.bind(to: quotesList)
			.disposed(by: disposeBag)
		
		episodesTableView.register(UINib(nibName: "QuotesTableViewCell", bundle: nil), forCellReuseIdentifier: "QuotesTableViewCell")
		episodesTableView.rowHeight = 100
		quotesList.bind(to: episodesTableView.rx.items(cellIdentifier: "QuotesTableViewCell", cellType: QuotesTableViewCell.self)) {  (row, quotes,cell) in
			cell.quote = quotes
			}.disposed(by: disposeBag)
		
		episodesTableView.rx.willDisplayCell
			.subscribe(onNext: ({ (cell,indexPath) in
				cell.alpha = 1
				cell.layer.transform = CATransform3DIdentity
			})).disposed(by: disposeBag)
	}
	
	
	//MARK: - Set Views
	fileprivate func setViews()
	{
		webView = WKWebView()
		webView.navigationDelegate = self
		let url = URL(string: characterModel.img!)!
		webView.load(URLRequest(url: url))
		
		view.addSubview(webView)
		view.addSubview(quotesLabel)
		view.addSubview(episodesTableView)
		setConstraints()
	}
	
	fileprivate func setConstraints()
	{
		
		webView.translatesAutoresizingMaskIntoConstraints = false
		webView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
		webView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
		webView.widthAnchor.constraint(equalToConstant: 300).isActive = true
		webView.heightAnchor.constraint(equalToConstant: 300).isActive = true
			
		quotesLabel.translatesAutoresizingMaskIntoConstraints = false
		quotesLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20).isActive = true
		quotesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		
		episodesTableView.translatesAutoresizingMaskIntoConstraints = false
		episodesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		episodesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		episodesTableView.topAnchor.constraint(equalTo: quotesLabel.bottomAnchor, constant:  20).isActive = true
		episodesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
	}
	
	private lazy var quotesLabel : UILabel =
	{
		var view = UILabel()
		view.textColor = UIColor(red: 0.243, green: 0.267, blue: 0.384, alpha: 1)
		var paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineHeightMultiple = 0.92
		view.attributedText = NSMutableAttributedString(string: "Frases & Citações", attributes: [NSAttributedString.Key.kern: -0.24, NSAttributedString.Key.paragraphStyle: paragraphStyle])
		return view
	}()
}

