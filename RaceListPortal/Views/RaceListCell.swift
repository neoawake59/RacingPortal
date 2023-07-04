//
//  RaceListCell.swift
//  RaceListPortal
//
//  Created by Nishant Bhardwaj on 29/6/2023.
//

import UIKit

protocol TimerFineshDelegate:AnyObject {
    func countdownHasFinished(atIndex index: String);
}

class RaceListCell: UITableViewCell {
    
    @IBOutlet weak var racemage: UIImageView!
    @IBOutlet weak var raceNameLabel: UILabel!
    @IBOutlet weak var raceTimeLabel: UILabel!
    var timer: Timer?
    var countdownCompleteDelegate:TimerFineshDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        raceNameLabel.textColor = .darkGray

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(withCountdownTimer countdownTimer: ( index: String,
                                                            createdAt: TimeInterval,
                                                            duration: TimeInterval)) {
        let timeRemaining = self.calculateTimeRemaining(countdownTimer:
                                                            countdownTimer)
        self.raceTimeLabel.text = "\(timeRemaining.timeRemainingFormatted())"
        if self.timer == nil {
            DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats:
                                                true) { timer in
                let newTime = self.calculateTimeRemaining(countdownTimer:
                                                            countdownTimer)
                if newTime <= 0 {
                    self.timer?.invalidate()
                    self.timer = nil
                    if ((self.countdownCompleteDelegate?.countdownHasFinished(atIndex:
                                                                                countdownTimer.index)) != nil){
                        self.countdownCompleteDelegate?.countdownHasFinished(atIndex:
                                                                                countdownTimer.index)
                    }
                    
                    
                } else {
                    self.raceTimeLabel.text = newTime.timeRemainingFormatted()
                }
            }
        }
        }
    }

    func calculateTimeRemaining(countdownTimer:(index: String,
                                                createdAt: TimeInterval,
                                                duration: TimeInterval))
    -> Double {
    return Double((countdownTimer.createdAt + countdownTimer.duration) - Date().timeIntervalSince1970)
    }
    
    override func prepareForReuse() {
        self.timer?.invalidate()
        self.timer = nil
    }
}

extension Double{
    func timeRemainingFormatted() -> String {
        let duration = TimeInterval(self)
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [ .hour,.minute, .second ]
        formatter.zeroFormattingBehavior = [.dropLeading]
    
        return formatter.string(from: duration) ?? ""
    }
}
