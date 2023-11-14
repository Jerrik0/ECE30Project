////////////////////////
//                    //
// Project Submission //
//                    //
////////////////////////

// Partner1: Oliver Chen, A16963089
// Partner2: Jerry Ko, (Student ID here)

////////////////////////
//                    //
//       main         //
//                    //
////////////////////////

    // Print Input Array
    lda x0, arr1        // x0 = &list1
    lda x1, arr1_length // x1 = &list1_length
    ldur x1, [x1, #0]   // x1 = list1_length
    bl printList

    // Test Swap Function
    bl printSwapNumbers // print the original values
    lda x0, swap_test   // x0 = &swap_test[0]
    addi x1, x0, #8     // x1 = &swap_test[1]
    bl Swap             // Swap(&swap_test[0], &swap_test[1])
    bl printSwapNumbers // print the swapped values

    // Test GetNextGap Function
    addi x0, xzr, #1    // x0 = 1
    bl GetNextGap       // x0 = GetNextGap(1) = 0
    putint x0           // print x0
    addi x1, xzr, #32   // x1 = ' '
    putchar x1          // print x1

    addi x0, xzr, #6    // x0 = 6
    bl GetNextGap       // x0 = GetNextGap(6) = 3
    putint x0           // print x0
    addi x1, xzr, #32   // x1 = ' '
    putchar x1          // print x1

    addi x0, xzr, #7    // x0 = 7
    bl GetNextGap       // x0 = GetNextGap(7) = 4
    putint x0           // print x0
    addi x1, xzr, #10   // x1 = '\n'
    putchar x1          // print x1


    // Test inPlaceMerge Function
    lda x0, merge_arr_length // x1 = &merge_arr1_length
    ldur x0, [x0, #0]        // x0 = merge_arr1_length
    bl GetNextGap            // x0 = GetNextGap(merge_arr1_length)
    addi x2, x0, #0          // x2 = x0 = gap
    lda x0, merge_arr        // x0 = &merge_arr1
    lda x3, merge_arr_length // x3 = &merge_arr1_length
    ldur x3, [x3, #0]        // x3 = merge_arr1_length
    subi x3, x3, #1          // x3 = x3 - 1     to get the last element
    lsl x3, x3, #3           // x3 = x3 * 8 <- convert length to bytes
    add x1, x3, x0           // x1 = x3 + x0 <- x1 = &merge_arr1[0] + length in bytes
    bl inPlaceMerge          // inPlaceMerge(&merge_arr1[0], &merge_arr1[0] + length in bytes, gap)
    lda x0, merge_arr
    lda x1, merge_arr_length // x1 = &merge_arr1_length
    ldur x1, [x1, #0]        // x1 = list1_length
    bl printList             // print the merged list


    // Test MergeSort Function
    lda x0, arr1            // x0 = &merge_arr1
    lda x2, arr1_length     // x2 = &merge_arr1_length
    ldur x2, [x2, #0]       // x2 = merge_arr1_length
    subi x2, x2, #1         // x2 = x2 - 1     to get the last element
    lsl x2, x2, #3          // x2 = x2 * 8 <-- convert length to bytes
    add x1, x2, x0          // x1 = x2 + x0 <-- x1 = &merge_arr1[0] + length in bytes
    bl MergeSort            // inPlaceMerge(&merge_arr1[0], &merge_arr1[0] + length in bytes, gap)
    lda x1, arr1_length     // x1 = &list1_length
    ldur x1, [x1, #0]       // x1 = list1_length
    bl printList            // print the merged list


    // [BONUS QUESTION] Binary Search Extension
    // load the sorted array's start and end indices
    lda x0, arr1            // x0 = &merge_arr1
    lda x2, arr1_length     // x2 = &merge_arr1_length
    ldur x2, [x2, #0]       // x2 = merge_arr1_length
    subi x2, x2, #1         // x2 = x2 - 1     to get the last element
    lsl x2, x2, #3          // x2 = x2 * 8 <-- convert length to bytes
    add x1, x2, x0          // x1 = x2 + x0 <-- x1 = &merge_arr1[0] + length in bytes

    // Write your code here to check if each values of binary_search_queries are in the sorted array
    // You must loop through the binary_search_queries array and print 1 if the index is found else 0
    // Hint: use binary_search_query_length and binary_search_queries pointers to loop through the queries
    //       and preserve x0 and x1 values, ie. the starting and ending address which you need to pass
    //       in every function call)

    // [BONUS QUESTION] INSERT YOUR CODE HERE

    stop

////////////////////////
//                    //
//        Swap        //
//                    //
////////////////////////
Swap:
    // input:
    //     x0: the address of the first value
    //     x1: the address of the second value

    // INSERT YOUR CODE HERE

    subi sp, sp, #40    // allocate stack frame
    stur fp, [sp, #8]   // save old fp on sp+8
    stur lr, [sp, #0]   // save lr on sp
    addi fp, sp, #32    // move fp up

    stur x9, [sp, #16]  // store original x9 on sp+16
    stur x10, [sp, #24] // store original x10 on sp+24

    ldur x9, [x0, #0]    // store x0 value into x9 temp register
    ldur x10, [x1, #0]    // store x1 value into x10 temp register

    // swap the value
    stur x10, [x0, #0]    // store x10 value into x0 address
    stur x9, [x1, #0]    // store x9 value into x1 address

    ldur x9, [sp, #16]     // restore x9
    ldur x10, [sp, #24]    // restore x10

    ldur lr, [sp, #0]       // restore lr
    ldur fp, [sp, #8]     // restore fp
    addi sp, sp, #40        // release stack frame

    br lr

////////////////////////
//                    //
//     GetNextGap     //
//                    //
////////////////////////
GetNextGap:
    // input:
    //     x0: The previous value for gap

    // output:
    //     x0: the updated gap value

    // INSERT YOUR CODE HERE

    subi sp, sp, #40    // allocate stack frame
    stur fp, [sp, #8]   // save old fp on sp+8
    stur lr, [sp, #0]   // save lr on sp
    addi fp, sp, #32    // move fp up

    subis xzr, x0, #1    // check if gap<=1
    b.le gap_less
    // gap>1, ceil(gap/2)
    addi x0, x0, #1     // gap = gap+1
    lsr x0, x0, #1      // gap = floor( (gap+1)2 )
    b endif

    gap_less:   // if gap<=1
    addi x0, xzr, #0    // gap = 0

    endif:
    ldur lr, [sp, #0]       // restore lr
    ldur fp, [sp, #8]     // restore fp
    addi sp, sp, #40        // release stack frame

    br lr


////////////////////////
//                    //
//    inPlaceMerge    //
//                    //
////////////////////////
inPlaceMerge:
    // input:
    //    x0: The address of the starting element of the first sub-array.
    //    x1: The address of the last element of the second sub-array.
    //    x2: The gap used in comparisons for shell sorting

    // INSERT YOUR CODE HERE
    subi sp, sp, #40    // allocate stack frame
    stur fp, [sp, #8]   // save old fp on sp+8
    stur lr, [sp, #0]   // save lr on sp
    addi fp, sp, #32    // move fp up

    // get start and store it in x9
    addi x9, xzr, #0
    // get end and store it in x10
    sub x10, x1, x0     // (switch x1 and x0???)
    lsl x10, x10, 3

    subis xzr, x2, #1    // check if gap<1
    b.lt gap_less_than_1

    for:
    addi x11, xzr, #0    // initialize left = start and store left in x9 (???)
    add x13, x11, x2     // x13 = left + gap
    subsi xzr, x11, x10  // check if left+gap <= end
    b.gt end_for
    // left+gap<=end
    add x10, x9, x2     // initialize right = left + gap and store right in x10
    // check if arr[left] > arr[right]
    
    b.gt Swap    // swap(arr, left, right)
    addi x11, x11, #1    // left++

    end_for:
    b GetNextGap    // gap = nextgap(gap)
    b inPlaceMerge // inPlaceMerge(arr, start, end, gap)

    gap_less_than_1:
    ldur lr, [sp, #0]       // restore lr
    ldur fp, [sp, #8]     // restore fp
    addi sp, sp, #40        // release stack frame
    b return    // return

    return:
    br lr


////////////////////////
//                    //
//      MergeSort     //
//                    //
////////////////////////
MergeSort:
    // input:
    //     x0: The starting address of the array.
    //     x1: The ending address of the array

    // INSERT YOUR CODE HERE

    br lr

////////////////////////
//                    //
//      [BONUS]       //
//   Binary Search    //
//                    //
////////////////////////
BinarySearch:
    // input:
    //     x0: The starting address of the sorted array.
    //     x1: The ending address of the sorted array
    //     x2: The value to search for in the sorted array
    // output:
    //     x3: 1 if value is found, 0 if not found

    // INSERT YOUR CODE HERE

    br lr

////////////////////////
//                    //
//     printList      //
//                    //
////////////////////////

printList:
    // x0: start address
    // x1: length of array
    addi x3, xzr, #32       // x3 = ' '
    addi x4, xzr, #10       // x4 = '\n'
printList_loop:
    subis xzr, x1, #0       // if (x1 == 0) break
    b.eq printList_loopEnd  // break
    subi x1, x1, #1         // x1 = x1 - 1
    ldur x2, [x0, #0]       // x2 = x0->val
    putint x2               // print x2
    addi x0, x0, #8         // x0 = x0 + 8
    putchar x3              // print x3 ' '
    b printList_loop        // continue
printList_loopEnd:
    putchar x4              // print x4 '\n'
    br lr                   // return


////////////////////////
//                    //
//  helper functions  //
//                    //
////////////////////////
printSwapNumbers:
    lda x2, swap_test   // x0 = &swap_test
    ldur x0, [x2, #0]   // x1 = swap_test[0]
    ldur x1, [x2, #8]   // x2 = swap_test[1]
    addi x3, xzr, #32   // x3 = ' '
    addi x4, xzr, #10   // x4 = '\n'
    putint x0           // print x1
    putchar x3          // print ' '
    putint x1           // print x2
    putchar x4          // print '\n'
    br lr               // return
