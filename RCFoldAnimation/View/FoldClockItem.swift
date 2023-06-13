//
//  FoldClockItem.swift
//  RCFoldAnimation
//
//  Created by RongCheng on 2023/4/11.
//

import UIKit



class FoldClockItem: UIView {
    // MARK: 公共 -------------------
    var value: Int = 0 {
        didSet {
            setLeftText(value: value/10)
            setRightText(value: value%10)
        }
    }
    var clockType: ClockType!
    var sequenceType: SequenceType!
    // 字体大小
    var font: UIFont? {
        didSet {
            leftLabel.font = font!
            rightLabel.font = font!
        }
    }
    // 字体颜色
    var textColor: UIColor? {
        didSet {
            leftLabel.textColor = textColor!
            rightLabel.textColor = textColor!
        }
    }
    
    // MARK: 私有 -------------------
    private var rightLabel: FoldAnimationView! // 个位数
    private var leftLabel: FoldAnimationView!  // 十位数
    private var lastRightValue: Int = -1 // 记录个位数上一次数值
    private var lastLeftValue: Int = -1 // 记录十位数上一次数值
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let w = bounds.size.width * 0.5
        let h = bounds.size.height
        leftLabel.frame = CGRect(x: 0, y: 0, width: w, height: h)
        rightLabel.frame =  CGRect(x: w, y: 0, width: w, height: h)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension FoldClockItem {
    func setupUI(){
        rightLabel = FoldAnimationView()
        addSubview(rightLabel)
        
        leftLabel = FoldAnimationView()
        addSubview(leftLabel)
    }
    
    // 十位数显示
    func setLeftText(value: Int){
        if lastLeftValue == value && lastLeftValue != -1 {
            return
        }
        lastLeftValue = value
        if sequenceType == .increase {
            let unit = clockType == .hour ? 2 : 5
            let current = value == 0 ? unit : value - 1
            leftLabel.fold(current: "\(current)", next: "\(value)")
        }else{
            let unit = clockType == .hour ? 2 : 5
            let current = value == unit ? 0 : value + 1
            leftLabel.fold(current: "\(current)", next: "\(value)")
        }
        
    }
    
    // 个位数显示
    func setRightText(value: Int){
        if lastRightValue == value && lastRightValue != -1 {
            return
        }
        lastRightValue = value
        if sequenceType == .increase {
            let unit = clockType == .hour ? 4 : 9
            let current = value == 0 ? unit : value - 1
            rightLabel.fold(current: "\(current)", next: "\(value)")
        }else{
            let unit = clockType == .hour ? 4 : 9
            let current = value == unit ? 0 : value + 1
            rightLabel.fold(current: "\(current)", next: "\(value)")
        }
    }
}
// 时钟类型，时、分、秒
enum ClockType {
    case hour,minute,second
}
// 变化次序，正时和倒时
enum SequenceType {
    case increase,reduce
}
