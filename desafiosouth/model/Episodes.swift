//
//  Episodes.swift
//  desafiosouth
//
//  Created by Lucas de Assis Siqueira on 14/03/21.
//

import Foundation

struct Episodes : Codable {
	var episodeID: Int?
	var title, season, airDate: String?
	var characters: [String]?
	var episode, series: String?

	enum CodingKeys: String, CodingKey {
		case episodeID = "episode_id"
		case title, season
		case airDate = "air_date"
		case characters, episode, series
	}
}

extension Episodes {
	init?(data: Data) {
		do
		{
			var me = try JSONDecoder().decode(Episodes.self, from: data)
			self = me
		}catch let error
		{
			//pt-br necessário, devido à alguns JSON's estarem vindo com nós pendentes.
			let me = try! JSONDecoder().decode(Episodes.self, from: data)
			var episode = Episodes.init(episodeID: episodeID, title: title, season: season, airDate: airDate, characters: characters, episode: self.episode, series: series)
			self = episode
		}
		
	}
}
