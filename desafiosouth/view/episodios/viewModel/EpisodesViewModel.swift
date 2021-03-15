//
//  EpisodesViewModel.swift
//  desafiosouth
//
//  Created by Lucas de Assis Siqueira on 14/03/21.
//

import Foundation
import RxSwift
import RxCocoa

class EpisodesViewModel
{
	public let episodesList : PublishSubject<Episodes> = PublishSubject()
}
