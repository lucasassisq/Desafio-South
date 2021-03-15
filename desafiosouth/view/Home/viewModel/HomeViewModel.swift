//
//  HomeViewModel.swift
//  desafiosouth
//
//  Created by Lucas de Assis Siqueira on 14/03/21.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON

class HomeViewModel
{
	public enum HomeError
	{
		case internetError(String)
		case serverMessage(String)
		case allList(String)
	}
	
	public let charactersList : PublishSubject<[CharacterModel]> = PublishSubject()
	public let episodesList : PublishSubject<[Episodes]> = PublishSubject()
	public let loading: PublishSubject<Bool> = PublishSubject()
	public let error : PublishSubject<HomeError> = PublishSubject()
	
	private let disposable = DisposeBag()
		
	var episodesViewModel = EpisodesViewModel()
	
	public func requestCharacters()
	{
		//this method was called only 1 time
		//activate loading of screen
		self.loading.onNext(true)
		APIManager.requestData(url: "characters/?limit=10", method: .get, parameters: nil, completion: { (result) in
			//deactivate loading of screen
			self.loading.onNext(false)
			switch result {
			case .success(let returnJson) :
				
				//parse to json
				var charactersLocalList = returnJson.arrayValue.compactMap {return CharacterModel(data: try! $0.rawData())}
				
				//vamos ordenar por z-a, quero que o Walter White apareça em um dos primeiros :D
				charactersLocalList = charactersLocalList.sorted(by: { $0.name! > $1.name! })
				self.charactersList.onNext(charactersLocalList)

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
	
	public func requestEpisodes()
	{
		//this method was called only 1 time
		//activate loading of screen
		self.loading.onNext(true)
		APIManager.requestData(url: "episodes/", method: .get, parameters: nil, completion: { (result) in
			//deactivate loading of screen
			self.loading.onNext(false)
			switch result {
			case .success(let returnJson) :
				
				//vamos ordenar os episódios por seus ID's
				var episodes = returnJson.arrayValue.compactMap {return Episodes(data: try! $0.rawData())}
				episodes = episodes.sorted(by: { $0.episodeID! < $1.episodeID! })
				
				self.episodesList.onNext(episodes)
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

