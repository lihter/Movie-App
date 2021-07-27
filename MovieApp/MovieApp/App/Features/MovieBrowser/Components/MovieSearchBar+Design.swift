import UIKit
import SnapKit

extension MovieSearchBar: DesignProtocol {
    
    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        searchGrayFieldView = UIView()
        addSubview(searchGrayFieldView)
        
        let image = ImageEnum.searchBarIcon.image
        searchBarIconImageView = UIImageView(image: image)
        searchGrayFieldView.addSubview(searchBarIconImageView)
        
        searchTextField = UITextField()
        searchTextField.delegate = self
        searchGrayFieldView.addSubview(searchTextField)
        
        cancelButton = UIButton()
        cancelButton.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
        addSubview(cancelButton)
        
        deleteTextButton = UIButton()
        deleteTextButton.addTarget(self, action: #selector(deleteTextFieldEntry), for: .touchUpInside)
        searchGrayFieldView.addSubview(deleteTextButton)
    }
    
    func styleViews() {
        searchGrayFieldView.layer.cornerRadius = grayFieldCornerRadius
        searchGrayFieldView.backgroundColor = .searchFieldGray
        
        searchBarIconImageView.contentMode = .scaleAspectFit
        
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.searchPlaceholderColor,
                         NSAttributedString.Key.font: UIFont(name: Fonts.proximaMedium, size: 16) ?? .systemFont(ofSize: 16)])
        searchTextField.font = UIFont(name: Fonts.proximaMedium, size: 16) ?? .systemFont(ofSize: 16)
        
        deleteTextButton.isHidden = true
        deleteTextButton.setImage(ImageEnum.searchDeleteImage.image, for: .normal)
        deleteTextButton.imageView?.contentMode = .scaleAspectFit
        deleteTextButton.setTitleColor(.black, for: .normal)
        
        cancelButton.isHidden = true
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.primaryBlue, for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: Fonts.proximaMedium, size: 16) ?? .systemFont(ofSize: 16)
    }
    
    func defineLayoutForViews() {
        snp.makeConstraints {
            $0.height.equalTo(searchBarHeight)
        }
        
        searchGrayFieldView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(4 * offset)
            $0.trailing.equalToSuperview().inset(4 * offset)
            $0.top.bottom.equalToSuperview()
        }
        
        searchBarIconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(3 * offset)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(0.5 * searchBarHeight)
        }
        
        searchTextField.snp.makeConstraints {
            $0.leading.equalTo(searchBarIconImageView.snp.trailing).offset(3 * offset)
            $0.trailing.equalToSuperview().inset(3 * offset)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(0.5 * searchBarHeight)
        }
        
        cancelButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(4 * offset)
            $0.centerY.equalToSuperview()
        }
        
        deleteTextButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(2 * offset)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(deleteTextButtonHeight)
        }
    }
    
    func changeCancelButtonVisibility() {
        if(cancelButton.isHidden) {
            UIView.animate(withDuration: 0.5, animations: {
                self.searchGrayFieldView.snp.remakeConstraints {
                    $0.leading.equalToSuperview().offset(4 * self.offset)
                    $0.trailing.equalTo(self.cancelButton.snp.leading).offset(-4 * self.offset)
                    $0.top.bottom.equalToSuperview()
                }
                self.deleteTextButton.isHidden.toggle()
                self.searchGrayFieldView.superview?.layoutIfNeeded()
            }, completion: { _ in
                self.cancelButton.isHidden.toggle()
            })
        } else {
            cancelButton.isHidden.toggle()
            UIView.animate(withDuration: 0.5) {
                self.searchGrayFieldView.snp.remakeConstraints {
                    $0.leading.equalToSuperview().offset(4 * self.offset)
                    $0.trailing.equalToSuperview().inset(4 * self.offset)
                    $0.top.bottom.equalToSuperview()
                }
                self.deleteTextButton.isHidden.toggle()
                self.searchGrayFieldView.superview?.layoutIfNeeded()
            }
        }
    }
    
}

extension MovieSearchBar: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        changeCancelButtonVisibility()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        changeCancelButtonVisibility()
    }
        
    @objc func cancelPressed(sender: UIButton!) {
        endEditing(true)
    }
    
    @objc func deleteTextFieldEntry(sender: UIButton!) {
        searchTextField.text = ""
    }
    
}
