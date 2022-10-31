## TextGrid2TXT ######################################################################################
##												    																																			##
## A script to convert a TextGrid file into a TXT file containing all labeled text segments         ##
## It is a good tool to use Praat transcriptions in other corpus-text tools.                        ##
## Pere Garau Borràs (2022) v. 1.1 								    	      																			##
## GNU License											    																														##
######################################################################################################

form Parse TextGrid to TXT file
  sentence Path ..\corpus_oral\arxius\
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
	intervals = Get number of intervals: tier
	appendInfoLine: ""
	for i to intervals
		select TextGrid 'file$'
		label$ = Get label of interval: tier, i
  		if label$ != pause$
			result$ = label$
			fileappend "'resultfile$'" 'result$'
		endfor
	select TextGrid 'file$'
	endif
	selectObject: "Strings fileList"
endfor
select all
Remove
appendInfoLine: "Feina feta!"
