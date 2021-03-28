//
//  HealthCheckViewController.swift
//  CovidApp
//
//  Created by Takumi Fuzawa on 2021/03/22.
//

import UIKit
import FSCalendar
import CalculateCalendarLogic


class HealthCheckViewController: UIViewController {
    
    let colors = Colors()
    var point = 0
    var today = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGroupedBackground
        today = dateFormatter(day: Date())
        
        //画面のスクロール
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 950)
        view.addSubview(scrollView)
        //カレンダー表示
        let calendar = FSCalendar()
        calendar.frame = CGRect(x: 20, y: 10, width: view.frame.size.width - 40, height: 300)
        scrollView.addSubview(calendar)
        calendar.delegate = self
        calendar.dataSource = self
        
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
        createSwitch(mainView: uiView1, action: #selector(switchAction))
        
        let uiView2 = createView(y: 465)
        scrollView.addSubview(uiView2)
        createImage(mainView: uiView2, imageName: "sore-throat")
        createLabel(mainView: uiView2, text: "喉が痛い")
        createSwitch(mainView: uiView2, action: #selector(switchAction))
        
        let uiView3 = createView(y: 550)
        scrollView.addSubview(uiView3)
        createImage(mainView: uiView3, imageName: "nose")
        createLabel(mainView: uiView3, text: "匂いを感じにくい")
        createSwitch(mainView: uiView3, action: #selector(switchAction))
        
        let uiView4 = createView(y: 635)
        scrollView.addSubview(uiView4)
        createImage(mainView: uiView4, imageName: "tongue")
        createLabel(mainView: uiView4, text: "味覚に支障あり")
        createSwitch(mainView: uiView4, action: #selector(switchAction))
        
        let uiView5 = createView(y: 720)
        scrollView.addSubview(uiView5)
        createImage(mainView: uiView5, imageName: "tiredness")
        createLabel(mainView: uiView5, text: "だるさがある")
        createSwitch(mainView: uiView5, action: #selector(switchAction))
        
        //診断完了ボタン
        let resultButton = UIButton(type: .system)
        resultButton.frame = CGRect(x: 0, y: 830, width: 200, height: 40)
        resultButton.center.x = scrollView.center.x
        resultButton.layer.cornerRadius = 5
        resultButton.backgroundColor = colors.blue
        resultButton.setTitle("診断完了", for: .normal)
        resultButton.setTitleColor(colors.white, for: .normal)
        resultButton.titleLabel?.font = .systemFont(ofSize: 20)
        resultButton.addTarget(self, action: #selector(resultButtonAction), for: [.touchUpInside, .touchUpOutside])
        scrollView.addSubview(resultButton)
        
        if UserDefaults.standard.string(forKey: today) != nil {
            resultButton.isEnabled = false
            resultButton.setTitle("診断済み", for: .normal)
            resultButton.backgroundColor = .white
            resultButton.setTitleColor(.gray, for: .normal)
        }
        
    }
    //resultButtonのアクション
    @objc func resultButtonAction() {
        let alert = UIAlertController(title: "診断を完了しますか？", message: "診断は1日一回までです", preferredStyle: .actionSheet)
        let yesAction = UIAlertAction(title: "完了", style: .default, handler: { action in
            var resultTitel = ""
            var resultMessage = ""
            if self.point >= 4 {
                resultTitel = "高"
                resultMessage = "感染している可能性が\n比較的高いです。\nPCR検査をしましょう。"
            } else if self.point >= 2 {
                resultTitel = "中"
                resultMessage = "やや感染してる可能性が\nあります。外出は控えましょう。"
            } else {
                resultTitel = "低"
                resultMessage = "感染している可能性は\n今のところ低いです。\n今後も気おつけましょう。"
            }
            let alert = UIAlertController(title: "感染している可能性「\(resultTitel)」", message: resultMessage, preferredStyle: .alert)
            self.present(alert, animated: true, completion:  {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.dismiss(animated: true, completion: nil)
                }
            })
            //
            UserDefaults.standard.set(resultTitel, forKey: self.today)
        })
        let noAction = UIAlertAction(title: "キャンセル", style: .destructive, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func switchAction(sender: UISwitch) {
        if sender.isOn {
            point += 1
        } else {
            point -= 1
        }
        print("Point:\(point)")
    }
    
    //SwitchButtonの追加
    func createSwitch(mainView: UIView, action: Selector) {
        let uiSwitch = UISwitch()
        uiSwitch.frame = CGRect(x: mainView.frame.size.width - 60, y: 20, width: 50, height: 30)
        uiSwitch.addTarget(self, action: action, for: .valueChanged)
        mainView.addSubview(uiSwitch)
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

// 祝日判定を行い結果を返すメソッド(True:祝日)
func judgeHoliday(_ date : Date) -> Bool {
    //祝日判定用のカレンダークラスのインスタンス
    let calendar = Calendar(identifier: .gregorian)
    // 祝日判定を行う日にちの年、月、日を取得
    let year = calendar.component(.year, from: date)
    let month = calendar.component(.month, from: date)
    let day = calendar.component(.day, from: date)
    // CalculateCalendarLogic()：祝日判定のインスタンスの生成
    let holiday = CalculateCalendarLogic()
    let judgeHoliday = holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    return judgeHoliday
}

//曜日判定(日曜日:1 〜 土曜日:7)
func judgeWeekday(_ date: Date) -> Int{
    let calendar = Calendar(identifier: .gregorian)
    return calendar.component(.weekday, from: date)
}

//MARK: - FSCalendar delegate
extension HealthCheckViewController: FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        if let result = UserDefaults.standard.string(forKey: dateFormatter(day: date)) {
            return result
        }
        return ""
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, subtitleDefaultColorFor date: Date) -> UIColor? {
        return .init(red: 0, green: 0, blue: 0, alpha: 0.7)
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        return .clear
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderDefaultColorFor date: Date) -> UIColor? {
        if dateFormatter(day: date) == today {
            return colors.bluePurple
        }
        return .clear
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderRadiusFor date: Date) -> CGFloat {
        return 0.5
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        if judgeWeekday(date) == 1 {
            return UIColor(red: 150/255, green: 30/255, blue: 0/255, alpha: 0.9)
        } else if judgeWeekday(date) == 7 {
            return UIColor(red: 0/255, green: 30/255, blue: 150/255, alpha: 0.9)
        }
        if judgeHoliday(date) {
            return UIColor(red: 150/255, green: 30/255, blue: 0/255, alpha: 0.9)
        }
        return colors.black
    }
    
    func dateFormatter(day: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: day)
    }
}
