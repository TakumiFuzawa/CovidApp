//
//  HealthCheckViewController.swift
//  CovidApp
//
//  Created by Takumi Fuzawa on 2021/03/22.
//

import UIKit
import FSCalendar

class HealthCheckViewController: UIViewController {
    
    let colors = Colors()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGroupedBackground
        //画面のスクロール
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 1000)
        view.addSubview(scrollView)
        //カレンダー表示
        let calendar = FSCalendar()
        calendar.frame = CGRect(x: 20, y: 10, width: view.frame.size.width - 40, height: 300)
        scrollView.addSubview(calendar)
        
        //ラベル
        let checkLabel = UILabel()
        checkLabel.text = "健康チェック"
        checkLabel.textColor = colors.white
        checkLabel.frame = CGRect(x: 0, y: 340, width: view.frame.size.width, height: 20)
        checkLabel.backgroundColor = colors.blue
        checkLabel.textAlignment = .center
        checkLabel.center.x = view.center.x
        scrollView.addSubview(checkLabel)
        
        //健康状態のチェックView
        let uiView1 = createView(y: 380)
        scrollView.addSubview(uiView1)
        createImage(mainView: uiView1, imageName: "thermometer")
        createLabel(mainView: uiView1, text: "37.5度以上の熱がある")
        
        let uiView2 = createView(y: 465)
        scrollView.addSubview(uiView2)
        createImage(mainView: uiView2, imageName: "sore-throat")
        createLabel(mainView: uiView2, text: "37.5度以上の熱がある")
        
        let uiView3 = createView(y: 550)
        scrollView.addSubview(uiView3)
        createImage(mainView: uiView3, imageName: "nose")
        createLabel(mainView: uiView3, text: "37.5度以上の熱がある")
        
        let uiView4 = createView(y: 635)
        scrollView.addSubview(uiView4)
        createImage(mainView: uiView4, imageName: "tongue")
        createLabel(mainView: uiView4, text: "37.5度以上の熱がある")
        
        let uiView5 = createView(y: 720)
        scrollView.addSubview(uiView5)
        createImage(mainView: uiView5, imageName: "tiredness")
        createLabel(mainView: uiView5, text: "37.5度以上の熱がある")
        
    }
    
    //viewの作成
    func createView(y: CGFloat) -> UIView {
        let uiView = UIView()
        uiView.frame = CGRect(x: 20, y: y, width: view.frame.size.width - 40, height: 70)
        uiView.backgroundColor = .white
        uiView.layer.cornerRadius = 20
        uiView.layer.shadowColor = UIColor.black.cgColor
        uiView.layer.shadowOpacity = 0.3
        uiView.layer.shadowRadius = 4
        uiView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        return uiView
    }
    
    //ラベルの追加
    func createLabel(mainView: UIView, text: String) {
        let label = UILabel()
        label.text = text
        label.frame = CGRect(x: 53, y: 15, width: 200, height: 40)
        mainView.addSubview(label)
    }

    //画像の追加
    func createImage(mainView: UIView, imageName: String) {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.frame = CGRect(x: 10, y: 15, width: 40, height: 40)
        mainView.addSubview(imageView)
    }
    

}
