## TextGrid2TXT ######################################################################################
##												    																																			##
## A script to convert a TextGrid file into a TXT file containing all labeled text segments         ##
## It is a good tool to use Praat transcriptions in other corpus-text tools.                        ##
## Pere Garau Borràs (2022) v. 1.2 								    	      																			##
## GNU License											    																														##
######################################################################################################

form Parse TextGrid to TXT file
  sentence Path ..\PI_complet\
  integer Tier 1
  sentence Pause xxx
endform

writeInfoLine: "Començam a transposar els TextGrids del directori: ", path$
Create Strings as file list: "fileList", path$+"*.TextGrid"

numberOfFiles = Get number of strings
appendInfoLine: "S'han trobat ", numberOfFiles, " arxius."

for ifile to numberOfFiles
	filename$ = Get string... ifile
	appendInfoLine: ifile, ".- ", filename$
	Read from file... 'path$''filename$'
	file$ = selected$ ("TextGrid", 1)
	resultfile$ = path$+file$+".txt"
	intervals = Get number of intervals... tier
	appendInfoLine: "L'arxiu té ", intervals, " intervals."
	for i from 1 to intervals
		select TextGrid 'file$'
		label$ = ""
		label$ = Get label of interval... tier i
  		if label$ != pause$
				result$ = label$ + newline$
				fileappend "'resultfile$'" 'result$'
			endif	
			label$ = ""
		endfor
	select TextGrid 'file$'
	selectObject: "Strings fileList"
endfor
select all
Remove
appendInfoLine: "Feina feta!"
