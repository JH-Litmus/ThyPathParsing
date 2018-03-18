^g::
	send ^c
	Winclose, test - ¸Ş¸ğÀå
	fileappend, %Clipboard%`n, test.txt
	Run, Notepad test.txt
	return
	
+!t::
reload
return