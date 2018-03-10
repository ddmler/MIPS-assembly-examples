	.text
main:
	li $v0, 4
	la $a0, eina
	syscall

	li $v0, 5
	syscall

	move $s0, $v0		# A eingelesen

	li $v0, 4
	la $a0, einb
	syscall

	li $v0, 5
	syscall

	move $s1, $v0		# B eingelesen
	
	
check: 	div $s1, $s1, 2		# B / 2
	mfhi $s2		# Gibt Ergebnis für B Modulo 2
	beq $s1, 1, skip	# B = 1 springe zu skip
	beq $s2, 0, rechne	# B Modulo 2 = 0 springe zu rechne (gerade Zahl also nicht aufs Ergebnis addieren)
	add $t3, $t3, $s0	# Ergebnis + aktuelles A
rechne:	mul $s0, $s0, 2		# A*2									
	bne $s1, 1, check	# Zurück zur Sprungmarke, B ist noch nicht 1

skip:  	mul $s0, $s0, 2		# Letzter Schritt Verdopplung
	add $t3, $t3, $s0	# Letzter Schritt Addition

	li $v0, 4
	la $a0, ausy
	syscall

	li $v0, 1
	move $a0, $t3
	syscall
	li $v0, 10
	syscall			# Ergebnis ausgeben


	.data
eina:	.asciiz "Eingabe von a:	"
einb:	.asciiz "Eingabe von b:	"
ausy:	.asciiz "Ausgabe von y:	"
