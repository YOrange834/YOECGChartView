//
//  SRealTimeViewController.swift
//  ECGChartView
//
//  Created by HOrange on 2021/6/23.
//

import UIKit

class SRealTimeViewController: UIViewController {

    var par:YOECGParamter!
    
    var ecg: YOECGChartView!
    
    var time: Timer?
    
    var dataArr: NSArray!
    
    var  number = 0
    
    @objc var isOnly: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "实时心电图Swift版本"
        
        let plistPath = Bundle.main.path(forResource: "Test", ofType: "plist")
        dataArr = NSArray(contentsOfFile: plistPath!)
        ecg = YOECGChartView(frame: CGRect(x: 010, y: 88, width: UIScreen.main.bounds.size.width - 20, height: 400))
        
        ecg.standard.sampleFrequency = 500
        par = ecg.standard;
        
        ecg.refreshSubViewFrame()
        
        view.addSubview(ecg)
        
        ecg.reloadGridView()
        
        configData()
        
        // Do any additional setup after loading the view.
    }
    
    
    func configData() {
        if time != nil {
            time?.invalidate()
            time = nil
        }
        time = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(refreshMap), userInfo: nil, repeats: true)
    }

    
    @objc func refreshMap(){
        let poin = Float(par.sampleFrequency) / (1.0 / 0.05)
        let point = Int(poin)
        if dataArr.count / point > number {
            var arr: Array<Any> = []
            for index in 0..<point {
                arr.append(dataArr[number * point + index])
            }
            ecg.drawRealTimeECGLine(arr, twoLine: isOnly)
            number += 1
        }else{
            time?.invalidate()
            time = nil
        }
    }

}
