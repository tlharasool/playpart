//
//  UISelectionViewController.swift
//  playpart
//
//  Created by Atif Habib on 13/09/2021.
//

import UIKit
import Foundation
class UISelectionViewController: UIViewController {
    
    @IBOutlet weak var ic_check: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    let headingText = "Choose your\nsport"
    var tapStatusDict : [Int : Bool] = [ 1 : false, 2 : false, 3 : false, 4 : false, 5 : false, 6 : false, 7 : false, 8 : false, 9 : false, 10 : false, 11 : false, 12 : false, 13 : false, 14 : false, 15 : false, 16 : false, 17 : false, 18 : false, 19 : false, 20 : false, 21 : false, 22 : false, 23 : false, 24 : false, 25 : false, 26 : false, 27 : false, 28 : false]
    var checkStatus : [Int : Bool] = [ 1 : false, 2 : false, 3 : false, 4 : false, 5 : false, 6 : false, 7 : false, 8 : false, 9 : false, 10 : false, 11 : false, 12 : false, 13 : false, 14 : false, 15 : false, 16 : false, 17 : false, 18 : false, 19 : false, 20 : false, 21 : false, 22 : false, 23 : false, 24 : false, 25 : false, 26 : false, 27 : false, 28 : false]
    
    @IBOutlet weak var headingLbl : UILabel!{
        didSet{
            
        }
    }
    
    @IBOutlet weak var selectImage: UIImageView!
    @IBOutlet weak var americanFootball: UIImageView!
    @IBOutlet weak var golf:UIImageView!
    @IBOutlet weak var rugbyImg:UIImageView!
    @IBOutlet weak var fieldHockeyImg:UIImageView!
    @IBOutlet weak var snowBoardImg:UIImageView!
    @IBOutlet weak var surfngImg:UIImageView!
    @IBOutlet weak var padelImg:UIImageView!
    @IBOutlet weak var canoeingImg:UIImageView!
    @IBOutlet weak var mountainBikeImg:UIImageView!
    @IBOutlet weak var wakeBoardingImg:UIImageView!
    @IBOutlet weak var handBallImg:UIImageView!
    @IBOutlet weak var esportImg:UIImageView!
    @IBOutlet weak var baseBallImg:UIImageView!
    //Mark:- Row2
    @IBOutlet weak var basketBallmg:UIImageView!
    @IBOutlet weak var volleyBallImg:UIImageView!
    @IBOutlet weak var cyclyingImg:UIImageView!
    @IBOutlet weak var billiardsImg:UIImageView!
    @IBOutlet weak var motorbikeImg:UIImageView!
    @IBOutlet weak var skiingImg:UIImageView!
    @IBOutlet weak var beachVolleyImg:UIImageView!
    @IBOutlet weak var waterpoloImg:UIImageView!
    @IBOutlet weak var climbingImg:UIImageView!
    @IBOutlet weak var skateboardinglmg:UIImageView!
    @IBOutlet weak var squashImg:UIImageView!
    @IBOutlet weak var cricketImg:UIImageView!
    @IBOutlet weak var baseJumping:UIImageView!
    @IBOutlet weak var nicheSportlmg:UIImageView!
    
    //MARK:- ic Check image
    @IBOutlet weak var checkImg1: UIImageView!
    @IBOutlet weak var checkImg2: UIImageView!
    @IBOutlet weak var checkImg3: UIImageView!
    @IBOutlet weak var checkImg4: UIImageView!
    @IBOutlet weak var checkImg5: UIImageView!
    @IBOutlet weak var checkImg6: UIImageView!
    @IBOutlet weak var checkImg7: UIImageView!
    @IBOutlet weak var checkImg8: UIImageView!
    @IBOutlet weak var checkImg9: UIImageView!
    @IBOutlet weak var checkImg10: UIImageView!
    @IBOutlet weak var checkImg11: UIImageView!
    @IBOutlet weak var checkImg12: UIImageView!
    @IBOutlet weak var checkImg13: UIImageView!
    @IBOutlet weak var checkImg14: UIImageView!
    @IBOutlet weak var checkImg15: UIImageView!
    @IBOutlet weak var checkImg16: UIImageView!
    @IBOutlet weak var checkImg17: UIImageView!
    @IBOutlet weak var checkImg18: UIImageView!
    @IBOutlet weak var checkImg19: UIImageView!
    @IBOutlet weak var checkImg20: UIImageView!
    @IBOutlet weak var checkImg21: UIImageView!
    @IBOutlet weak var checkImg22: UIImageView!
    @IBOutlet weak var checkImg23: UIImageView!
    @IBOutlet weak var checkImg24: UIImageView!
    @IBOutlet weak var checkImg25: UIImageView!
    @IBOutlet weak var checkImg26: UIImageView!
    @IBOutlet weak var checkImg27: UIImageView!
    @IBOutlet weak var checkImg28: UIImageView!
    var checkImgStatus:[UIImageView] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headingLbl.text = headingText
        headingLbl.textColor = AppColor.primaryColor
        selectImage.isUserInteractionEnabled = true
        let tapped = UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage(tapGestureRecognizer:)))
        let americanballImgtab = UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage(tapGestureRecognizer:)))
        let golfImgtab =  UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage(tapGestureRecognizer:)))
        let rugbyImgTab =  UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage(tapGestureRecognizer:)))
        let fieldHockeyImgTab =  UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage(tapGestureRecognizer:)))
        let snowBoardImgTab =  UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage(tapGestureRecognizer:)))
        let surfingImgTab =  UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage(tapGestureRecognizer:)))
        let padelImgTab =  UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage(tapGestureRecognizer:)))
        let canoeingImgTab =  UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage(tapGestureRecognizer:)))
        let mountainBikeImgTab =  UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage(tapGestureRecognizer:)))
        let wakeBoardingImgTab =  UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage(tapGestureRecognizer:)))
        let handBallImgtab =  UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage(tapGestureRecognizer:)))
        let esportImgTab =  UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage(tapGestureRecognizer:)))
        let baseBallImgtab =  UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage(tapGestureRecognizer:)))
        let basketBallmgTab =  UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage(tapGestureRecognizer:)))
        let volleyBallImgTab =  UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage(tapGestureRecognizer:)))
        let cyclyingImgTab =  UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage(tapGestureRecognizer:)))
        let billiardsImgTab =  UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage(tapGestureRecognizer:)))
        let motorbikeImgTab =  UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage(tapGestureRecognizer:)))
        let skiingImgTab =  UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage(tapGestureRecognizer:)))
        let beachVolleyImgTab =  UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage(tapGestureRecognizer:)))
        let waterpoloImgTab =  UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage(tapGestureRecognizer:)))
        let climbingImgTab =  UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage(tapGestureRecognizer:)))
        let skateboardinglmgTab =  UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage(tapGestureRecognizer:)))
        let squashImgTab =  UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage(tapGestureRecognizer:)))
        let cricketImgTab =  UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage(tapGestureRecognizer:)))
        let baseJumpingTab =  UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage(tapGestureRecognizer:)))
        let nicheSportlmgTab =  UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage(tapGestureRecognizer:)))
        // selectImage.addGestureRecognizer(tapOnImage)
        
        [selectImage,
         americanFootball,
         golf,
         rugbyImg,
         fieldHockeyImg,
         snowBoardImg,
         surfngImg,
         padelImg,
         canoeingImg,
         mountainBikeImg,
         wakeBoardingImg,
         handBallImg,
         esportImg,
         baseBallImg,
         basketBallmg,
         volleyBallImg,
         cyclyingImg,
         billiardsImg,
         motorbikeImg,
         skiingImg,
         beachVolleyImg,
         waterpoloImg,
         climbingImg,
         skateboardinglmg,
         squashImg,
         cricketImg,
         baseJumping,
         nicheSportlmg].forEach { img in
            print("The image adding the function",img?.tag)
            guard let img = img else{return}
            img.isUserInteractionEnabled = true
            let imgTag = img.tag
            switch imgTag{
            case 1:
                img.addGestureRecognizer(tapped)
            case 2:
                img.addGestureRecognizer(americanballImgtab)
            case 3:
                img.addGestureRecognizer(golfImgtab)
            case 4:
                img.addGestureRecognizer(rugbyImgTab)
            case 5:
                img.addGestureRecognizer(fieldHockeyImgTab)
            case 6:
                img.addGestureRecognizer(snowBoardImgTab)
            case 7:
                img.addGestureRecognizer(surfingImgTab)
            case 8:
                img.addGestureRecognizer(padelImgTab)
            case 9:
                img.addGestureRecognizer(canoeingImgTab)
            case 10:
                img.addGestureRecognizer(mountainBikeImgTab)
            case 11:
                img.addGestureRecognizer(wakeBoardingImgTab)
            case 12:
                img.addGestureRecognizer(handBallImgtab)
            case 13:
                img.addGestureRecognizer(esportImgTab)
            case 14:
                img.addGestureRecognizer(baseBallImgtab)
            case 15:
                img.addGestureRecognizer(basketBallmgTab)
            case 16:
                img.addGestureRecognizer(volleyBallImgTab)
            case 17:
                img.addGestureRecognizer(cyclyingImgTab)
            case 18:
                img.addGestureRecognizer(billiardsImgTab)
            case 19:
                img.addGestureRecognizer(motorbikeImgTab)
            case 20:
                img.addGestureRecognizer(skiingImgTab)
            case 21:
                img.addGestureRecognizer(beachVolleyImgTab)
            case 22:
                img.addGestureRecognizer(waterpoloImgTab)
            case 23:
                img.addGestureRecognizer(climbingImgTab)
            case 24:
                img.addGestureRecognizer(skateboardinglmgTab)
            case 25:
                img.addGestureRecognizer(squashImgTab)
            case 26:
                img.addGestureRecognizer(cricketImgTab)
            case 27:
                img.addGestureRecognizer(baseJumpingTab)
            case 28:
                img.addGestureRecognizer(nicheSportlmgTab)
            default:break
            }
         }
        
    }
    
    var imgcheck: UIImage!
    @objc func tapOnImage(tapGestureRecognizer: UITapGestureRecognizer){
        
        if let tapImageTag = tapGestureRecognizer.view?.tag{
            print("\n->Tag Of Image",tapGestureRecognizer.view?.tag)
            if tapStatusDict[tapImageTag] == false{
                tapStatusDict[tapImageTag] = true
                switch tapImageTag {
                case 1:
                    checkImg1.isHidden = false
                case 2:
                    checkImg2.isHidden = false
                case 3:
                    checkImg3.isHidden = false
                case 4:
                    checkImg4.isHidden = false
                case 5:
                    checkImg5.isHidden = false
                case 6:
                    checkImg6.isHidden = false
                case 7:
                    checkImg7.isHidden = false
                case 8:
                    checkImg8.isHidden = false
                case 9:
                    checkImg9.isHidden = false
                case 10:
                    checkImg10.isHidden = false
                case 11:
                    checkImg11.isHidden = false
                case 12:
                    checkImg12.isHidden = false
                case 13:
                    checkImg13.isHidden = false
                case 14:
                    checkImg14.isHidden = false
                case 15:
                    checkImg15.isHidden = false
                case 16:
                    checkImg16.isHidden = false
                case 17:
                    checkImg17.isHidden = false
                case 18:
                    checkImg18.isHidden = false
                case 19:
                    checkImg19.isHidden = false
                case 20:
                    checkImg20.isHidden = false
                case 21:
                    checkImg21.isHidden = false
                case 22:
                    checkImg22.isHidden = false
                case 23:
                    checkImg23.isHidden = false
                case 24:
                    checkImg24.isHidden = false
                case 25:
                    checkImg25.isHidden = false
                case 26:
                    checkImg26.isHidden = false
                case 27:
                    checkImg27.isHidden = false
                case 28:
                    checkImg28.isHidden = false
                    
                default:break
                }
                //ic_check.isHidden = false
            }
            else{
                tapStatusDict[tapImageTag] = false
                switch tapImageTag {
                case 1:
                    checkImg1.isHidden = true
                case 2:
                    checkImg2.isHidden = true
                case 3:
                    checkImg3.isHidden = true
                case 4:
                    checkImg4.isHidden = true
                case 5:
                    checkImg5.isHidden = true
                case 6:
                    checkImg6.isHidden = true
                case 7:
                    checkImg7.isHidden = true
                case 8:
                    checkImg8.isHidden = true
                case 9:
                    checkImg9.isHidden = true
                case 10:
                    checkImg10.isHidden = true
                case 11:
                    checkImg11.isHidden = true
                case 12:
                    checkImg12.isHidden = true
                case 13:
                    checkImg13.isHidden = true
                case 14:
                    checkImg14.isHidden = true
                case 15:
                    checkImg15.isHidden = true
                case 16:
                    checkImg16.isHidden = true
                case 17:
                    checkImg17.isHidden = true
                case 18:
                    checkImg18.isHidden = true
                case 19:
                    checkImg19.isHidden = true
                case 20:
                    checkImg20.isHidden = true
                case 21:
                    checkImg21.isHidden = true
                case 22:
                    checkImg22.isHidden = true
                case 23:
                    checkImg23.isHidden = true
                case 24:
                    checkImg24.isHidden = true
                case 25:
                    checkImg25.isHidden = true
                case 26:
                    checkImg26.isHidden = true
                case 27:
                    checkImg27.isHidden = true
                case 28:
                    checkImg28.isHidden = true
                default:break
                }
               // ic_check.isHidden = true
            }
            print(tapStatusDict[tapImageTag])
        }else{
            print("find NIL in tag")
        }
        
    }
    
    
    @IBAction func actionOnTap(_ sender : UITapGestureRecognizer){
        
        let vc = HomeTabBarController.instantiateViewController()
        CustomUserDefaults.shared.set(true, key: .isLogin)
        UIApplication.shared.setRootVC(vc)
    }
    
}

