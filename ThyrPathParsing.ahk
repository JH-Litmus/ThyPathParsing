^g::
	send ^c
	Winclose, test - �޸���
	fileappend, %Clipboard%`n, test.txt
	Run, Notepad test.txt
	return
	
+!t::
reload
return