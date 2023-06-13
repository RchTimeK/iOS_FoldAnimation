//
//  FoldClockView.swift
//  RCFoldAnimation
//
//  Created by RongCheng on 2023/4/11.
//

import UIKit

class FoldClockView: UIView {

    var duration: Int = 0 {
        didSet {
            hourItem.value = duration / 3600 % 24
            minuteItem.value = duration / 60 % 60
            secondItem.value = duration % 60
        }
    }
    var sequenceType: SequenceType = .increase {
        didSet {
            hourItem.sequenceType = sequenceType
            minuteItem.sequenceType = sequenceType
            secondItem.sequenceType = sequenceType
        }
    }
    var dateComponent: DateComponents? {
        didSet {
            hourItem.value = dateComponent!.hour ?? 0
            minuteItem.value = dateComponent!.minute ?? 0
            secondItem.value = dateComponent!.second ?? 0
        }
    }
    
    private var hourItem: FoldClockItem!
    private var minuteItem: FoldClockItem!
    private var secondItem: FoldClockItem!
    private var leftColon: UILabel!
    private var rightColon: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let w = (bounds.size.width - 30) / 3
        let h = bounds.size.height
        hourItem.frame = CGRect(x: 0, y: 0, width: w, height: h)
        leftColon.frame = CGRect(x: w, y: 0, width: 15, height: h)
        minuteItem.frame = CGRect(x: w+15, y: 0, width: w, height: h)
        rightColon.frame = CGRect(x: 2*w+15, y: 0, width: 15, height: h)
        secondItem.frame = CGRect(x: (w+15)*2, y: 0, width: w, height: h)
        
    }
}

private extension FoldClockView {
    func setupUI(){
        hourItem = FoldClockItem()
        hourItem.clockType = .hour
        hourItem.sequenceType = sequenceType
        hourItem.font = UIFont.boldSystemFont(ofSize: 70)
        hourItem.textColor = .white
        hourItem.layer.masksToBounds = true
        hourItem.layer.cornerRadius = 10
        addSubview(hourItem)
        
        minuteItem = FoldClockItem()
        minuteItem.clockType = .minute
        minuteItem.sequenceType = sequenceType
        minuteItem.font = UIFont.boldSystemFont(ofSize: 70)
        minuteItem.textColor = .white
        minuteItem.layer.masksToBounds = true
        minuteItem.layer.cornerRadius = 10
        addSubview(minuteItem)
        
        secondItem = FoldClockItem()
        secondItem.clockType = .second
        secondItem.sequenceType = sequenceType
        secondItem.font = UIFont.boldSystemFont(ofSize: 70)
        secondItem.textColor = .white
        secondItem.layer.masksToBounds = true
        secondItem.layer.cornerRadius = 10
        addSubview(secondItem)
        
        // :
        leftColon = setupColon()
        rightColon = setupColon()
        
    }
    
    func setupColon() -> UILabel {
        let label = UILabel()
        label.text = ":"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 50)
        addSubview(label)
        return label
    }
}
