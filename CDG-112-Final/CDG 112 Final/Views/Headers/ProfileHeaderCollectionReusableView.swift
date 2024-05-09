//
//  ProfileHeaderCollectionReusableView.swift
//  CDG 112 Final
//
//  Created by lab on 4/29/24.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderDidTapPostButton(_ header: ProfileHeaderCollectionReusableView)
    func profileHeaderDidTapFollowersButton(_ header: ProfileHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_ header: ProfileHeaderCollectionReusableView)
    func profileHeaderDidTapEditProfileButton(_ header: ProfileHeaderCollectionReusableView)
}

final class ProfileHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileHeaderCollectionReusableCell"
    
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let postsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Posts", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    private let followingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    private let followersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Followers", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit your profile", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Joe Smith"
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Example Bio"
        label.numberOfLines = 0
        return label
    }()
    
    private func addButtonActions()
    {
        followersButton.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
        postsButton.addTarget(self, action: #selector(didTapPostsButton), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addButtonActions()
        backgroundColor = .systemBackground
        clipsToBounds = true
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let profilePhotoSize = width / 4
        profilePhotoImageView.frame = CGRect(x: 5, y: 5, width: profilePhotoSize, height: profilePhotoSize).integral
        let buttonHeight = profilePhotoSize / 2
        let countButtonWidth = (width-10-profilePhotoSize) / 3
        profilePhotoImageView.frame = CGRect(x: 5, y: 5, width: profilePhotoSize, height: profilePhotoSize).integral
        
        postsButton.frame = CGRect(x: profilePhotoImageView.right, y: 5, width: countButtonWidth, height: buttonHeight).integral
        followersButton.frame = CGRect(x: postsButton.right, y: 5, width: countButtonWidth, height: buttonHeight).integral
        followingButton.frame = CGRect(x: followersButton.right, y: 5, width: countButtonWidth, height: buttonHeight).integral
        editProfileButton.frame = CGRect(x: profilePhotoImageView.right, y: 5 + buttonHeight, width: countButtonWidth * 3, height: buttonHeight).integral
        nameLabel.frame = CGRect(x: 5, y: 5 + profilePhotoImageView.bottom, width: width - 10, height: 50).integral
        let bioLabelSize = bioLabel.sizeThatFits(frame.size)
        bioLabel.frame = CGRect(x: 5, y: 5 + nameLabel.bottom, width: width - 10, height: bioLabelSize.height).integral
        
        
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize / 2.0
    }
    
    private func addSubviews()
    {
        addSubview(profilePhotoImageView)
        addSubview(followersButton)
        addSubview(followingButton)
        addSubview(editProfileButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
        addSubview(postsButton)
    }
    
    @objc private func didTapFollowingButton()
    {
        delegate?.profileHeaderDidTapFollowersButton(self)
    }
    @objc private func didTapPostsButton()
    {
        delegate?.profileHeaderDidTapFollowingButton(self)
    }
    @objc private func didTapFollowersButton()
    {
        delegate?.profileHeaderDidTapPostButton(self)
    }
    @objc private func didTapEditProfileButton()
    {
        delegate?.profileHeaderDidTapEditProfileButton(self)
    }
}
