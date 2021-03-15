//
//  Quotes.swift
//  desafiosouth
//
//  Created by Lucas de Assis Siqueira on 14/03/21.
//

import Foundation
//   let quotes = try? newJSONDecoder().decode(Quotes.self, from: jsonData)

// MARK: - Quotes
struct Quotes: Codable {
	var quoteID: Int?
	var quote, author, series: String?

	enum CodingKeys: String, CodingKey {
		case quoteID = "quote_id"
		case quote, author, series
	}
}
extension Quotes {
	init?(data: Data) {
		do
		{
			let quote = try JSONDecoder().decode(Quotes.self, from: data)
			self = quote
		}catch let error
		{
			//pt-br necessário, devido à alguns JSON's estarem vindo com nós pendentes.
			let me = try! JSONDecoder().decode(Quotes
												.self, from: data)
			var quotes = Quotes.init(quoteID: self.quoteID, quote: quote, author: author, series: series)
			self = quotes
		}
		
	}
}
