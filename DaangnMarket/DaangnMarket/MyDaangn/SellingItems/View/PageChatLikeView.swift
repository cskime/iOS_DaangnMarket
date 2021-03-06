//
//  PageChatLikeView.swift
//  DaangnMarket
//
//  Created by JinGyung Kim on 2020/04/13.
//  Copyright © 2020 Jisng. All rights reserved.
//

import UIKit

class PageChatLikeView: UIView {
  // MARK: Views
  
  private let storyBubbleImage = UIImageView().then {
    $0.image = UIImage(systemName: "bubble.left.and.bubble.right")
    $0.contentMode = .scaleAspectFit
    $0.clipsToBounds = true
    $0.tintColor = UIColor(named: ColorReference.subText.rawValue)
  }
  private let numberOfChat = UILabel().then {
    $0.textColor = UIColor(named: ColorReference.subText.rawValue)
  }
  private let heartMark = UIImageView().then {
    $0.image = UIImage(systemName: "heart")
    $0.contentMode = .scaleAspectFit
    $0.clipsToBounds = true
    $0.tintColor = UIColor(named: ColorReference.subText.rawValue)
  }
  private let numberOfLike = UILabel().then {
    $0.textColor = UIColor(named: ColorReference.subText.rawValue)
  }
  
  // MARK: Initialize
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupUI() {
    setupAttributes()
    setupConstraints()
  }
  
  func setupAttributes() {
    numberOfChat.text = "1"
    numberOfLike.text = "2"
  }
  
  func setupConstraints() {
        let spacing: CGFloat = 16
    let markSize: CGFloat = 20
    
    self.storyBubbleImage.then { self.addSubview($0) }
      .snp.makeConstraints {
        $0.top.leading.equalToSuperview()
        $0.width.height.equalTo(markSize)
        $0.bottom.equalToSuperview()
    }
    self.numberOfChat.then { self.addSubview($0) }
        .snp.makeConstraints {
          $0.top.equalTo(storyBubbleImage)
          $0.leading.equalTo(storyBubbleImage.snp.trailing).offset(spacing / 2)
      }
    self.heartMark.then { self.addSubview($0) }
      .snp.makeConstraints {
        $0.top.equalTo(numberOfChat)
        $0.leading.equalTo(numberOfChat.snp.trailing).offset(spacing / 2)
        $0.width.height.equalTo(markSize)
    }
    self.numberOfLike.then { self.addSubview($0) }
      .snp.makeConstraints {
        $0.top.equalTo(heartMark)
        $0.leading.equalTo(heartMark.snp.trailing).offset(spacing / 2)
        $0.trailing.equalToSuperview()
    }
  }
}
