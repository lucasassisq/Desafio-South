//
//  CharacterModel.swift
//  desafiosouth
//
//  Created by Lucas de Assis Siqueira on 14/03/21.
//
import Foundation

struct CharacterModel: Codable
{
	var charID: Int?
	var name, birthday: String?
	var occupation: [String]?
	var img: String?
	var status, nickname: String?
	var appearance: [Int]?
	var portrayed, category: String?

	enum CodingKeys: String, CodingKey {
		case charID = "char_id"
		case name, birthday, occupation, img, status, nickname, appearance, portrayed, category
	}
}



// MARK: Convenience initializers

extension CharacterModel {
	init?(data: Data) {
		do
		{
			var me = try JSONDecoder().decode(CharacterModel.self, from: data)
			self = me
		}catch let error
		{
			//pt-br necessário, devido à alguns JSON's estarem vindo com nós pendentes.
			let me = try! JSONDecoder().decode(CharacterModel
												.self, from: data)
			var character = CharacterModel.init(charID: charID, name: name, birthday: birthday, occupation: occupation, img: img, status: status, nickname: nickname, appearance: appearance, portrayed: portrayed, category: category)
			self = character
		}
		
	}
}

