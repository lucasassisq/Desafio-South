//
//  QuotesViewModel.swift
//  desafiosouth
//
//  Created by Lucas de Assis Siqueira on 14/03/21.
//

import Foundation
import RxSwift
class QuotesViewModel
{
	public enum HomeError
	{
		case internetError(String)
		case serverMessage(String)
		case allList(String)
	}
	
	public let quotesList : PublishSubject<[Quotes]> = PublishSubject()
	public let loading: PublishSubject<Bool> = PublishSubject()
	public let error : PublishSubject<HomeError> = PublishSubject()
	private let disposable = DisposeBag()
	
	public func requestQuotes(author : String)
	{
		//activate loading of screen
		self.loading.onNext(true)
		let authorUrl = author.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
		
		//endpoint de citações
		APIManager.requestData(url: "quote?author=\(authorUrl!)", method: .get, parameters: nil, completion: { (result) in
			//deactivate loading of screen
			self.loading.onNext(false)
			switch result {
			case .success(let returnJson) :
				
				//parse to json
				let quotes = returnJson.arrayValue.compactMap {return Quotes(data: try! $0.rawData())}
				self.quotesList.onNext(quotes)

			case .failure(let failure) :
				switch failure {
				case .connectionError:
					self.error.onNext(.internetError("Verifique a sua conexão de internet"))
				case .authorizationError(let errorJson):
					self.error.onNext(.serverMessage(errorJson["message"].stringValue))
				default:
					self.error.onNext(.serverMessage("Erro desconhecido"))
				}
			}
		})
	}
}

