//
//  HomeTableViewCell.swift
//  playpart
//
//  Created by talha on 08/10/2021.
//

import UIKit

protocol HomeCellNavigationDelegate: AnyObject {
    // Navigate to Profile Page
    func navigateToProfilePage(uid: String, name: String)
}

class HomeTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    var playerView: VideoPlayerView!
    @IBOutlet weak var nameBtn: UIButton!
    @IBOutlet weak var captionLbl: UILabel!
   // @IBOutlet weak var reportbtnOutlet: UIButton!
    @IBOutlet weak var reportbtnView: UIView!
    @IBOutlet weak var reportbtnImgView: UIView!
    
    // MARK:- Reaction Buttons.
    @IBOutlet weak var worldBtnOutlet  : UIButton!{
        didSet{self.worldBtnOutlet.alpha = 0.7}
    }
    @IBOutlet weak var wheelBtnOutlet  : UIButton!{
        didSet{self.wheelBtnOutlet.alpha = 0.7}
    }
    @IBOutlet weak var heartBtnOutlet  : UIButton!{
        didSet{self.heartBtnOutlet.alpha = 0.7}
    }
    @IBOutlet weak var animalBtnOutlet : UIButton!{
        didSet{self.animalBtnOutlet.alpha = 0.7}
    }
    @IBOutlet weak var treeBtnOutlet   : UIButton!{
        didSet{self.treeBtnOutlet.alpha = 0.7}
    }
    @IBOutlet weak var pauseImgView: UIImageView!{
        didSet{
            pauseImgView.alpha = 0
        }
    }
    @IBOutlet weak var reactionSetterView: UIView!
    
    // MARK: - Variables
    private(set) var isPlaying = false
    private(set) var liked = false
    var post: VideoData?
    var reactionDict : [Int : UIButton] = [:]
    var reactionHandler : ((Int, Int)->())?
    var isVideoFinish : (()-> Void)?
    var selectedReaction : Int = 0
    weak var delegate: HomeCellNavigationDelegate?
    let randomInt = Int.random(in: 21..<40)
    
    var btnArray : [Int] = []
    //PlayPart MVP_ (20)
    // MARK: LIfecycles

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        playerView = VideoPlayerView(frame: self.contentView.frame)
        //        musicLbl.holdScrolling = true
        //        musicLbl.animationDelay = 0
        
        
        contentView.addSubview(playerView)
        contentView.sendSubviewToBack(playerView)
        reportbtnView.backgroundColor = UIColor.clear
        reportbtnView.isUserInteractionEnabled = true
        reportbtnImgView.isUserInteractionEnabled = true
        let btn1Tag = Int.random(in: 21..<40)
        let btn2Tag = Int.random(in: 21..<40)
        let btn3Tag = Int.random(in: 21..<40)
        let btn4Tag = Int.random(in: 21..<40)
        let btn5Tag = Int.random(in: 21..<40)
        
        if !(btnArray.contains(btn1Tag)){
            //ICONE AI-29
            let imgName = imgName(val: btn1Tag)
            print("The image name is here",imgName)
            worldBtnOutlet.setImage(UIImage(named: imgName), for: .normal)
        }else{
            
        }
        
        if !(btnArray.contains(btn2Tag)){
            //ICONE AI-29
            let imgName = imgName(val: btn2Tag)
            print("The image name is here",imgName)
            wheelBtnOutlet.setImage(UIImage(named: imgName), for: .normal)
        }else{}
        
        if !(btnArray.contains(btn3Tag)){
            //ICONE AI-29
            let imgName = imgName(val: btn3Tag)
            print("The image name is here",imgName)
            heartBtnOutlet.setImage(UIImage(named: imgName), for: .normal)
        }else{}
        
        if !(btnArray.contains(btn4Tag)){
            //ICONE AI-29
            let imgName = imgName(val: btn4Tag)
            print("The image name is here",imgName)
            animalBtnOutlet.setImage(UIImage(named: imgName), for: .normal)
        }else{
            
        }
        
        if !(btnArray.contains(btn5Tag)){
            //ICONE AI-29
            let imgName = imgName(val: btn5Tag)
            print("The image name is here",imgName)
            treeBtnOutlet.setImage(UIImage(named: imgName), for: .normal)
        }else{
            
        }

       // treeBtnOutlet.setImage(img, for: .normal)
        let pauseGesture = UITapGestureRecognizer(target: self, action: #selector(handlePause))
        self.contentView.addGestureRecognizer(pauseGesture)
        
        //        let likeDoubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLikeGesture(sender:)))
        //        likeDoubleTapGesture.numberOfTapsRequired = 2
        //        self.contentView.addGestureRecognizer(likeDoubleTapGesture)
        //
        //        pauseGesture.require(toFail: likeDoubleTapGesture)
        
        DispatchQueue.main.async {
         //   self.reportbtnOutlet.setTitle("", for: .normal)
            //self.button.backgroundColor = .red
        }
    }
    
    
    func imgName(val : Int)-> String{
        let imgName  = "ICONE AI-\(val)"
        return imgName
    }
    

    @IBAction func actionOnWorld(_ sender: Any) {
        // print("Tag is \(#function)",self.tag)
        callReactionCompletion(1, tag)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        reactionDict = [1 : worldBtnOutlet, 2 : wheelBtnOutlet ,3 : heartBtnOutlet,4 : animalBtnOutlet, 5 : treeBtnOutlet]
        playerView.cancelAllLoadingRequest()
        resetViewsForReuse()
    
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
       // reportbtnOutlet.titleLabel?.text = ""
    }
    
    
    @IBAction func actionOnWheel(_ sender: Any) {
        print("Tag is \(#function)",self.tag)
        callReactionCompletion(2, tag)
    }
    
    @IBAction func actionOnHeart(_ sender: Any) {
        print("Tag is \(#function)",self.tag)
        callReactionCompletion(3, tag)
    }
    
    @IBAction func actionOnAnimal(_ sender: Any) {
        print("Tag is \(#function)",self.tag)
        callReactionCompletion(4, tag)
    }
    
    @IBAction func actionOnTree(_ sender: Any) {
        print("Tag is \(#function)",self.tag)
        callReactionCompletion(5, tag)
    }
    
    
    func hideReactions(){
        self.worldBtnOutlet.alpha = 0
        self.treeBtnOutlet.alpha = 0
        self.animalBtnOutlet.alpha = 0
        self.heartBtnOutlet.alpha = 0
       // self.reportbtnOutlet.alpha = 0
        self.reactionSetterView.alpha = 0
    }
    func configure(post: VideoData){
        self.post = post
        if let rection  = post.reaction, rection.reaction != 0{
            print("Reactions is not null")
            self.selectedReaction = rection.reaction
           // updateReactionOnBtn(rection.reaction)
            self.hideReactions()
            self.reactionSetterView.alpha = 0
        }else{
            
            print("Reactions is  null")
            self.selectedReaction = 0
            self.resetAllRaeactions()
            self.reactionSetterView.alpha = 1
        }
        
        self.captionLbl.text = post.description ?? ""
        let cellSize = self.contentView.frame
        let url = URL(string: post.result_video_url)!
        playerView.configure(url: url, fileExtension: "mov", size: (Int(cellSize.width), Int(cellSize.height)))
        
        if let username = post.username{
            let fullText = "@ \(username)"
            nameBtn.setTitle(fullText, for: .normal)
        }
        nameBtn.isUserInteractionEnabled = false
        videoFinishedCompletion()
    }
    
    func videoFinishedCompletion(){
        playerView.isVideoFinish = {[weak self] in
            self?.isVideoFinish?()
        }
    }
    
    func updateReactionOnBtn(_ reaction : Int){
        
        print("\n\n")
        print("\(#function)",selectedReaction)
        print("--\n")
        
        switch reaction{
        case 1:
            if selectedReaction == 0{
                self.worldBtnOutlet.alpha = 1
            }else{
                resetReactionBtn(reaction: self.selectedReaction)
                self.worldBtnOutlet.alpha = 1
            }
        case 2:
            if selectedReaction == 0{
                self.wheelBtnOutlet.alpha = 1
            }else{
                resetReactionBtn(reaction: self.selectedReaction)
                self.wheelBtnOutlet.alpha = 1
            }
            
        case 3:
            if selectedReaction == 0{
                self.heartBtnOutlet.alpha = 1
            }else{
                resetReactionBtn(reaction: self.selectedReaction)
                self.heartBtnOutlet.alpha = 1
            }
            
        case 4:
            if selectedReaction == 0{
                self.animalBtnOutlet.alpha = 1
            }else{
                resetReactionBtn(reaction: self.selectedReaction)
                self.animalBtnOutlet.alpha = 1
            }
            
        case 5:
            
            print("reaction",reaction)
            if selectedReaction == 0{
                self.treeBtnOutlet.alpha = 1
            }else{
                resetReactionBtn(reaction: self.selectedReaction)
                self.treeBtnOutlet.alpha = 1
            }
            
        default:
            break
        }
        
        selectedReaction = reaction
    }
    
    
    func resetAllRaeactions(){
        self.worldBtnOutlet.alpha = 0.7
        self.wheelBtnOutlet.alpha = 0.7
        self.heartBtnOutlet.alpha = 0.7
        self.animalBtnOutlet.alpha = 0.7
        self.treeBtnOutlet.alpha = 0.7
    }
    
    func resetReactionBtn(reaction : Int){
        
        switch reaction{
        case 1:
            self.worldBtnOutlet.alpha = 0.7
        case 2:
            self.wheelBtnOutlet.alpha = 0.7
        case 3:
            self.heartBtnOutlet.alpha = 0.7
        case 4:
            self.animalBtnOutlet.alpha = 0.7
        case 5:
            self.treeBtnOutlet.alpha = 0.7
        default:
            break
        }
        
    }
    
    private func callReactionCompletion(_ reaction : Int,_ tag : Int){
        if let comp = reactionHandler{
            comp(reaction,tag)
        }
    }
    func replay(){
        if !isPlaying {
            playerView.replay()
            play()
        }
    }
    

    
    func play() {
        if !isPlaying {
            playerView.play()
            // musicLbl.holdScrolling = false
            isPlaying = true
        }
    }
    
    func pause(){
        if isPlaying {
            playerView.pause()
            // musicLbl.holdScrolling = true
            isPlaying = false
        }
    }
    
    @objc func handlePause(){
        if isPlaying {
            // Pause video and show pause sign
            UIView.animate(withDuration: 0.075, delay: 0, options: .curveEaseIn, animations: { [weak self] in
                guard let self = self else { return }
                self.pauseImgView.alpha = 0.35
                self.pauseImgView.transform = CGAffineTransform.init(scaleX: 0.45, y: 0.45)
            }, completion: { [weak self] _ in
                self?.pause()
            })
        } else {
            // Start video and remove pause sign
            UIView.animate(withDuration: 0.075, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
                guard let self = self else { return }
                self.pauseImgView.alpha = 0
            }, completion: { [weak self] _ in
                self?.play()
                self?.pauseImgView.transform = .identity
            })
        }
    }
    
    func resetViewsForReuse(){
        
        pauseImgView.alpha = 0
    }
    
    
    // MARK: - Actions
    // Like Video Actions
    @IBAction func like(_ sender: Any) {
        if !liked {
            likeVideo()
        } else {
            liked = false
            
        }
        
    }
    
    @objc func likeVideo(){
        if !liked {
            liked = true
        }
    }
    
    // Heart Animation with random angle
    @objc func handleLikeGesture(sender: UITapGestureRecognizer){
        let location = sender.location(in: self)
        let heartView = UIImageView(image: #imageLiteral(resourceName: "Group 451"))
        heartView.tintColor = .red
        let width : CGFloat = 110
        heartView.contentMode = .scaleAspectFit
        heartView.frame = CGRect(x: location.x - width / 2, y: location.y - width / 2, width: width, height: width)
        heartView.transform = CGAffineTransform(rotationAngle: CGFloat.random(in: -CGFloat.pi * 0.2...CGFloat.pi * 0.2))
        self.contentView.addSubview(heartView)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 3, options: [.curveEaseInOut], animations: {
            heartView.transform = heartView.transform.scaledBy(x: 0.85, y: 0.85)
        }, completion: { _ in
            UIView.animate(withDuration: 0.4, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 3, options: [.curveEaseInOut], animations: {
                heartView.transform = heartView.transform.scaledBy(x: 2.3, y: 2.3)
                heartView.alpha = 0
            }, completion: { _ in
                heartView.removeFromSuperview()
            })
        })
        likeVideo()
    }

    @IBAction func comment(_ sender: Any) {}

    @IBAction func share(_ sender: Any) {}
    
    @objc func navigateToProfilePage(){
        guard let post = post else { return }
        
    }
    
    
}


//        nameBtn.setTitle("@" + post.autherName, for: .normal)
//        nameBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
//        musicLbl.text = post.music + "   " + post.music + "   " + post.music + "   "// Long enough to enable scrolling
//        captionLbl.text = post.caption
//        likeCountLbl.text = post.likeCount.shorten()
//        //commentCountLbl.text = post.comments?.count.shorten()
//        shareCountLbl.text = post.shareCount.shorten()
