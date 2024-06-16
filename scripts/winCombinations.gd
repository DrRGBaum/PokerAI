extends Node2D

var gewinnkombination = ""
@onready var gewinnkarten = []
var isStraight = false
var isFlush = false
var isStraightFlush = false

func check(pKarten): # checks the given cards for the highest combination
	pKarten = sort(pKarten)
	gewinnkarten = highCard(pKarten)
	onePair(pKarten)
	if pKarten.size() > 3:
		twoPairs(pKarten, false)
		threeOfAKind(pKarten)
		straight(pKarten)
		flush(pKarten)
		fullHouse(pKarten)
		fullHouse(pKarten)
		fullHouse(pKarten)
		fourOfAKind(pKarten)
		straightFlush(pKarten)
		straightFlush(pKarten)
		royalFlush(pKarten)
	return gewinnkarten

func getWinCondition():
	return gewinnkombination

func highCard(pKarten):
	gewinnkarten.clear()
	gewinnkombination = "Highcard"
	gewinnkarten.append(pKarten[1]) # hope this is right

func onePair(pKarten):
	for i in range(pKarten.size() - 2):
		for j in range(i + 1, pKarten.size() - 1):
			if pKarten[i].number == pKarten[j].number:
				gewinnkombination = "One Pair"
				gewinnkarten.clear()
				gewinnkarten.append(pKarten[i])
				gewinnkarten.append(pKarten[j])

func twoPairs(pKarten: Array, loop: bool):
	for i in range(pKarten.size() - 2):
		for j in range(i + 1, pKarten.size() - 1):
			if pKarten[i].number == pKarten[j].number and loop:
				gewinnkombination = "Two Pair"
				gewinnkarten.append(pKarten[i])
				gewinnkarten.append(pKarten[j])
			elif pKarten[i].number == pKarten[j].number:
				gewinnkarten.append(pKarten[i])
				gewinnkarten.append(pKarten[j])
				pKarten.remove_at(i)
				pKarten.remove_at(j)
				twoPairs(pKarten, true)

func threeOfAKind(pKarten: Array):
	for i in range(pKarten.size() - 3):
		for j in range(i + 1, pKarten.size() - 2):
			for k in range(j + 1, pKarten.size() - 1):
				if pKarten[i].number == pKarten[j].number and pKarten[j].number == pKarten[k].number:
					gewinnkombination = "Three of a kind"
					gewinnkarten = [pKarten[i],pKarten[j],pKarten[k]]

func straight(pKarten: Array):
	pKarten = sort(pKarten)
	var count = 0
	for i in range(pKarten.size()):
		if pKarten[i].number + 1 == pKarten[i + 1].number:
			count += 1
			if count == 4:
				gewinnkombination = "Straight"
				gewinnkarten = [pKarten[i - 3],pKarten[i - 2],pKarten[i - 1],pKarten[i],pKarten[i + 1]]

func flush(pKarten: Array):
	pKarten = sortColor(pKarten)
	var count = 0
	for i in range(pKarten.size() - 2):
		if pKarten[i] == pKarten[i + 1]:
			count += 1
			if count == 4:
				gewinnkombination = "Flush"
				gewinnkarten = [pKarten[i - 3],pKarten[i - 2],pKarten[i - 1],pKarten[i],pKarten[i + 1]]

func fullHouse(pKarten: Array):
	var triple = false
	for i in range(pKarten.size() - 3):
		for j in range(i + 1, pKarten.size() - 2):
			for k in range(j + 1, pKarten.size() - 1):
				if pKarten[i].number == pKarten[j].number and pKarten[j].number == pKarten[k].number:
					gewinnkarten = [pKarten[i],pKarten[j],pKarten[k]]
					triple = true

	for i in range(pKarten.size() - 2):
		for j in range(i + 1, pKarten.size() - 1):
			if pKarten[i].number == pKarten[j].number and triple:
				gewinnkombination = "Full house"
				gewinnkarten.append(pKarten[i])
				gewinnkarten.append(pKarten[j])

func fourOfAKind(pKarten: Array):
	for i in range(pKarten.size() - 4):
		if pKarten[i].number == pKarten[i + 1].number and pKarten[i].number == pKarten[i + 2].number and pKarten[i].number == pKarten[i + 3].number and pKarten[i].number == pKarten[i + 4].number:
			gewinnkombination = "four of a kind"
			for j in range(i, i + 4):
				gewinnkarten.append(pKarten[j]) # could be wrong here,hopes and prayers

func straightFlush(pKarten: Array):
	if isStraight and isFlush:
		straight(pKarten) # to get gewinnkarten
		isStraightFlush = true
		gewinnkombination = "Straight Flush"

func royalFlush(pKarten: Array):
	if isStraightFlush:
		var count = 0
		pKarten = sort(pKarten)
		for i in range(pKarten.size()):
			if pKarten[pKarten.size() - i].number == 12 - i:
				count += 1
		
		if count == 4: # hopes and prayers this is right
			gewinnkombination = "Royal flush"
			for i in range(pKarten.size()):
				gewinnkarten.append(pKarten[pKarten.size() - i])

func sortColor(pKarten: Array): # idk if works with letters, just try
	for i in range(pKarten.size() - 1):
		for j in range(pKarten.size() - i - 2):
			if pKarten[j].color > pKarten[j + 1].color:
				var s = pKarten[j]
				pKarten[j] = pKarten[j + 1]
				pKarten[j + 1] = s
	return pKarten

func sort(pKarten: Array): # sorts cards by number
	for i in range(pKarten.size() - 1):
		for j in range(pKarten.size() - i - 2):
			if pKarten[j].number > pKarten[j + 1].number:
				var s = pKarten[j]
				pKarten[j] = pKarten[j + 1]
				pKarten[j + 1] = s
	return pKarten
