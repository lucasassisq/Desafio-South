//
//  PersonagensCollectionViewCell.swift
//  desafiosouth
//
//  Created by Lucas de Assis Siqueira on 14/03/21.
//

import UIKit

protocol episodiosDelegate
{
	func onClick(character : CharacterModel)
}
class PersonagensCollectionViewCell: UICollectionViewCell {
	
	
	@IBOutlet weak var personImage: UIImageView!
	@IBOutlet weak var personName: UILabel!
	@IBOutlet weak var personNickname: UILabel!
	var delegate : episodiosDelegate?
	var withBackView : Bool! {
		didSet {
			self.backViewGenrator()
		}
	}
	private lazy var backView: UIImageView = {
		let backView = UIImageView(frame: personImage.frame)
		backView.translatesAutoresizingMaskIntoConstraints = false
		self.contentView.addSubview(backView)
		NSLayoutConstraint.activate([
			backView.topAnchor.constraint(equalTo: personImage.topAnchor, constant: -10),
			backView.leadingAnchor.constraint(equalTo: personImage.leadingAnchor),
			backView.trailingAnchor.constraint(equalTo: personImage.trailingAnchor),
			backView.bottomAnchor.constraint(equalTo: personImage.bottomAnchor)
		])
		backView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
		backView.alpha = 0.5
		contentView.bringSubviewToFront(personImage)
		return backView
	}()
	public var personModel: CharacterModel! {
		didSet {
			self.personImage.loadImage(fromURL: personModel.img!)
			self.personName.text = personModel.name
			self.personNickname.text = personModel.nickname
			self.addTapGestureRecognizer{
				self.delegate?.onClick(character: self.personModel)
			}
		}
	}
	private func backViewGenrator(){
		backView.loadImage(fromURL: personModel.img!)
	}
	override func prepareForReuse() {
		personImage.image = UIImage()
		backView.image = UIImage()
	}
}
