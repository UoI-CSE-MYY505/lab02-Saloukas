
.data

array:  .word 1, 0, 1, 12, 0, 1, 4  

.text

    la a0, array    # Load base address of the array into a0
    li a1, 7        # Load the number of elements (7) into a1
    li a2, 1        # Load the search value (1) into a2

prog:
    mv t0, zero     # Initialize t0 to hold the last matching address (initially zero)
    mv t1, zero     # Initialize t1 to hold the index, starting from 0

loop:
    beq t1, a1, done     # If the index (t1) reaches the number of elements (a1), go to done
    slli t2, t1, 2       # Multiply index (t1) by 4 (to calculate the offset for 32-bit words)
    add t3, a0, t2       # Calculate the address of the current element (a0 + offset)
    lw t4, 0(t3)         # Load the current element into t4
    beq t4, a2, match    # If the current element matches a2, go to match
    addi t1, t1, 1       # Increment the index
    j loop               # Jump back to loop

match:
    mv t0, t3            # Store the current element's address as the last match
    addi t1, t1, 1       # Increment the index
    j loop               # Jump back to loop

done:
    mv s0, t0            # Move the address of the last matching element (or 0) into s0
    addi a7, zero, 10    
    ecall                
