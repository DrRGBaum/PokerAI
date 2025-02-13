extends Node2D

var gewinnkombination = ""
@onready var gewinnkarten: Array[Node2D] = []
var isStraight = false
var isFlush = false
var isStraightFlush = false

func check(pKarten: Array): # checks the given cards for the highest combination
	gewinnkarten.clear()
	pKarten = sort(pKarten)
	gewinnkarten.append(highCard(pKarten))
	onePair(pKarten)
	if pKarten.size() > 2:
		threeOfAKind(pKarten)
		straight(pKarten)
		# flush(pKarten)
		fullHouse(pKarten)
		fullHouse(pKarten)
		fullHouse(pKarten)
		fourOfAKind(pKarten)
		straightFlush(pKarten)
		straightFlush(pKarten)
		royalFlush(pKarten)
	print(gewinnkombination)
	return gewinnkarten

func getWinCondition():
	return gewinnkombination

func highCard(pKarten):
	# gewinnkarten.clear()
	gewinnkombination = "Highcard"
	return pKarten[pKarten.size() - 1] # hope this is right

func onePair(pKarten):
	for i in range(pKarten.size() - 2):
		for j in range(i + 1, pKarten.size()):
			if pKarten[i].number == pKarten[j].number:
				gewinnkombination = "One Pair"
				gewinnkarten.clear()
				gewinnkarten.append(pKarten[i])
				gewinnkarten.append(pKarten[j])

				pKarten.remove_at(i)
				pKarten.remove_at(j) # TODO: need to update array length
	
	if pKarten.size() < 3: return
		
	for i in range(pKarten.size() - 2):
		for j in range(i + 1, pKarten.size() - 1):
			if pKarten[i].number == pKarten[j].number:
				gewinnkombination = "Two pairs"
				gewinnkarten.append(pKarten[i])
				gewinnkarten.append(pKarten[j])

func threeOfAKind(pKarten):
	for i in range(pKarten.size() - 3):
		for j in range(i + 1, pKarten.size() - 2):
			for k in range(j + 1, pKarten.size() - 1):
				if pKarten[i].number == pKarten[j].number and pKarten[j].number == pKarten[k].number:
					gewinnkombination = "Three of a kind"
					gewinnkarten = [pKarten[i],pKarten[j],pKarten[k]]

func straight(pKarten):
	pKarten = sort(pKarten)
	var count = 0
	for i in range(pKarten.size() - 1):
		if pKarten[i].number + 1 == pKarten[i + 1].number:
			count += 1
			if count == 4:
				gewinnkombination = "Straight"
				gewinnkarten = [pKarten[i - 3],pKarten[i - 2],pKarten[i - 1],pKarten[i],pKarten[i + 1]]

#func flush(pKarten): funktioniert nicht
	#pKarten = sortColor(pKarten)
	#var count = 0
	#for i in range(pKarten.size() - 2):
		#if pKarten[i].color == pKarten[i + 1].color:
			#count += 1
			#if count == 4:
				#gewinnkombination = "Flush"
				#gewinnkarten = [pKarten[i - 3],pKarten[i - 2],pKarten[i - 1],pKarten[i],pKarten[i + 1]]

func fullHouse(pKarten):
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

func fourOfAKind(pKarten):
	for i in range(pKarten.size() - 4):
		if pKarten[i].number == pKarten[i + 1].number and pKarten[i].number == pKarten[i + 2].number and pKarten[i].number == pKarten[i + 3].number and pKarten[i].number == pKarten[i + 4].number:
			gewinnkombination = "four of a kind"
			for j in range(i, i + 4):
				gewinnkarten.append(pKarten[j]) # could be wrong here,hopes and prayers

func straightFlush(pKarten):
	if isStraight and isFlush:
		straight(pKarten) # to get gewinnkarten
		isStraightFlush = true
		gewinnkombination = "Straight Flush"

func royalFlush(pKarten):
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

func sortColor(pKarten): #
	return null

func sort(pKarten): # sorts cards by number
	for i in range(pKarten.size() - 1):
		for j in range(pKarten.size() - i - 1):
			if pKarten[j].number > pKarten[j + 1].number:
				var s = pKarten[j]
				pKarten[j] = pKarten[j + 1]
				pKarten[j + 1] = s
	outputCardNumbers(pKarten)
	return pKarten

func outputCardNumbers(pKarten):
	for i in range(pKarten.size()):
		print(pKarten[i].number)
	return null
