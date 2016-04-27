//
//  StudyViewController.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-04-27.
//  Copyright © 2016 Dan K. All rights reserved.
//

import UIKit
import RealmSwift

class StudyViewController: UIViewController {
    
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var showAnswerButton: RoundedButton!
    @IBOutlet weak var answerButtonsStackView: UIStackView!

    var cardsToStudy: Results<Card>!
    var currentCard: Card!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showNextCard()
    }
    
    @IBAction func showAnswer(sender: RoundedButton) {
        showAnswer()
    }
    
    @IBAction func answer(sender: RoundedButton) {
        print(sender.tag)
        answer(sender.tag)
    }
    
    @IBAction func unwindBack(segue: UIStoryboardSegue) {
        navigationController!.popViewControllerAnimated(true)
    }
    
    private func showNextCard() {
        guard let nextCard = cardsToStudy.first else {
            print("Finished!")
            
            frontLabel.hidden = true
            showAnswerButton.hidden = true
            
            // TODO: Show finish screen
            performSegueWithIdentifier("ShowFinishView", sender: self)
            
            return
        }
        
        currentCard = nextCard
        frontLabel.text = currentCard.front
        backLabel.text = currentCard.back
    }
    
    private func showAnswer() {
        showAnswerButton.hidden = true
        answerButtonsStackView.hidden = false
        backLabel.hidden = false
    }
    
    private func hideAnswer() {
        showAnswerButton.hidden = false
        answerButtonsStackView.hidden = true
        backLabel.hidden = true
    }
    
    private func answer(quality: Int) {
        let scheduler = Scheduler(card: currentCard, quality: quality)
        scheduler.schedule()
        hideAnswer()
        showNextCard()
    }
    

}
