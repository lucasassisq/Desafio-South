//
//  EpisodiosTableViewCell.swift
//  desafiosouth
//
//  Created by Lucas de Assis Siqueira on 14/03/21.
//

import UIKit
import RxSwift
import RxCocoa

class EpisodiosTableViewCell: UITableViewCell
{
	@IBOutlet weak var temporadaEpisodio : UILabel!
	@IBOutlet weak var temporadaTitulo: UILabel!
	
	private var disposeBag = DisposeBag()
	
	var delegate : episodiosDelegate?
	var episodiosViewModel = EpisodesViewModel()
	public var cellEpisodes : Episodes!
	{
		didSet
		{
			self.temporadaTitulo.text = cellEpisodes.title
			if let season = cellEpisodes.season
			{
				self.temporadaEpisodio.text = "Temporada: \(season)"
			}
			else
			{
				self.temporadaEpisodio.isHidden = true
			}
		}
	}
	
	override func awakeFromNib()
	{
		super.awakeFromNib()
		self.backgroundColor = .clear
	}
	override func prepareForReuse()
	{
		disposeBag = DisposeBag()
	}
}
