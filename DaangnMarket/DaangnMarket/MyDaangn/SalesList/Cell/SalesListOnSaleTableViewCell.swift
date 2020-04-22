//
//  SalesListOnSaleTableViewCell.swift
//  DaangnMarket
//
//  Created by JinGyung Kim on 2020/04/23.
//  Copyright © 2020 Jisng. All rights reserved.
//

import UIKit

protocol SalesListOnSaleTVCDelegate: class {
  func onSaleOption()
  func endOfSalePage()
}

class SalesListOnSaleTableViewCell: UITableViewCell {
  weak var delegate: SalesListOnSaleTVCDelegate?
  
  // MARK: Views
  
  private let backView = UIView().then {
    $0.backgroundColor = .white
  }
  private let itemContentView = SalesListContentView()
  private let optionButton = UIButton().then {
    $0.setImage(UIImage(named: "menu"), for: .normal)
  }
  private let verLine = UIView().then {
    $0.backgroundColor = UIColor(named: ColorReference.borderLine.rawValue)
  }
  private let stateButton = UIButton().then {
    $0.setTitleColor(.black, for: .normal)
    $0.titleLabel?.font = UIFont.systemFont(ofSize: 13)
  }
  private let endOfSalesButton = UIButton().then {
    $0.setTitle("거래완료", for: .normal)
    $0.setTitleColor(.black, for: .normal)
    $0.titleLabel?.font = UIFont.systemFont(ofSize: 13)
  }
  private let horLine = UIView().then {
    $0.backgroundColor = UIColor(named: ColorReference.borderLine.rawValue)
  }
  
  // MARK: Properties
  
  let spacing: CGFloat = 16
  let optionButtonSize: CGFloat = 20
  let bottomButtonHeight: CGFloat = 40
  let viewWidth = UIScreen.main.bounds.width
  let numberFormatter = NumberFormatter()
  
  // MARK: Initialize
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    setupAttributes()
    setupConstraints()
  }
  
  private func setupAttributes() {
    self.backgroundColor = UIColor(named: ColorReference.backGray.rawValue)
    self.optionButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    self.stateButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    self.endOfSalesButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
  }
  
  private func setupConstraints() {
    let bottomButtonWidth: CGFloat = viewWidth / 2
    self.backView.then { self.contentView.addSubview($0) }
      .snp.makeConstraints {
        $0.bottom.equalToSuperview().offset(-8)
        $0.top.leading.trailing.equalToSuperview()
    }
    self.optionButton.then { self.backView.addSubview($0) }
      .snp.makeConstraints {
        $0.top.trailing.equalToSuperview().inset(spacing)
        $0.width.height.equalTo(optionButtonSize)
    }
    self.itemContentView.then { self.backView.addSubview($0) }
      .snp.makeConstraints {
        $0.top.leading.equalToSuperview().offset(spacing)
        $0.trailing.equalTo(optionButton).offset(-spacing)
    }
    self.verLine.then { self.backView.addSubview($0) }
      .snp.makeConstraints {
        $0.top.equalTo(itemContentView.snp.bottom)
        $0.leading.equalToSuperview()
        $0.width.equalTo(viewWidth)
        $0.height.equalTo(0.5)
    }
    self.stateButton.then { self.backView.addSubview($0) }
      .snp.makeConstraints {
        $0.top.equalTo(verLine.snp.bottom)
        $0.leading.equalToSuperview()
        $0.width.equalTo(bottomButtonWidth)
        $0.height.equalTo(bottomButtonHeight)
    }
    self.endOfSalesButton.then { self.backView.addSubview($0) }
      .snp.makeConstraints {
        $0.top.equalTo(verLine.snp.bottom)
        $0.trailing.equalToSuperview()
        $0.width.equalTo(bottomButtonWidth)
        $0.height.equalTo(bottomButtonHeight)
    }
    self.horLine.then { self.backView.addSubview($0) }
      .snp.makeConstraints {
        $0.height.equalTo(23)
        $0.width.equalTo(0.5)
        $0.centerX.equalToSuperview()
        $0.centerY.equalTo(stateButton)
        $0.bottom.equalToSuperview().offset(-10)
    }
  }
  
  // MARK: Interface
  
  func configure(onSale: Post) {
    self.itemContentView.itemImageView.image = UIImage(named: "image4")
    self.itemContentView.titleLabel.text = onSale.title
    self.itemContentView.addrTimeLabel.text = onSale.address
    self.numberFormatter.numberStyle = .decimal
    self.itemContentView.priceLabel.text = "\(numberFormatter.string(from: NSNumber(value: onSale.price))!)원"
    self.itemContentView.postID = onSale.postId
    
    if onSale.state == "reserved" {
      self.stateButton.setTitle("판매중으로 변경", for: .normal)
      self.itemContentView.reservedState(reserved: true)
    } else if onSale.state == "sales" {
      self.stateButton.setTitle("예약중으로 변경", for: .normal)
      self.itemContentView.reservedState(reserved: false)
    }
  }
  
  // MARK: Action
  
  @objc func didTapButton(_ sender: UIButton) {
    switch sender {
    case optionButton:
      delegate?.onSaleOption()
      
    case stateButton:
      if stateButton.titleLabel?.text == "예약중으로 변경" {
        self.stateButton.setTitle("판매중으로 변경", for: .normal)
        self.itemContentView.reservedState(reserved: true)
        guard let indexOfData = sellerItemsData1.lastIndex(where: { (idx) -> Bool in
          idx.postId == self.itemContentView.postID }
          ) else { return }
        sellerItemsData1[indexOfData].state = "reserved"
      } else {
        guard let indexOfData = sellerItemsData1.lastIndex(where: { (idx) -> Bool in
          idx.postId == self.itemContentView.postID }
          ) else { return }
        sellerItemsData1[indexOfData].state = "slaes"
        self.stateButton.setTitle("예약중으로 변경", for: .normal)
        self.itemContentView.reservedState(reserved: false)
      }
      
    case endOfSalesButton:
      delegate?.endOfSalePage()
      
    default:
      break
    }
  }
}
