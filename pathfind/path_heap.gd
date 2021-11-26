var heap = []


func add(new_item):
	heap.append()
	new_item.heap_index = heap.size()-1
	sort_up(new_item)


func sort_up(item):
	while item.heap_index > 0:
		if item.compare( heap[item.heap_index/2] ) < 0:
			swap(item, heap[item.heap_index/2])
		else:
			#no more moves necessary
			break


func sort_down(item):
	#while has children
	while item.heap_index*2+1 < heap.size():
		var swap_index = -1
		#if first child is smaller
		if item.compare( heap[item.heap_index*2+1] ) > 0:
			swap_index = item.heap_index*2+1
		#if second child exists and is smaller than first child
		if item.heap_index*2+2 < heap.size():
			if item.compare( heap[item.heap_index*2+1] ) > item.compare( heap[item.heap_index*2+2] ):
				swap_index = item.heap_index*2+2
		#if found a smaller child
		if swap_index > -1:
			swap(item, heap[swap_index])
		else:
			#no more moves necessary
			break



func swap(item1, item2):
	var temp_index = item1.heap_index
	heap[item1.heap_index] = item2
	heap[item2.heap_index] = item1
	item1.heap_index = item2.heap_index
	item2.heap_index = temp_index
