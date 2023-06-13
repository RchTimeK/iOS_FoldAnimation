//
//  ViewController.swift
//  RCFoldAnimation
//
//  Created by RongCheng on 2023/4/11.
//

import UIKit

class ViewController: UIViewController {

    var count: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let w = view.bounds.size.width
        
        // 倒计数
        let countFoldView = FoldAnimationView(frame: CGRectMake((w-100)*0.5, 100, 100, 120))
        countFoldView.backgroundColor = .gray
        countFoldView.textColor = .white
        countFoldView.font = UIFont.boldSystemFont(ofSize: 70)
        countFoldView.layer.masksToBounds = true
        countFoldView.layer.cornerRadius = 10
        view.addSubview(countFoldView)
        
        
        countFoldView.fold(current: "\(self.count)", next: "\(self.count-1)")
        

        // 倒计时
        let countDownFCV = FoldClockView(frame: CGRect(x: 20, y: 300, width: w-40, height: 100))
        countDownFCV.sequenceType = .reduce
        view.addSubview(countDownFCV)

        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        // 倒计时截止时间
        let endDate = df.date(from: "2023-06-13 18:00:00")!
        
        
        // 时间
        let dateFCV = FoldClockView(frame: CGRect(x: 20, y: 500, width: w-40, height: 100))
        dateFCV.sequenceType = .increase
        view.addSubview(dateFCV)
        
        let calendar: Calendar = Calendar.current
        
        // 简单的定时器，精准应使用GCD
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            countFoldView.fold(current: "\(self!.count)", next: "\(self!.count-1)")
            self!.count -= 1

            // 当前时间
            let nowDate = Date()
            // 相差秒数
            let duration: TimeInterval = ceil(endDate.timeIntervalSince1970 - nowDate.timeIntervalSince1970)
            // 更新
            countDownFCV.duration = Int(duration)

            let dateComponent = calendar.dateComponents([.hour,.minute,.second], from: Date.now)
            dateFCV.dateComponent = dateComponent
        }
    }
}

