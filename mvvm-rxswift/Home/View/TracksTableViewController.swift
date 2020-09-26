//
//  TracksTableViewController.swift
//  mvvm-rxswift
//
//  Created by CYAN on 9/26/20.
//  Copyright © 2020 Cyan Villarin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class TracksTableViewController: UIViewController {
   
   @IBOutlet private weak var tracksTableView: UITableView!
   
   public var tracks = PublishSubject<[Track]>()
   
   private let disposeBag = DisposeBag()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.tracksTableView.separatorStyle = .none
      setupBinding()
   }
   
   private func setupBinding(){
      
      tracksTableView.register(UINib(nibName: "TracksTableViewCell", bundle: nil), forCellReuseIdentifier: String(describing: TracksTableViewCell.self))
      
      tracks.bind(to: tracksTableView.rx.items(cellIdentifier: "TracksTableViewCell", cellType: TracksTableViewCell.self)) {  (row,track,cell) in
         cell.cellTrack = track
      }.disposed(by: disposeBag)
      
      tracksTableView.rx.willDisplayCell
         .subscribe(onNext: ({ (cell,indexPath) in
            cell.alpha = 0
            let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 0, 0)
            cell.layer.transform = transform
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
               cell.alpha = 1
               cell.layer.transform = CATransform3DIdentity
            }, completion: nil)
         })).disposed(by: disposeBag)
   }
}
