ORG 100H    ; Starting address for code

; Main program
START:
    MOV AH, 09H
    MOV DX, OFFSET WELCOME_MSG
    INT 21H             ; Display welcome message

MAIN_MENU:
    MOV AH, 09H
    MOV DX, OFFSET MENU_MSG
    INT 21H             ; Display the menu options

    MOV AH, 01H         ; Wait for user input
    INT 21H             ; Get a single character input

    SUB AL, '0'         ; Convert ASCII input to number

    CMP AL, 1           ; Check if input is 1 (Add Car)
    JE ADD_CAR

    CMP AL, 2           ; Check if input is 2 (Remove Car)
    JE REMOVE_CAR

    CMP AL, 3           ; Check if input is 3 (Exit)
    JE END_PROGRAM

    JMP MAIN_MENU       ; Invalid input, show menu again

; Add a car
ADD_CAR:
    MOV AL, SLOTS       ; Load the number of free slots
    CMP AL, 0           ; Check if slots are available
    JE PARKING_FULL     ; Jump if parking is full
    DEC SLOTS           ; Decrease free slots by 1

    MOV AH, 09H
    MOV DX, OFFSET ADD_MSG
    INT 21H             ; Display "Car added"
    JMP SHOW_SLOTS

; Remove a car
REMOVE_CAR:
    MOV AL, SLOTS       ; Load the number of free slots
    CMP AL, 10          ; Check if parking is empty
    JE PARKING_EMPTY    ; Jump if parking is empty
    INC SLOTS           ; Increase free slots by 1

    MOV AH, 09H
    MOV DX, OFFSET REMOVE_MSG
    INT 21H             ; Display "Car removed"
    JMP SHOW_SLOTS

; Show available slots
SHOW_SLOTS:
    MOV AH, 09H
    MOV DX, OFFSET FREE_MSG
    INT 21H             ; Display "Free slots: "

    MOV AL, SLOTS
    CMP AL, 10          ; Check if number of slots is 10
    JE DISPLAY_TEN      ; If it's 10, display "10" properly

    ADD AL, '0'         ; Convert single digit to ASCII
    MOV DL, AL
    MOV AH, 02H
    INT 21H             ; Display the number of free slots
    JMP NEWLINE_LABEL

DISPLAY_TEN:
    MOV DL, '1'         ; Display '1' for 10
    MOV AH, 02H
    INT 21H             ; Display '1'
    MOV DL, '0'         ; Display '0' for 10
    MOV AH, 02H
    INT 21H             ; Display '0'

NEWLINE_LABEL:         ; Renamed label from NEWLINE
    MOV AH, 09H
    MOV DX, OFFSET NEWLINE_MSG
    INT 21H             ; Add a new line
    JMP MAIN_MENU

; Parking full message
PARKING_FULL:
    MOV AH, 09H
    MOV DX, OFFSET FULL_MSG
    INT 21H             ; Display "Parking is full!"
    JMP MAIN_MENU

; Parking empty message
PARKING_EMPTY:
    MOV AH, 09H
    MOV DX, OFFSET EMPTY_MSG
    INT 21H             ; Display "Parking is empty!"
    JMP MAIN_MENU

; End program
END_PROGRAM:
    MOV AH, 4CH
    INT 21H             ; Exit the program

; Data section
SLOTS DB 10            ; Total free parking slots (initially 10)
WELCOME_MSG DB 0DH, 0AH, 'Welcome to the Parking Management System', 0DH, 0AH, '$'
MENU_MSG DB 0DH, 0AH, 'Menu:', 0DH, 0AH, '1. Add Car', 0DH, 0AH, '2. Remove Car', 0DH, 0AH, '3. Exit', 0DH, 0AH, '$'
ADD_MSG DB 0DH, 0AH, 'Car added successfully!', 0DH, 0AH, '$'
REMOVE_MSG DB 0DH, 0AH, 'Car removed successfully!', 0DH, 0AH, '$'
FREE_MSG DB 0DH, 0AH, 'Free slots: ', '$'
FULL_MSG DB 0DH, 0AH, 'Parking is full!', 0DH, 0AH, '$'
EMPTY_MSG DB 0DH, 0AH, 'Parking is empty!', 0DH, 0AH, '$'
NEWLINE_MSG DB 0DH, 0AH ,'$'

END START
