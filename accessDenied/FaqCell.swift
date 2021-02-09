//
//  FaqCell.swift
//  accessDenied
//
//  Created by Siddharth Dinkar on 02/02/21.
//

import UIKit

class FaqCell: UITableViewCell {
    
    var data: MCDropData? {
        didSet{
            guard let data = data else {return }
            self.title.text = data.title
            self.url.text = data.url
        }
    }
    
    func animate() {
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseIn, animations: { self.contentView.layoutIfNeeded( )  } )
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    fileprivate let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.text = "Course title here"
        label.textColor = Colors.faqText
        label.textAlignment = .left
        label.numberOfLines = -1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }( )
    
    fileprivate let url: UILabel = {
        let label = UILabel()
       label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "Course url here"
        label.textColor = .white
        //label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }( )

    fileprivate let container: UIView = {
        let v = UIView( )
        v.translatesAutoresizingMaskIntoConstraints = false
        v.clipsToBounds = true
        v.backgroundColor = Colors.faqCellBackground
        //v.alpha = 0.5
        v.layer.cornerRadius = 8
        return v
    }( )
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:  style, reuseIdentifier:  reuseIdentifier)
        contentView.addSubview(container)
        
        container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
        container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4).isActive = true
        container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4).isActive = true
        container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
       
    
        container.addSubview(title)
        container.addSubview(url)
    
                title.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
                title.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10).isActive = true
                title.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -9).isActive = true
                title.heightAnchor.constraint(equalToConstant: 68).isActive = true
                
                url.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
                url.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10).isActive = true
                url.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -4).isActive = true
                //url.heightAnchor.constraint(equalToConstant: 120).isActive = true
         
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
