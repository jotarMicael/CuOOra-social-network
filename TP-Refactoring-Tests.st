TestCase subclass: #AnswerTest	instanceVariableNames: 'answer'	classVariableNames: ''	poolDictionaries: ''	category: 'TP-Refactoring-Tests'!!AnswerTest methodsFor: 'setup'!setUp
	answer := Answer new:'An answer'  user:(User new)  question:(Question new).! !!AnswerTest methodsFor: 'testing'!testNegativeVotes		
	answer addVote: (Vote user: (User new) dislikesPublication: answer).
	self assert: (answer negativeVotes size) equals: 1.
	
	answer addVote: (Vote user: (User new) dislikesPublication: answer).
	self assert: (answer negativeVotes size) equals: 2.
! !!AnswerTest methodsFor: 'testing'!testPositiveAndNegativeVotesInterference
	
	answer addVote: (Vote user: (User new) dislikesPublication: answer).
	self assert: (answer positiveVotes size) equals: 0.
	
	answer addVote: (Vote user: (User new) likesPublication: answer).	
	self assert: (answer positiveVotes size) equals: 1.
	
	answer addVote: (Vote user: (User new) likesPublication: answer).	
	self assert: (answer positiveVotes size) equals: 2.
	
	answer addVote: (Vote user: (User new) dislikesPublication: answer).
	self assert: (answer positiveVotes size) equals: 2.
	
	self assert: answer votes size equals: 4.! !!AnswerTest methodsFor: 'testing'!testVotesForNewAnswer
	self assert: (answer negativeVotes size) equals: 0.
	self assert: (answer positiveVotes size) equals: 0.
		! !!AnswerTest methodsFor: 'testing'!testPositiveVotes
	answer addVote: (Vote user: (User new) likesPublication: answer).	
	self assert: (answer positiveVotes size) equals: 1.
	
	answer addVote: (Vote user: (User new) likesPublication: answer).	
	self assert: (answer positiveVotes size) equals: 2.
	! !TestCase subclass: #QuestionRetrieverTest	instanceVariableNames: 'cuoora socialRetriever topicsRetriever newsRetriever popularTodayRetriever user1 user2 user3 topicOO1 topicOO2 questionUser1TopicOO1 questionUser3TopicOO2 questionUser2TopicOO2 question2User3TopicOO2'	classVariableNames: ''	poolDictionaries: ''	category: 'TP-Refactoring-Tests'!!QuestionRetrieverTest methodsFor: 'testing'!popularTodayFourLikesFourQuestionsAtLeastOneVote
	  "4 likes / 4 preguntas // preguntas con al menos 1 voto"question2User3TopicOO2 addVote: (Vote user: user1 likesPublication: question2User3TopicOO2).
  question2User3TopicOO2 addVote: (Vote user: User new likesPublication: question2User3TopicOO2).
  self assert: (popularTodayRetriever retrieveQuestions: user1) size equals: 2.
  self assert: (popularTodayRetriever retrieveQuestions: user2) size equals: 1.
  self assert: (popularTodayRetriever retrieveQuestions: user3) size equals: 1.! !!QuestionRetrieverTest methodsFor: 'testing'!popularTodayNoLikesThreeQuestions
  "0 likes / 3 preguntas "
  questionUser2TopicOO2 := Question newWithTitle: 'Which bad smell...?' description: '' user: user2 topic: topicOO2.
  cuoora addQuestion: questionUser2TopicOO2 forUser: user2.
  self assert: (popularTodayRetriever retrieveQuestions: user1) size equals: 2.
  self assert: (popularTodayRetriever retrieveQuestions: user2) size equals: 2.
  self assert: (popularTodayRetriever retrieveQuestions: user3) size equals: 2! !!QuestionRetrieverTest methodsFor: 'testing'!testSocialRetrieveQuestions
	| questionUser2TopicOO2 |
	
	self assert: (socialRetriever retrieveQuestions: user1) size equals: 1.
	self assert: (socialRetriever retrieveQuestions: user1) first equals: questionUser3TopicOO2.
	
	self assert: (socialRetriever retrieveQuestions: user2) size equals: 0.
	self assert: (socialRetriever retrieveQuestions: user3) size equals: 0.
	
	questionUser2TopicOO2 := Question newWithTitle: 'Which bad smell...?' description: '' user: user2 topic: topicOO2.
	questionUser2TopicOO2 addVote: (Vote user: user2 dislikesPublication: questionUser2TopicOO2).
	cuoora addQuestion: questionUser2TopicOO2 forUser:user2.
	
	self assert: (socialRetriever retrieveQuestions: user1) size equals: 2.
	self assert: (socialRetriever retrieveQuestions: user1) last equals: questionUser2TopicOO2.
	
	self assert: (socialRetriever retrieveQuestions: user3) size equals: 0.
	self assert: (socialRetriever retrieveQuestions: user2) size equals: 0.
	
	
	
	! !!QuestionRetrieverTest methodsFor: 'testing'!popularTodayFourQuestionsAtLeastOneVote
	  "1 likes / 4 preguntas // preguntas con al menos 1 voto"question2User3TopicOO2 := Question newWithTitle: 'Which refactoring should...' description: '' user: user3 topic: topicOO2.
  cuoora addQuestion: question2User3TopicOO2 forUser: user3.
  self assert: (popularTodayRetriever retrieveQuestions: user1) size equals: 1.
  self assert: (popularTodayRetriever retrieveQuestions: user2) size equals: 0.
  self assert: (popularTodayRetriever retrieveQuestions: user3) size equals: 1.! !!QuestionRetrieverTest methodsFor: 'testing'!testPopularTodayRetrieveQuestions
  self
     popularTodayNoLikesTwoQuestions;
     popularTodayNoLikesThreeQuestions;
     popularTodayAtLeastOneVote;
     popularTodayFourQuestionsAtLeastOneVote;
     popularTodayTwoLikesFourQuestionsAtLeastOneVote;
     popularTodayFourLikesFourQuestionsAtLeastOneVote;
     popularTodayFiveLikesFourQuestionsAtLeastOneVote! !!QuestionRetrieverTest methodsFor: 'testing'!testNewsRetrieveQuestions
	| questionUser2TopicOO2 |
	self assert: (newsRetriever retrieveQuestions: user1) size equals: 1.
	self assert: (newsRetriever retrieveQuestions: user1) last equals: questionUser3TopicOO2.
	self assert: (newsRetriever retrieveQuestions: user2) size equals: 2.
	self assert: (newsRetriever retrieveQuestions: user3) size equals: 1.
	self assert: (newsRetriever retrieveQuestions: user3) last equals: questionUser1TopicOO1.
	
	questionUser2TopicOO2 := Question
		newWithTitle: 'Which bad smell...?'
		description: ''
		user: user2
		topic: topicOO2.
	cuoora addQuestion: questionUser2TopicOO2 forUser: user2.
	
	self assert: (newsRetriever retrieveQuestions: user1) size equals: 2.
	self assert: (newsRetriever retrieveQuestions: user2) size equals: 2.
	self assert: (newsRetriever retrieveQuestions: user3) size equals: 2.! !!QuestionRetrieverTest methodsFor: 'testing'!popularTodayNoLikesTwoQuestions
	self
		assert: (popularTodayRetriever retrieveQuestions: user1) size
		equals: 1.	"0 likes / 2 preguntas "
	self
		assert: (popularTodayRetriever retrieveQuestions: user1) last
		equals: questionUser3TopicOO2.
	self
		assert: (popularTodayRetriever retrieveQuestions: user2) size
		equals: 2.
	self
		assert: (popularTodayRetriever retrieveQuestions: user3) size
		equals: 1.
	self
		assert: (popularTodayRetriever retrieveQuestions: user3) last
		equals: questionUser1TopicOO1! !!QuestionRetrieverTest methodsFor: 'testing'!popularTodayAtLeastOneVote
 
  "1 likes / 2 preguntas // preguntas con al menos 1 voto"
  questionUser2TopicOO2 addVote: (Vote user: user3 likesPublication: questionUser2TopicOO2).
  self assert: (popularTodayRetriever retrieveQuestions: user1) size equals: 1.
  self assert: (popularTodayRetriever retrieveQuestions: user2) size equals: 0.
  self assert: (popularTodayRetriever retrieveQuestions: user3) size equals: 1! !!QuestionRetrieverTest methodsFor: 'testing'!popularTodayFiveLikesFourQuestionsAtLeastOneVote
  "5 likes / 4 preguntas // preguntas con mas de 1 voto"question2User3TopicOO2 addVote: (Vote user: User new likesPublication: question2User3TopicOO2).
  self assert: (popularTodayRetriever retrieveQuestions: user1) size equals: 1.
  self assert: (popularTodayRetriever retrieveQuestions: user1) first equals: question2User3TopicOO2.
  self assert: (popularTodayRetriever retrieveQuestions: user2) size equals: 1.
  self assert: (popularTodayRetriever retrieveQuestions: user3) size equals: 0.
  15 timesRepeat: [ questionUser1TopicOO1 addVote: (Vote user: User new likesPublication: questionUser1TopicOO1) ].
  self assert: (popularTodayRetriever retrieveQuestions: user1) size equals: 0.
  self assert: (popularTodayRetriever retrieveQuestions: user2) size equals: 1.
  self assert: (popularTodayRetriever retrieveQuestions: user2) first equals: questionUser1TopicOO1.
  self assert: (popularTodayRetriever retrieveQuestions: user3) size equals: 1.
  self assert: (popularTodayRetriever retrieveQuestions: user3) first equals: questionUser1TopicOO1! !!QuestionRetrieverTest methodsFor: 'testing'!testTopicsRetrieveQuestions
  | questionUser2TopicOO2 |
  self assert: (topicsRetriever retrieveQuestions: user1) size equals: 0.
  self assert: (topicsRetriever retrieveQuestions: user2) size equals: 1.
  self assert: (topicsRetriever retrieveQuestions: user3) size equals: 0.
  questionUser2TopicOO2 := Question newWithTitle: 'Which bad smell...?' description: '' user: user2 topic: topicOO2.
  cuoora addQuestion: questionUser2TopicOO2 forUser: user2.
  self assert: (topicsRetriever retrieveQuestions: user2) size equals: 1.
  self assert: (topicsRetriever retrieveQuestions: user3) size equals: 1.
  self assert: (topicsRetriever retrieveQuestions: user3) first equals: questionUser2TopicOO2.
  self assert: (topicsRetriever retrieveQuestions: user1) size equals: 0! !!QuestionRetrieverTest methodsFor: 'testing'!popularTodayTwoLikesFourQuestionsAtLeastOneVote
	   "2 likes / 4 preguntas // preguntas con al menos 1 voto"question2User3TopicOO2 addVote: (Vote user: user2 likesPublication: question2User3TopicOO2).
  self assert: (popularTodayRetriever retrieveQuestions: user1) size equals: 2.
  self assert: (popularTodayRetriever retrieveQuestions: user2) size equals: 1.
  self assert: (popularTodayRetriever retrieveQuestions: user3) size equals: 1.! !!QuestionRetrieverTest methodsFor: 'set up'!setUp
	user1 := User new.
	user2 := User new.
	user3 := User new.
	user1 follow: user2; follow: user3.
	
	topicOO1 := Topic name: 'OO1' description: 'This topic is for discussing about OO1 issues'.
	topicOO2 := Topic name: 'OO2' description: 'This topic is for discussing about OO2 issues'.	

	user1 addTopic: topicOO1.
	user2 addTopic: topicOO2.
	user3 addTopic: topicOO2.

	cuoora := CuOOra new.
	cuoora addUser: user1; addUser: user2; addUser: user3.
	
	questionUser1TopicOO1 := Question newWithTitle: 'How to create a class in Pharo' description: '' user: user1 topic: topicOO1.
	questionUser3TopicOO2 := Question newWithTitle: 'How to create a WAComponent for...' description: '' user: user3 topic: topicOO2.

	cuoora addQuestion: questionUser1TopicOO1 forUser:user1.
	cuoora addQuestion: questionUser3TopicOO2 forUser:user3.
	
	socialRetriever := QuestionRetriever new: cuoora and: #social.
	topicsRetriever := QuestionRetriever new: cuoora and: #topics.
	newsRetriever := QuestionRetriever new: cuoora and: #news.
	popularTodayRetriever := QuestionRetriever new: cuoora and: #popularToday.! !TestCase subclass: #QuestionTest	instanceVariableNames: 'question'	classVariableNames: ''	poolDictionaries: ''	category: 'TP-Refactoring-Tests'!!QuestionTest methodsFor: 'testing'!testNegativeVotes		
	question addVote: (Vote user: (User new) dislikesPublication: question).
	self assert: (question negativeVotes size) equals: 1.
	
	question addVote: (Vote user: (User new) dislikesPublication: question).
	self assert: (question negativeVotes size) equals: 2.
! !!QuestionTest methodsFor: 'testing'!testPositiveAndNegativeVotesInterference	
	question addVote: (Vote user: (User new) dislikesPublication: question).
	self assert: (question positiveVotes size) equals: 0.
	self assert: (question negativeVotes size) equals: 1.
	
	question addVote: (Vote user: (User new) likesPublication: question).	
	self assert: (question positiveVotes size) equals: 1.
	self assert: (question negativeVotes size) equals: 1.
	
	self assert: question votes size equals: 2.! !!QuestionTest methodsFor: 'testing'!testVotesForNewQuestion
	self assert: (question negativeVotes size) equals: 0.
	self assert: (question positiveVotes size) equals: 0.
		! !!QuestionTest methodsFor: 'testing'!testPositiveVotes
	question addVote: (Vote user: (User new) likesPublication: question).	
	self assert: (question positiveVotes size) equals: 1.
	
	question addVote: (Vote user: (User new) likesPublication: question).	
	self assert: (question positiveVotes size) equals: 2.
	! !!QuestionTest methodsFor: 'setup'!setUp
	question := Question  newWithTitle: 'Question  title' description: 'Question description' user: (User new) 
! !