//
//  QuotesTableViewCell.swift
//  desafiosouth
//
//  Created by Lucas de Assis Siqueira on 14/03/21.
//

import UIKit

class QuotesTableViewCell: UITableViewCell {

	@IBOutlet weak var quoteLabel: UILabel!
	public var quote : Quotes! {
		didSet
		{
			quoteLabel.text = quote.quote
		}
	}
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}
	
}
